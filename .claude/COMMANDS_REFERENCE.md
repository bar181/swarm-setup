# COMMANDS_REFERENCE.md - Claude Flow Commands Directory Guide

## ⚠️ IMPORTANT: Use Custom Documentation First

**The commands in `.claude/commands/` are Claude Flow defaults and should be used as FALLBACK ONLY.**

Our custom documentation in `.claude/` takes precedence:
- ✅ Use `.claude/OPTIMAL_SWARM_WORKFLOW.md` 
- ✅ Use `.claude/DEVELOPER_CHEATSHEET.md`
- ✅ Use `.claude/agents/` custom agents
- ❌ Avoid `.claude/commands/` unless specifically needed

## 📁 Commands Directory Structure

### ❌ DEPRECATED - Do Not Use
These folders contain default Claude Flow patterns that are **184% less efficient** than our custom approach:

```
commands/
├── sparc/              # ❌ AVOID - Use our custom workflow instead
├── swarm/              # ❌ AVOID - Use our custom agents
├── workflows/          # ❌ AVOID - Use our OPTIMAL_SWARM_WORKFLOW.md
└── training/           # ❌ AVOID - Not needed with custom agents
```

### ⚠️ Use With Caution (Fallback Only)
These might be useful in specific scenarios but check our custom docs first:

```
commands/
├── github/             # ⚠️ Some GitHub integration commands
│   ├── swarm-issue.md  # May be useful for issue creation
│   └── pr-manager.md   # May be useful for PR management
├── memory/             # ⚠️ Memory management tools
│   └── usage.md        # Useful for persistence
├── monitoring/         # ⚠️ Status tracking
│   └── status.md       # Token usage monitoring
└── analysis/           # ⚠️ Performance analysis
    └── token-efficiency.md  # Cost tracking
```

### ✅ Potentially Useful (After Reviewing)
These align with our methodology and may complement our custom approach:

```
commands/
├── coordination/       # Basic MCP tool usage
│   └── orchestrate.md  # mcp__claude-flow__task_orchestrate
├── hooks/              # Automation hooks
│   └── setup.md        # Pre/post execution hooks
└── optimization/       # Performance patterns
    └── parallel-execution.md  # Aligns with our parallel approach
```

## 🔧 When to Use Commands

### 1. GitHub Integration (Use Selectively)
```bash
# ONLY if our custom GitHub issue creation doesn't meet needs
/github/swarm-issue  # Creates issues from swarms

# Better: Use our 6-persona planning approach
@planner create comprehensive GitHub issue with 6 personas
```

### 2. Memory Operations (Use for Persistence)
```bash
# Useful for cross-session memory
/memory/usage  # Access persistent SQLite memory

# Integrate with our custom workflow
@researcher save findings to memory AND /docs/phases/
```

### 3. Token Monitoring (Use for Cost Tracking)
```bash
# Good for tracking costs
/analysis/token-efficiency  # Monitor token usage

# Combine with our success metrics
Target: <$10 per feature
```

## 🚫 Never Use These Commands

### SPARC Methodology
- `/sparc` - Replaced by our OPTIMAL_SWARM_WORKFLOW
- `/sparc/*` - All SPARC modes are deprecated
- Use our Research → Planning → TDD flow instead

### Default Swarm Patterns  
- `/swarm/development` - Use our custom agents
- `/swarm/research` - Use our @researcher agent
- `/swarm/testing` - Use our @tester with TDD

### Training Commands
- `/training/*` - Our agents are pre-configured
- No need for neural training or specialization

## 📋 Quick Reference

### If you're looking for...

| Need | Don't Use | Use Instead |
|------|-----------|-------------|
| Development workflow | `/workflows/development` | `.claude/OPTIMAL_SWARM_WORKFLOW.md` |
| Research approach | `/swarm/research` | `@researcher` custom agent |
| Testing strategy | `/swarm/testing` | TDD with `@tester` agent |
| Task coordination | `/sparc/orchestrator` | `@planner` with 6 personas |
| Code review | `/sparc/reviewer` | `@reviewer` custom agent |
| Performance optimization | `/sparc/optimizer` | Check existing patterns first |

## 💡 Integration Pattern

When you must use a command from `/commands/`:

```bash
# 1. Check our custom docs first
cat .claude/DEVELOPER_CHEATSHEET.md | grep [TASK]

# 2. If not found, check if command adds value
cat .claude/commands/[category]/[command].md

# 3. Use command but adapt to our patterns
/[command] --adapted-to-our-workflow

# 4. Document why you needed it
echo "Used /[command] because [reason]" >> /docs/decisions.md
```

## 🎯 Remember

- Our custom SWARM agents are **184% more efficient**
- The `/commands/` directory is Claude Flow defaults
- Always prefer our documented patterns
- Use commands only when they add unique value
- Document any command usage for team awareness

---

**Bottom Line**: The `.claude/commands/` directory exists for compatibility but our custom approach in `.claude/*.md` should be your primary reference.