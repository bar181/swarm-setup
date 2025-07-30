#!/bin/bash
# MCP Candidate Detection Script

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to analyze folder for MCP potential
analyze_mcp_potential() {
    local dir="$1"
    local impl_count=$(find "$dir" -mindepth 1 -maxdepth 1 -type d | wc -l)
    local has_interface=false
    local has_similar_structure=false
    
    # Check for interface files
    for interface in "interface.ts" "base.py" "contract.go" "provider.ts" "adapter.py"; do
        if [ -f "$dir/$interface" ] || [ -f "$dir/../$interface" ]; then
            has_interface=true
            break
        fi
    done
    
    # Check structure similarity (simplified check)
    local structure_patterns=$(find "$dir" -mindepth 2 -maxdepth 2 -type f -name "*.ts" -o -name "*.py" -o -name "*.go" | \
                              sed "s|$dir/[^/]*/||" | sort | uniq -c | awk '$1 >= 2' | wc -l)
    
    if [ $structure_patterns -gt 2 ]; then
        has_similar_structure=true
    fi
    
    # Calculate MCP score
    local score=0
    [ $impl_count -ge 3 ] && ((score++))
    [ "$has_interface" = true ] && ((score++))
    [ "$has_similar_structure" = true ] && ((score++))
    
    # Report findings
    if [ $score -ge 2 ]; then
        echo -e "${GREEN}✓ Strong MCP Candidate${NC}: $dir"
        echo "  - Implementations: $impl_count"
        echo "  - Has Interface: $has_interface"
        echo "  - Similar Structure: $has_similar_structure"
        echo "  - MCP Score: $score/3"
        echo ""
        return 0
    elif [ $score -eq 1 ]; then
        echo -e "${YELLOW}⚡ Potential MCP Candidate${NC}: $dir"
        echo "  - Score: $score/3 (consider refactoring)"
        echo ""
        return 1
    fi
    
    return 2
}

# Function to generate MCP configuration
generate_mcp_config() {
    local dir="$1"
    local name=$(basename "$dir")
    
    cat > "$dir/mcp.config.json" << EOF
{
  "name": "${name}-mcp",
  "version": "1.0.0",
  "description": "MCP server for ${name} implementations",
  "server": {
    "command": ["node", "./mcp/server.js"],
    "env": {
      "NODE_ENV": "production"
    }
  },
  "capabilities": {
    "methods": ["list", "execute", "configure"],
    "features": ["streaming", "cancellation"]
  }
}
EOF
    
    echo -e "${BLUE}Generated MCP config${NC}: $dir/mcp.config.json"
}

# Main execution
echo -e "${BLUE}🔍 Scanning for MCP candidates...${NC}\n"

# Common patterns to check
patterns=(
    "providers"
    "adapters"
    "connectors"
    "plugins"
    "integrations"
    "handlers"
    "processors"
    "transformers"
)

# Find directories matching patterns
for pattern in "${patterns[@]}"; do
    find . -type d -name "*${pattern}*" -not -path "*/node_modules/*" -not -path "*/.git/*" | while read dir; do
        # Skip if too deep
        depth=$(echo "$dir" | tr -cd '/' | wc -c)
        [ $depth -gt 5 ] && continue
        
        # Analyze the directory
        if analyze_mcp_potential "$dir"; then
            # Optionally generate MCP config
            read -p "Generate MCP config for $dir? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                generate_mcp_config "$dir"
            fi
        fi
    done
done

echo -e "\n${GREEN}✅ MCP candidate scan complete${NC}"