#!/bin/bash
# Hook Integration Test Script

echo "🧪 Testing Claude Code Hooks Integration with SWARM"
echo "================================================="

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0

# Function to test a hook
test_hook() {
    local name="$1"
    local command="$2"
    local expected="$3"
    
    echo -n "Testing $name... "
    
    # Run the hook command
    result=$($command 2>&1)
    exit_code=$?
    
    if [ $exit_code -eq 0 ] && [[ "$result" == *"$expected"* ]]; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAILED${NC}"
        echo "  Expected: $expected"
        echo "  Got: $result"
        ((FAILED++))
    fi
}

# Test 1: Pre-Task Hook
echo -e "\n${YELLOW}1. Testing Pre-Task Hook${NC}"
test_hook "Pre-Task Hook" \
    "echo '{\"task_description\": \"Build authentication system\"}' | ./.claude/hooks/swarm-pre-task.sh" \
    "swarmInitialized"

# Test 2: Post-Edit Hook
echo -e "\n${YELLOW}2. Testing Post-Edit Hook${NC}"
test_hook "Post-Edit Hook" \
    "echo '{\"tool_input\": {\"file_path\": \"test.py\"}}' | ./.claude/hooks/swarm-post-edit.sh" \
    "continue"

# Test 3: Session-End Hook
echo -e "\n${YELLOW}3. Testing Session-End Hook${NC}"
test_hook "Session-End Hook" \
    "./.claude/hooks/swarm-session-end.sh" \
    "state_persisted"

# Test 4: Claude Flow Hook Commands
echo -e "\n${YELLOW}4. Testing Claude Flow Hook Commands${NC}"
test_hook "Pre-Edit Command" \
    "npx claude-flow@alpha hooks pre-edit --file test.js --test" \
    "hook"

test_hook "Session-End Command" \
    "npx claude-flow@alpha hooks session-end --test" \
    "hook"

# Test 5: Memory Integration
echo -e "\n${YELLOW}5. Testing Memory Integration${NC}"
test_hook "Memory Store" \
    "npx claude-flow@alpha memory store --key test_key --value test_value --namespace test" \
    "stored"

test_hook "Memory Retrieve" \
    "npx claude-flow@alpha memory retrieve --key test_key --namespace test" \
    "test_value"

# Test 6: Hook Configuration Validation
echo -e "\n${YELLOW}6. Testing Hook Configuration${NC}"
if [ -f ".claude/settings.json" ]; then
    hooks_enabled=$(cat .claude/settings.json | jq -r '.env.CLAUDE_FLOW_HOOKS_ENABLED // "false"')
    if [ "$hooks_enabled" = "true" ]; then
        echo -e "Hooks Enabled: ${GREEN}✓ YES${NC}"
        ((PASSED++))
    else
        echo -e "Hooks Enabled: ${RED}✗ NO${NC}"
        ((FAILED++))
    fi
else
    echo -e "Settings file: ${RED}✗ NOT FOUND${NC}"
    ((FAILED++))
fi

# Test 7: Variable Interpolation
echo -e "\n${YELLOW}7. Testing Variable Interpolation${NC}"
# Check if settings.json uses correct variable format
if grep -q '\$CLAUDE_' .claude/settings.json 2>/dev/null || grep -q '\${CLAUDE_' .claude/settings.json 2>/dev/null; then
    echo -e "Variable Format: ${GREEN}✓ CORRECT${NC}"
    ((PASSED++))
else
    echo -e "Variable Format: ${YELLOW}⚠ May need fix-hook-variables${NC}"
    echo "  Run: npx claude-flow@alpha fix-hook-variables .claude/settings.json"
fi

# Summary
echo -e "\n${YELLOW}========== Test Summary ==========${NC}"
echo -e "Total Tests: $((PASSED + FAILED))"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "\n${GREEN}✅ All tests passed! Hooks are properly integrated.${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed. Please check the configuration.${NC}"
    exit 1
fi