#!/bin/bash
# SWARM Post-Edit Hook - Optimized formatting and pattern learning

# Extract file path from input
FILE_PATH=$(cat | jq -r '.tool_input.file_path // .tool_input.path // empty')

# Skip if no file path
if [ -z "$FILE_PATH" ]; then
    echo '{"continue": true, "reason": "No file path provided"}'
    exit 0
fi

# Function to detect file type and apply formatting
format_file() {
    local file="$1"
    local ext="${file##*.}"
    local formatted=false
    
    case "$ext" in
        "py")
            # Python formatting with black and isort
            if command -v black &> /dev/null; then
                black "$file" --quiet 2>/dev/null && formatted=true
            fi
            if command -v isort &> /dev/null; then
                isort "$file" --quiet 2>/dev/null && formatted=true
            fi
            ;;
        "js"|"jsx"|"ts"|"tsx")
            # JavaScript/TypeScript formatting with prettier
            if [ -f "node_modules/.bin/prettier" ]; then
                node_modules/.bin/prettier --write "$file" --loglevel error 2>/dev/null && formatted=true
            elif command -v prettier &> /dev/null; then
                prettier --write "$file" --loglevel error 2>/dev/null && formatted=true
            fi
            ;;
        "go")
            # Go formatting
            if command -v gofmt &> /dev/null; then
                gofmt -w "$file" 2>/dev/null && formatted=true
            fi
            ;;
        "rs")
            # Rust formatting
            if command -v rustfmt &> /dev/null; then
                rustfmt "$file" 2>/dev/null && formatted=true
            fi
            ;;
        "json")
            # JSON formatting with jq
            if command -v jq &> /dev/null; then
                jq . "$file" > "$file.tmp" && mv "$file.tmp" "$file" 2>/dev/null && formatted=true
            fi
            ;;
    esac
    
    echo "$formatted"
}

# Function to extract and store code patterns
learn_patterns() {
    local file="$1"
    local ext="${file##*.}"
    
    # Extract patterns based on file type
    case "$ext" in
        "py")
            # Python patterns
            patterns=$(grep -E "(def |class |import |from .* import)" "$file" | head -20)
            ;;
        "js"|"ts")
            # JavaScript/TypeScript patterns
            patterns=$(grep -E "(function |const |import |export |class )" "$file" | head -20)
            ;;
        *)
            patterns=""
            ;;
    esac
    
    if [ -n "$patterns" ]; then
        # Store patterns in memory for future reference
        pattern_key="patterns/$(basename "$file" | sed 's/\.[^.]*$//')"
        npx claude-flow@alpha memory store \
            --key "$pattern_key" \
            --value "{\"file\":\"$file\",\"patterns\":\"$patterns\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" \
            --namespace "code_patterns" \
            --ttl 604800 &  # 7 days, run in background
    fi
}

# Function to update file metrics
update_metrics() {
    local file="$1"
    local lines=$(wc -l < "$file" 2>/dev/null || echo 0)
    local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
    
    # Store metrics in memory
    metric_key="metrics/files/$(echo "$file" | sed 's/\//_/g')"
    npx claude-flow@alpha memory store \
        --key "$metric_key" \
        --value "{\"lines\":$lines,\"size\":$size,\"last_modified\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" \
        --namespace "file_metrics" \
        --ttl 86400 &  # 1 day, run in background
}

# Main execution
echo "📝 Processing post-edit for: $FILE_PATH"

# Format file if applicable
FORMATTED=$(format_file "$FILE_PATH")
if [ "$FORMATTED" = "true" ]; then
    echo "✨ File formatted successfully"
fi

# Learn patterns in background
learn_patterns "$FILE_PATH" &

# Update metrics in background
update_metrics "$FILE_PATH" &

# Wait for background jobs (with timeout)
timeout 2s wait 2>/dev/null || true

# Return success response
echo '{"continue": true, "formatted": '$FORMATTED', "file": "'$FILE_PATH'"}'