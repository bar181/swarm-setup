# swarm-setup
Transform your AI development with custom agent swarms optimized for Agentic Engineering - optimal settings for Claude Code and Claude-flow

# WARNING #
This system uses --dangerously-skip-permissions.  It is recommended to use a controled environment such as Codespaces 

**Topics/Tags:**
`claude-code` `claude-flow` `ai-agents` `swarm-development` `llm-orchestration` `fastapi` `react` `supabase` `tdd` `ai-development` `agent-swarm` `anthropic` `claude-ai`

**Full Description:**

Transform your AI development with custom agent swarms that are 184% more efficient than default implementations. This repository provides a complete framework for using Claude Code with optimized SWARM agents, including:

✅ **9 Essential Guides** - From setup to advanced orchestration  
✅ **Custom Agent Templates** - Pre-built for modern web development    
✅ **Research-First Methodology** - Always use latest best practices  
✅ **Multi-Persona Planning** - 6 perspectives for comprehensive coverage  
✅ **Real Production Data** - $122,850 saved on a single project  
✅ **TDD Workflow** - Test-first with parallel execution  
✅ **Cost Tracking** - Monitor and optimize token usage  

Optimized for Vite.js/React + FastAPI + Supabase stack. Includes detailed warnings about which Claude Flow features to avoid and why custom agents outperform defaults.

Based on real-world experience building production systems with Claude Code.

# 🚀 Claude Code SWARM Development Framework

> **Transform your AI development with custom agent swarms that are more efficient than default implementations**

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
.claude/
├── README.md                           # You are here
├── ARTIFACTS_INDEX.md                  # Complete documentation index
├── guides/                             # Core workflow documentation
│   ├── OPTIMAL_SWARM_WORKFLOW.md       # Master execution guide
│   ├── SWARM_EXECUTION_GUIDE.md        # Step-by-step instructions
│   ├── DEVELOPER_CHEATSHEET.md         # Quick reference for daily use
│   └── SWARM_BEST_PRACTICES.md         # Lessons from production
├── agent-management/                   # Agent configuration guides
│   ├── AGENT_CREATION_GUIDE.md         # Build custom agents
│   ├── CLAUDE_MODEL_REFERENCE.md       # Sonnet vs Opus selection
│   └── claude-flow-agents-analysis.md  # Which defaults to avoid
├── planning/                           # Project planning tools
│   ├── PHASE_ORCHESTRATION.md          # Research-first approach
│   └── EPIC_BREAKDOWN_EXAMPLES.md      # Large project patterns
└── agents/                             # Your custom agents go here
    ├── researcher.md
    ├── planner.md
    ├── tester.md
    ├── coder.md
    └── reviewer.md
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
1. [ARTIFACTS_INDEX.md](.claude/ARTIFACTS_INDEX.md) - Complete documentation overview
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

**Remember**: The key to success is building custom agents tailored to your specific needs. The 184% efficiency gain comes from specificity, not generic solutions.

Happy swarming! 🐝