#!/bin/bash
# SWARM Pre-Task Hook - Optimized for parallel agent spawning

# Extract task description from input
TASK_DESC=$(cat | jq -r '.task_description // empty')
TASK_ID=$(date +%s)_$(head /dev/urandom | tr -dc a-z0-9 | head -c8)

# Function to analyze task complexity
analyze_complexity() {
    local desc="$1"
    local word_count=$(echo "$desc" | wc -w)
    
    # Keyword analysis for complexity
    if echo "$desc" | grep -qiE "epic|multi-feature|large-scale|comprehensive"; then
        echo "epic"
    elif echo "$desc" | grep -qiE "feature|implement|build|create" && [ $word_count -gt 20 ]; then
        echo "feature"
    elif echo "$desc" | grep -qiE "fix|debug|patch|hotfix"; then
        echo "bugfix"
    else
        echo "task"
    fi
}

# Function to spawn swarm based on complexity
spawn_optimized_swarm() {
    local complexity="$1"
    local topology="hierarchical"
    local max_agents=6
    local agents=()
    
    case "$complexity" in
        "epic")
            topology="hierarchical"
            max_agents=10
            agents=("epic-planner" "researcher" "architect" "security-expert")
            ;;
        "feature")
            topology="mesh"
            max_agents=6
            agents=("planner" "tester" "backend-coder" "frontend-coder" "reviewer")
            ;;
        "bugfix")
            topology="star"
            max_agents=3
            agents=("debugger" "tester" "reviewer")
            ;;
        *)
            topology="star"
            max_agents=4
            agents=("researcher" "coder" "reviewer")
            ;;
    esac
    
    # Initialize swarm with optimal configuration
    echo "🚀 Initializing $complexity swarm with $topology topology..."
    npx claude-flow@alpha swarm init \
        --topology "$topology" \
        --max-agents "$max_agents" \
        --strategy "specialized" &
    
    # Wait for swarm initialization
    sleep 2
    
    # Spawn all agents in parallel for maximum efficiency
    echo "🤖 Spawning ${#agents[@]} specialized agents in parallel..."
    for agent in "${agents[@]}"; do
        npx claude-flow@alpha agent spawn --type "$agent" &
    done
    
    # Wait for all agents to spawn
    wait
    
    echo "✅ Swarm ready with ${#agents[@]} agents"
}

# Main execution
COMPLEXITY=$(analyze_complexity "$TASK_DESC")
echo "📊 Task complexity: $COMPLEXITY"

# Store task metadata in memory
npx claude-flow@alpha memory store \
    --key "task/$TASK_ID/metadata" \
    --value "{\"description\":\"$TASK_DESC\",\"complexity\":\"$COMPLEXITY\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" \
    --namespace "tasks" \
    --ttl 86400

# Load relevant context from memory
echo "💾 Loading relevant context..."
CONTEXT=$(npx claude-flow@alpha memory search --pattern "*${TASK_DESC:0:20}*" --namespace "patterns" 2>/dev/null || echo "{}")

# Spawn optimized swarm
spawn_optimized_swarm "$COMPLEXITY"

# Return success response
echo '{"continue": true, "swarmInitialized": true, "taskId": "'$TASK_ID'", "complexity": "'$COMPLEXITY'"}'