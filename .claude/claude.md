# CLAUDE.md - Master Project Instructions for Claude Code

## 🏗️ Project Structure

```
project/
├── .claude/
│   ├── CLAUDE.md                           # This file
│   ├── OPTIMAL_SWARM_WORKFLOW.md           # Master execution guide
│   ├── SWARM_EXECUTION_GUIDE.md            # Detailed step-by-step
│   ├── DEVELOPER_CHEATSHEET.md             # Quick reference
│   ├── SWARM_BEST_PRACTICES.md             # Real-world lessons (184% savings)
│   ├── AGENT_CREATION_GUIDE.md             # How to build custom agents
│   ├── CLAUDE_MODEL_REFERENCE.md           # Sonnet vs Opus selection
│   ├── PHASE_ORCHESTRATION.md              # Research-first methodology
│   ├── EPIC_BREAKDOWN_EXAMPLES.md          # Large project patterns
│   ├── claude-flow-agents-analysis.md      # Which defaults to avoid
│   └── agents/                             # Agent definitions
│       ├── researcher.md
│       ├── epic-planner.md      # ✅ Created - Epic decomposition specialist
│       ├── planner.md
│       ├── product-owner.md
│       ├── project-manager.md
│       ├── senior-developer.md
│       ├── test-writer.md
│       ├── frontend-expert.md
│       ├── security-expert.md
│       ├── tester.md
│       ├── backend-coder.md
│       ├── frontend-coder.md
│       └── reviewer.md
├── docs/
│   ├── phases/                             # Phase documentation
│   │   └── phase-x/
│   │       ├── research/                   # Research findings
│   │       ├── issues/                     # Generated GitHub issues
│   │       └── implementation/             # Code artifacts
│   └── epics/                              # Epic breakdowns
└── .github/
    └── ISSUE_TEMPLATE/
        ├── swarm-epic.yml
        └── swarm-task.yml
```

## 📚 Documentation Overview

### Core Workflow Guides
- **OPTIMAL_SWARM_WORKFLOW.md** - Complete guide from requirements to deployment
- **SWARM_EXECUTION_GUIDE.md** - Explicit instructions for AI execution
- **DEVELOPER_CHEATSHEET.md** - Daily quick reference and prompts
- **SWARM_BEST_PRACTICES.md** - Proven patterns with 184% cost savings

### Agent Management
- **AGENT_CREATION_GUIDE.md** - Build custom agents, avoid defaults
- **CLAUDE_MODEL_REFERENCE.md** - When to use Sonnet 4 vs Opus 4
- **claude-flow-agents-analysis.md** - Analysis of 64 default agents

### Planning Tools
- **PHASE_ORCHESTRATION.md** - Research-first, 6-persona approach
- **EPIC_BREAKDOWN_EXAMPLES.md** - Decomposing large projects

### Commands Reference
- **COMMANDS_REFERENCE.md** - Guide to `.claude/commands/` directory
- **⚠️ Important**: The `commands/` folder contains Claude Flow defaults - use as fallback only
- **Always prefer** our custom documentation over default commands

### Memory System
- **MEMORY_SYSTEM_GUIDE.md** - SQLite-based persistent memory
- **Key Feature**: Cross-session knowledge retention
- **Use for**: Research findings, decisions, patterns, coordination

### Architecture & Design
- **MODULAR_DESIGN.md** - Modular architecture for SWARM projects
- **Key Concepts**: Vertical slices, module independence, contracts
- **Use for**: Structuring large projects into manageable modules

## 🚀 Quick Start

1. **For new features**: Start with PHASE_ORCHESTRATION.md
2. **For daily work**: Use DEVELOPER_CHEATSHEET.md
3. **For custom agents**: Follow AGENT_CREATION_GUIDE.md
4. **For optimization**: Review SWARM_BEST_PRACTICES.md

## 🎯 The Optimal Workflow

```bash
# Phase 1: Research (Always First!)
@researcher investigate [FEATURE] and save to /docs/phases/[phase]/research/

# Phase 2: Multi-Persona Planning
Think harder: spawn 6 personas to create comprehensive GitHub issue

# Phase 3: TDD Implementation
@tester create failing tests first
@coder implement to pass tests
@reviewer ensure quality and security
```

## 💡 Key Principles

1. **Custom agents are 184% more efficient** than defaults
2. **Research first** - 30 minutes saves days of rework
3. **6-persona planning** - Comprehensive coverage
4. **TDD always** - Tests before code
5. **Parallel execution** - Use up to 10 agents

## 🛠️ Claude Flow Integration

Use Claude Flow for infrastructure only:
- ✅ MCP tools (Supabase, Playwright, GitHub)
- ✅ Memory persistence
- ✅ Token monitoring
- ❌ Default agents (use your custom ones)

```bash
# Initialize minimal Claude Flow
npx claude-flow@alpha init --minimal --no-agents
```

## 📊 Success Metrics

- Test coverage: >95%
- Cost per feature: <$10
- Time to complete: <estimated × 1.2
- Revision cycles: <10%

## 🔗 File References

When executing tasks, reference these files in order:
1. Check this CLAUDE.md for overview
2. Use PHASE_ORCHESTRATION.md for research approach
3. Follow SWARM_EXECUTION_GUIDE.md for implementation
4. Reference DEVELOPER_CHEATSHEET.md for quick commands
5. Apply SWARM_BEST_PRACTICES.md for optimization

Remember: This is your single source of truth. All other files support this master structure.