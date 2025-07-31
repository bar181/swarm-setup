# CLAUDE.md - Master Project Instructions for Claude Code

## 🏗️ Project Structure

```
project/
├── .claude/
│   ├── CLAUDE.md                           # This file
│   ├── guides/OPTIMAL_SWARM_WORKFLOW.md    # Master execution guide
│   ├── SWARM_EXECUTION_GUIDE.md            # Detailed step-by-step
│   ├── guides/DEVELOPER_CHEATSHEET.md      # Quick reference
│   ├── guides/SWARM_BEST_PRACTICES.md      # Real-world lessons and patterns
│   ├── development/AGENT_CREATION_GUIDE.md # How to build custom agents
│   ├── references/CLAUDE_MODEL_REFERENCE.md # Sonnet vs Opus selection
│   ├── guides/PHASE_ORCHESTRATION.md       # Research-first methodology
│   ├── development/EPIC_BREAKDOWN_EXAMPLES.md # Large project patterns
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
│       ├── reviewer.md
│       └── modular-designer.md  # ✅ Created - Module organization specialist
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
- **guides/OPTIMAL_SWARM_WORKFLOW.md** - Complete guide from requirements to deployment
- **SWARM_EXECUTION_GUIDE.md** - Explicit instructions for AI execution
- **guides/DEVELOPER_CHEATSHEET.md** - Daily quick reference and prompts
- **guides/SWARM_BEST_PRACTICES.md** - Proven patterns for efficient development

### Agent Management
- **development/AGENT_CREATION_GUIDE.md** - Build custom agents, avoid defaults
- **references/CLAUDE_MODEL_REFERENCE.md** - When to use Sonnet 4 vs Opus 4
- **claude-flow-agents-analysis.md** - Analysis of 64 default agents

### Planning Tools
- **guides/PHASE_ORCHESTRATION.md** - Research-first, 6-persona approach
- **development/EPIC_BREAKDOWN_EXAMPLES.md** - Decomposing large projects

### Commands Reference
- **references/COMMANDS_REFERENCE.md** - Guide to `.claude/commands/` directory
- **⚠️ Important**: The `commands/` folder contains Claude Flow defaults - use as fallback only
- **Always prefer** our custom documentation over default commands

### Memory System
- **guides/MEMORY_SYSTEM_GUIDE.md** - SQLite-based persistent memory
- **Key Feature**: Cross-session knowledge retention
- **Use for**: Research findings, decisions, patterns, coordination

### MCP Integration
- **references/MCP_BEST_PRACTICES.md** - How to use 87 claude-flow MCP tools
- **Key Feature**: Comprehensive tool ecosystem
- **Use for**: Swarm coordination, neural training, workflow automation

### Architecture & Design
- **development/MODULAR_DESIGN.md** - Modular architecture for SWARM projects
- **Key Concepts**: Vertical slices, module independence, contracts
- **Use for**: Structuring large projects into manageable modules

## 🚀 Quick Start

1. **For new features**: Start with guides/PHASE_ORCHESTRATION.md
2. **For daily work**: Use guides/DEVELOPER_CHEATSHEET.md
3. **For custom agents**: Follow development/AGENT_CREATION_GUIDE.md
4. **For optimization**: Review guides/SWARM_BEST_PRACTICES.md

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

1. **Custom agents provide better control and predictability** than defaults
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
2. Use guides/PHASE_ORCHESTRATION.md for research approach
3. Follow SWARM_EXECUTION_GUIDE.md for implementation
4. Reference guides/DEVELOPER_CHEATSHEET.md for quick commands
5. Apply guides/SWARM_BEST_PRACTICES.md for optimization

Remember: This is your single source of truth. All other files support this master structure.