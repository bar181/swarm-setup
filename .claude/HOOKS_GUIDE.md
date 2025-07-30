# Hooks Guide - Optimized for SWARM

## Quick Reference

### Enable Hooks
```bash
# Already enabled in settings.json
cat .claude/settings.json | jq '.env.CLAUDE_FLOW_HOOKS_ENABLED'
```

### Available Hooks

| Hook | Script | Purpose |
|------|--------|----------|
| Pre-Task | `swarm-pre-task.sh` | Auto-spawn agents based on complexity |
| Post-Edit | `swarm-post-edit.sh` | Format code & learn patterns |
| Session-End | `swarm-session-end.sh` | Save state & generate summary |

### Test Hooks
```bash
./.claude/hooks/test-hooks.sh
```

## Usage Examples

### Creating GitHub Issue
```bash
Think harder about [FEATURE]. Research, then create comprehensive GitHub issue.
# Triggers: pre-task → spawns planner + 6 personas
```

### Implementing from Issue
```bash
Implement issue #X using TDD approach.
# Triggers: pre-task → spawns tester, coder, reviewer
```

### File Editing
```bash
Edit auth.py
# Triggers: pre-edit → assigns Python specialist
# Triggers: post-edit → formats with black
```

## Hook Scripts Location

All executable hooks are in `.claude/hooks/`:
- `swarm-pre-task.sh` - Analyzes task complexity, spawns appropriate swarm
- `swarm-post-edit.sh` - Formats files, extracts patterns
- `swarm-session-end.sh` - Generates summary, persists state
- `test-hooks.sh` - Validates hook integration

## Configuration

Hooks are configured in `.claude/settings.json`. Key settings:
- `CLAUDE_FLOW_HOOKS_ENABLED`: "true"
- `CLAUDE_FLOW_SWARM_HOOKS`: "true"
- `CLAUDE_FLOW_AUTO_ASSIGN_AGENTS`: "true"

## Troubleshooting

```bash
# Check if hooks are working
export CLAUDE_FLOW_DEBUG=true

# Fix variable interpolation issues
npx claude-flow@alpha fix-hook-variables

# Disable hooks temporarily
export CLAUDE_FLOW_HOOKS_ENABLED=false
```