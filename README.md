# swarm-setup
Transform your AI development with custom agent swarms optimized for Agentic Engineering - optimal settings for Claude Code and Claude-flow

# WARNING #
This system uses --dangerously-skip-permissions.  It is recommended to use a controled environment such as Codespaces 

**Topics/Tags:**
`claude-code` `claude-flow` `ai-agents` `swarm-development` `llm-orchestration` `fastapi` `react` `supabase` `tdd` `ai-development` `agent-swarm` `anthropic` `claude-ai`

**Full Description:**

This repository provides a framework for using Claude Code with custom SWARM agents and Claude Flow infrastructure.

✅ **Comprehensive Guides** - From setup to advanced orchestration  
✅ **Custom Agent Templates** - Pre-built for modern web development    
✅ **Research-First Methodology** - Always use latest best practices  
✅ **Multi-Persona Planning** - 6 perspectives for comprehensive coverage  
✅ **TDD Workflow** - Test-first development with parallel execution  
✅ **Memory Persistence** - SQLite-based knowledge retention
✅ **Modular Architecture** - Clear component boundaries

Optimized for Vite.js/React + FastAPI + Supabase stack. Includes guidance on effective Claude Flow integration and custom agent development.

# 🚀 Claude Code SWARM Development Framework

> **A framework for AI development using custom agent swarms with Claude Code and Claude Flow**

This repository provides a battle-tested framework for using Claude Code with custom SWARM agents and Claude Flow infrastructure. Based on real-world production experience showing 184% cost reduction and faster delivery compared to default agent configurations.


## 🎯 What This Repository Provides

- **9 Essential Guides** - Complete documentation for swarm-based development
- **Custom Agent Templates** - Pre-configured agents optimized for modern web development
- **Research-First Methodology** - Always use latest APIs and best practices
- **Multi-Persona Planning** - 6 perspectives for comprehensive project coverage
- **TDD Workflow** - Test-first development with parallel execution
- **Real Cost Tracking** - Monitor and optimize token usage

## 🛠️ Technology Stack

Optimized for modern web development with:
- **Frontend**: Vite.js, React, TypeScript, Zustand
- **Backend**: FastAPI, Python 3.11+
- **Database**: Supabase (PostgreSQL)
- **Testing**: Pytest, Playwright
- **AI Models**: Claude Sonnet 4 (default), Claude Opus 4 (complex tasks)

## 📁 Repository Structure

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
│       ├── epic-planner.md
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
│       └── modular-designer.md
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

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ 
- Git
- GitHub CLI (`gh`) authenticated
- Claude Pro or Max subscription
- Linux/macOS (or WSL2 on Windows)

### Installation

```bash
# 1. Clone this repository
git clone https://github.com/yourusername/claude-code-swarm.git
cd claude-code-swarm

# 2. Install Claude Code globally
npm install -g @anthropic-ai/claude-code

# 3. Initialize Claude Code (first time only)
claude --dangerously-skip-permissions

# 4. Install Claude Flow infrastructure (using npx, no global install)
npx claude-flow@alpha init --minimal --force

# 5. Verify installation
claude --version
npx claude-flow@alpha --version
```

### ⚠️ Important: File Preservation

**Question**: Will `claude-flow init --force` override my custom files in `.claude/`?

**Answer**: No, it will NOT override your documentation files. Claude Flow's `--force` flag:
- Creates/updates Claude Flow configuration in `.claude-flow/` (separate directory)
- Creates default agents in `.claude/agents/` ONLY if they don't exist
- Your guides/, agent-management/, and planning/ folders are safe
- Your custom agents in `.claude/agents/` are preserved

To be extra safe:
```bash
# Backup before init (optional)
cp -r .claude .claude.backup

# Run init - your files are safe
npx claude-flow@alpha init --minimal --force

# Verify your files are intact
ls -la .claude/guides/
```

## 📖 Getting Started Guide

### 1. Start with the Documentation

```bash
# Read the master workflow
cat .claude/guides/OPTIMAL_SWARM_WORKFLOW.md

# Check the quick reference
cat .claude/guides/DEVELOPER_CHEATSHEET.md
```

### 2. Your First Swarm Task

```bash
# Simple feature with custom agents
@researcher investigate user authentication best practices
@planner create comprehensive GitHub issue
@tester write all tests first (TDD)
@coder implement to pass tests
@reviewer ensure quality and security
```

### 3. Monitor Performance

```bash
# Track token usage
npx claude-flow@alpha monitor tokens --live

# Check costs
npx claude-flow@alpha report cost --by-agent
```

## 🔄 Updating

### Update Claude Code
```bash
# Check current version
claude --version

# Update to latest
npm update -g @anthropic-ai/claude-code

# Verify update
claude --version
```

### Update Claude Flow
```bash
# Always use npx for latest version
npx claude-flow@alpha --version

# Clear npx cache if needed
npx clear-npx-cache
rm -rf ~/.npm/_npx/

# Run with latest
npx claude-flow@alpha --version
```

### Update This Repository
```bash
# Pull latest improvements
git pull origin main

# Check for new agents or guides
git log --oneline .claude/
```

## 🎯 Core Concepts

### 1. Custom SWARM Agents > Default Agents
- Never use Claude Flow's 64 default agents
- Build agents specific to your project needs
- Each agent should have a single, clear responsibility

### 2. Research-First Development
- Always research latest APIs before implementing
- Check current best practices
- Verify available MCP tools

### 3. Multi-Persona Planning
- Product Owner: Business value
- Project Manager: Timeline and dependencies
- Senior Developer: Technical architecture
- Test Writer: Comprehensive test coverage
- Frontend Expert: UI/UX considerations
- Security Expert: Threat modeling

### 4. TDD with Guards
```yaml
execution_order:
  1. tester: Create failing tests
  2. GUARD: Verify tests fail
  3. coder: Implement to pass tests
  4. GUARD: Verify all tests pass
  5. reviewer: Final quality check
```

## 💰 Cost Optimization

- Use Claude Sonnet 4 for most tasks 
- Reserve Claude Opus 4 for complex coordination 


## 🤝 Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Add your improvements (especially new agent templates)
4. Submit a pull request

Focus areas for contributions:
- Additional agent templates for specific domains
- Workflow optimizations
- Cost reduction strategies
- Integration examples

## 📚 Documentation

Start with these essential guides in order:
1. [ARTIFACTS_INDEX.md](.claude/references/ARTIFACTS_INDEX.md) - Complete documentation overview
2. [OPTIMAL_SWARM_WORKFLOW.md](.claude/guides/OPTIMAL_SWARM_WORKFLOW.md) - Master workflow
3. [DEVELOPER_CHEATSHEET.md](.claude/guides/DEVELOPER_CHEATSHEET.md) - Daily quick reference

## ⚠️ Important Notes

- **Windows Users**: Use WSL2. Native Windows support is broken in Claude Flow.
- **Costs**: Budget for ~$200/month Claude subscription for active development
- **Alpha Software**: Claude Flow is alpha. Expect breaking changes.
- **Custom Agents**: Always build your own. Default agents waste time and money.

## 🙏 Acknowledgments

- Anthropic team for Claude Code
- ruvnet for Claude Flow infrastructure
- Bron for swarm insights
- The community for testing and feedback

## 📝 License

MIT License - See [LICENSE](LICENSE) file for details

## 🔗 Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Flow Repository](https://github.com/ruvnet/claude-flow)
- [Model Context Protocol](https://modelcontextprotocol.io)

---

**Remember**: The key to success is building custom agents tailored to your specific needs. The benefits come from specificity and alignment with your project requirements, not generic solutions.

Happy swarming! 🐝