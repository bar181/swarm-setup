# CLAUDE.md - Master Project Instructions for Claude Code

## 🎯 Project Configuration

This project uses **custom SWARM agents** with Claude Flow infrastructure, emphasizing parallel execution, modular development, and research-first methodology.

**IMPORTANT**: Read `.claude/claude.md` for complete detailed instructions. This file provides essential configuration for Claude Code to understand the project.

## 🏗️ Project Structure

```
project/
├── .claude/                                # COMPREHENSIVE DOCUMENTATION
│   ├── claude.md                           # ⭐ DETAILED MASTER INSTRUCTIONS
│   ├── OPTIMAL_SWARM_WORKFLOW.md           # Complete execution methodology
│   ├── DEVELOPER_CHEATSHEET.md             # Quick commands reference
│   ├── AGENT_CREATION_GUIDE.md             # Custom agent templates
│   ├── scripts/                            # Utility scripts
│   │   └── detect-mcp-candidates.sh        # Find MCP opportunities
│   ├── templates/                          # Reusable templates
│   │   └── MODULE_README_TEMPLATE.md       # For AI-optimized docs
│   └── agents/                             # Custom agent definitions
├── docs/phases/                            # Research & planning artifacts
├── .swarm/                                 # Claude Flow memory (SQLite)
└── .hive-mind/                             # Claude Flow config
```

## 🚀 Custom SWARM Methodology

Our approach replaces Claude Flow's default agents with optimized custom agents:

```bash
# 1. Research Phase (ALWAYS FIRST)
@researcher investigate [FEATURE] and save to /docs/phases/[phase]/research/

# 2. Multi-Persona Planning (6 perspectives)
@planner coordinate 6 personas to create comprehensive GitHub issue

# 3. TDD Implementation (Tests before code)
@tester create failing tests → @coder implement → @reviewer verify
```

## 🛠️ Claude Flow Integration

### MCP Tools Available (87 Tools)
```bash
# List all available MCP tools
npx claude-flow@alpha mcp tools --verbose

# Categories with tool counts:
- swarm: 12 tools for coordination
- neural: 15 AI/ML tools
- memory: 12 persistence tools
- analysis: 13 monitoring tools
- workflow: 11 automation tools
- github: 8 integration tools
- daa: 8 dynamic agent tools
- system: 8 utility tools

# Start MCP server
npx claude-flow@alpha mcp start --auto-orchestrator --enable-neural
```

### Memory & Persistence (SQLite Database)
```yaml
# Claude Flow provides powerful SQLite-based memory
.swarm/memory.db: Persistent knowledge base (auto-created)

# Key features:
- Cross-session persistence
- Namespace organization
- TTL support for temporary data
- Pattern-based search
- Metadata enrichment

# Common uses:
- Store research findings
- Architecture decisions (ADRs)
- Successful patterns
- Project context
- Cross-agent coordination
```

**See**: `.claude/MEMORY_SYSTEM_GUIDE.md` for comprehensive memory usage

### Essential Commands
```bash
# Token tracking
npx claude-flow@alpha report tokens --issue [NUMBER]
npx claude-flow@alpha report cost --phase [NAME]

# MCP tool management
npx claude-flow@alpha mcp list
npx claude-flow@alpha mcp install [tool-name]
```

### ⚠️ Commands Directory (Use as Fallback Only)
The `.claude/commands/` directory contains Claude Flow defaults. **These should only be used as fallback**:
- ❌ **AVOID**: `/sparc/*`, `/swarm/*`, `/workflows/*`, `/training/*`
- ⚠️ **Use Cautiously**: `/github/*`, `/memory/*`, `/monitoring/*`
- ✅ **See**: `.claude/COMMANDS_REFERENCE.md` for detailed guidance

**Always prefer our custom documentation over default commands.**

## ⚡ Critical Execution Rules

### 1. ALWAYS Use Parallel Execution
```javascript
// ❌ WRONG: Sequential (slow)
@agent1 do task
@agent2 do task
@agent3 do task

// ✅ RIGHT: Parallel (fast) - ALL IN ONE MESSAGE
[Single Message]:
  @agent1 do complete task with all details
  @agent2 do complete task with all details
  @agent3 do complete task with all details
```

### 2. Batch ALL Operations
- **TodoWrite**: Create 5-10 todos at once
- **File operations**: Read/write multiple files in one message
- **Agent spawning**: Spawn all agents simultaneously
- **Memory operations**: Store/retrieve in batches

### 3. Follow Custom Agent Patterns
```yaml
# Use OUR agents from .claude/agents/:
- researcher (Sonnet 4): Exhaustive investigation
- planner (Opus 4): Coordinate 6 personas
- tester (Sonnet 4): TDD test creation
- coder (Opus 4): Complex implementation
- reviewer (Sonnet 4): Quality assurance
```

## 📊 Technology Stack

- **Frontend**: Vite.js, React, TypeScript, Zustand
- **Backend**: FastAPI, Python 3.11+, Pydantic v2
- **Database**: Supabase (PostgreSQL with RLS)
- **Testing**: Pytest, Playwright
- **AI Models**: Claude Sonnet 4 (90%), Claude Opus 4 (10% complex tasks)

## 🔗 Key References

1. **Start Here**: `.claude/claude.md` - Complete project instructions
2. **Daily Work**: `.claude/DEVELOPER_CHEATSHEET.md` - Quick prompts
3. **Planning**: `.claude/PHASE_ORCHESTRATION.md` - Research methodology
4. **Agents**: `.claude/AGENT_CREATION_GUIDE.md` - Custom agent creation

## ⚠️ Non-Negotiable Rules

1. **NEVER use Claude Flow default agents** - Use our custom ones
2. **ALWAYS read `.claude/claude.md` for detailed instructions**
3. **ALWAYS start with research phase** - No exceptions
4. **ALWAYS write tests first** - TDD is mandatory
5. **ALWAYS execute operations in parallel** - One message, many operations
6. **ALWAYS follow existing patterns** - Check codebase first

## 🎯 Key Benefits

- **Parallel Execution**: Multiple agents work simultaneously
- **Modular Development**: Clear component boundaries
- **Research-First**: Thorough investigation before implementation
- **TDD Methodology**: Tests drive development quality

---

**Remember**: This file provides Claude Code with project context. For complete instructions, **ALWAYS refer to `.claude/claude.md`**.