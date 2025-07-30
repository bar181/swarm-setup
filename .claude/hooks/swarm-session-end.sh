#!/bin/bash
# SWARM Session End Hook - Generate summary and persist state

# Function to generate session summary
generate_summary() {
    echo "📊 Generating session summary..."
    
    # Collect metrics from current session
    local tasks_completed=$(npx claude-flow@alpha memory search --pattern "task/*/metadata" --namespace "tasks" 2>/dev/null | jq 'length' || echo 0)
    local patterns_learned=$(npx claude-flow@alpha memory search --pattern "*" --namespace "code_patterns" 2>/dev/null | jq 'length' || echo 0)
    local files_modified=$(npx claude-flow@alpha memory search --pattern "*" --namespace "file_metrics" 2>/dev/null | jq 'length' || echo 0)
    
    # Get active swarms
    local active_swarms=$(npx claude-flow@alpha swarm status --format json 2>/dev/null || echo '[]')
    local swarm_count=$(echo "$active_swarms" | jq 'length' || echo 0)
    
    # Generate summary
    cat > /tmp/session_summary.md << EOF
# Session Summary - $(date -u +%Y-%m-%dT%H:%M:%SZ)

## 📈 Session Metrics
- Tasks Completed: $tasks_completed
- Patterns Learned: $patterns_learned
- Files Modified: $files_modified
- Active Swarms: $swarm_count

## 🐝 Swarm Activity
$(echo "$active_swarms" | jq -r '.[] | "- \(.id): \(.topology) topology with \(.agents | length) agents"' 2>/dev/null || echo "No active swarms")

## 💡 Key Insights
- Most used agent types: $(npx claude-flow@alpha agent metrics --top 3 --format list 2>/dev/null || echo "N/A")
- Average task completion time: $(npx claude-flow@alpha metrics tasks --average-time 2>/dev/null || echo "N/A")
- Memory usage: $(npx claude-flow@alpha memory usage --format human 2>/dev/null || echo "N/A")

## 🔄 Next Session Recommendations
- Continue with pending tasks in queue
- Review learned patterns for optimization
- Consider scaling swarm size based on workload
EOF
    
    echo "✅ Summary generated at /tmp/session_summary.md"
}

# Function to persist swarm state
persist_state() {
    echo "💾 Persisting swarm state..."
    
    # Create state directory
    STATE_DIR="$HOME/.claude-flow/state/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$STATE_DIR"
    
    # Export swarm configurations
    npx claude-flow@alpha swarm export --output "$STATE_DIR/swarms.json" 2>/dev/null
    
    # Export memory state
    npx claude-flow@alpha memory export --output "$STATE_DIR/memory.db" 2>/dev/null
    
    # Export metrics
    npx claude-flow@alpha metrics export --output "$STATE_DIR/metrics.json" 2>/dev/null
    
    # Store session metadata
    cat > "$STATE_DIR/session.json" << EOF
{
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "duration_seconds": "${SESSION_DURATION:-0}",
    "claude_version": "$(claude --version 2>/dev/null || echo 'unknown')",
    "claude_flow_version": "$(npx claude-flow@alpha --version 2>/dev/null || echo 'unknown')"
}
EOF
    
    echo "✅ State persisted to $STATE_DIR"
}

# Function to cleanup resources
cleanup_resources() {
    echo "🧹 Cleaning up resources..."
    
    # Clean old memory entries (older than 30 days)
    npx claude-flow@alpha memory cleanup --older-than 30d --namespace "*" &
    
    # Compact memory database
    npx claude-flow@alpha memory compact &
    
    # Clean temporary files
    find /tmp/swarm -type f -mtime +1 -delete 2>/dev/null || true
    
    wait
    echo "✅ Cleanup completed"
}

# Function to export metrics
export_metrics() {
    echo "📊 Exporting session metrics..."
    
    # Create metrics report
    METRICS_FILE="/tmp/session_metrics_$(date +%Y%m%d_%H%M%S).json"
    
    cat > "$METRICS_FILE" << EOF
{
    "session": {
        "end_time": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
        "duration": "${SESSION_DURATION:-0}"
    },
    "performance": {
        "average_hook_execution_ms": $(npx claude-flow@alpha metrics hooks --average 2>/dev/null || echo 0),
        "total_api_calls": $(npx claude-flow@alpha metrics api --count 2>/dev/null || echo 0),
        "cache_hit_rate": $(npx claude-flow@alpha metrics cache --hit-rate 2>/dev/null || echo 0)
    },
    "resources": {
        "peak_memory_mb": $(npx claude-flow@alpha metrics memory --peak 2>/dev/null || echo 0),
        "total_tokens_used": $(npx claude-flow@alpha metrics tokens --total 2>/dev/null || echo 0),
        "estimated_cost_usd": $(npx claude-flow@alpha metrics cost --estimate 2>/dev/null || echo 0)
    }
}
EOF
    
    echo "✅ Metrics exported to $METRICS_FILE"
}

# Main execution
echo "🏁 Executing session-end hook..."

# Run all tasks in parallel for efficiency
generate_summary &
persist_state &
export_metrics &

# Wait for critical tasks
wait

# Cleanup in background (non-critical)
cleanup_resources &

# Return success response
echo '{"continue": true, "summary": "/tmp/session_summary.md", "state_persisted": true}'