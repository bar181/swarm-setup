# ARTIFACTS_INDEX.md - Essential Documentation for Your Repository

## 📚 Core Documentation (Keep These)

### 1. **OPTIMAL_SWARM_WORKFLOW.md**
**Use Case:** Master guide for executing feature development using Claude Code native sub-agents
- Complete workflow from requirements to deployment
- Multi-persona issue creation
- TDD implementation flow
- Success metrics

### 2. **SWARM_EXECUTION_GUIDE.md**
**Use Case:** Step-by-step instructions for Claude Code to execute swarm-based development
- Research protocol
- Epic vs issue decision logic
- GitHub CLI commands
- Parallel execution patterns

### 3. **DEVELOPER_CHEATSHEET.md**
**Use Case:** Quick reference for daily development tasks
- Decision tree for swarm sizes
- Copy-paste prompts for every scenario
- When to use TDD
- Common mistakes to avoid

### 4. **AGENT_CREATION_GUIDE.md** (Updated Version)
**Use Case:** How to create and configure custom agents
- Claude Sonnet 4 vs Opus 4 selection
- Sub-agent spawning patterns
- Avoids Anthropic default agents (based on your feedback)
- Project-specific agent examples

### 5. **PHASE_ORCHESTRATION.md**
**Use Case:** Research-first multi-persona approach for comprehensive planning
- How to research latest tech before implementing
- 6-persona planning methodology
- Creating GitHub issues with actual code
- MCP tool integration

### 6. **EPIC_BREAKDOWN_EXAMPLES.md**
**Use Case:** How to decompose large projects into manageable pieces
- When to create epics (>3 days work)
- Vertical slices pattern
- Resource allocation
- Parallel execution strategies

### 7. **CLAUDE_MODEL_REFERENCE.md**
**Use Case:** Quick guide for selecting Claude models for agents
- Sonnet 4 for most tasks
- Opus 4 for complex coordination
- Cost optimization strategies

### 8. **SWARM_BEST_PRACTICES.md**
**Use Case:** Real-world lessons from your implementation
- Cost comparison showing 184% savings
- Why custom agents beat defaults
- Proven patterns that work

### 9. **Claude Flow Default Agents Analysis**
**Use Case:** Comprehensive analysis of Claude Flow's 64 default agents
- Which agents to keep, modify, or ignore
- Tech stack compatibility (Vite.js/React, FastAPI, Supabase)
- Real user experiences and warnings
- When to create new agents

## 🗂️ Repository Structure

```
.claude/
├── README.md                           # Links to this index
├── ARTIFACTS_INDEX.md                  # This file
├── guides/
│   ├── OPTIMAL_SWARM_WORKFLOW.md       # Master workflow
│   ├── SWARM_EXECUTION_GUIDE.md        # Detailed execution
│   ├── DEVELOPER_CHEATSHEET.md         # Quick reference
│   └── SWARM_BEST_PRACTICES.md         # Lessons learned
├── agent-management/
│   ├── AGENT_CREATION_GUIDE.md         # How to create agents
│   ├── CLAUDE_MODEL_REFERENCE.md       # Model selection
│   └── claude-flow-agents-analysis.md  # Default agents review
└── planning/
    ├── PHASE_ORCHESTRATION.md          # Research-first approach
    └── EPIC_BREAKDOWN_EXAMPLES.md      # Project decomposition
```

## 🚫 Artifacts to Skip (Duplicates/Outdated)

These were superseded by the documents above:
- QUICKSTART_SWARM_v2.md → Covered in SWARM_EXECUTION_GUIDE.md
- SWARM_QUICK_REFERENCE.md → Merged into DEVELOPER_CHEATSHEET.md
- SUBAGENT_INTEGRATION.md → Included in AGENT_CREATION_GUIDE.md
- SWARM_APPROACH_UPDATE.md → Information incorporated into other guides
- swarm-quick-reference → Duplicate of cheatsheet
- Several early versions of the swarm guide

## 📋 Quick Usage Guide

### For New Projects:
1. Start with **OPTIMAL_SWARM_WORKFLOW.md**
2. Reference **DEVELOPER_CHEATSHEET.md** for daily tasks
3. Use **AGENT_CREATION_GUIDE.md** to build custom agents

### For Planning:
1. Use **PHASE_ORCHESTRATION.md** for research-first approach
2. Reference **EPIC_BREAKDOWN_EXAMPLES.md** for large projects

### For Optimization:
1. Review **SWARM_BEST_PRACTICES.md** for cost savings
2. Check **Claude Flow Default Agents Analysis** before using defaults
3. Use **CLAUDE_MODEL_REFERENCE.md** for model selection

## 💡 Key Insights

- Custom agents are 184% more efficient than defaults
- Always research before implementing
- Use 6-persona planning for comprehensive coverage
- TDD with guards prevents wasted effort
- Parallel execution saves significant time

This curated set of 9 documents provides everything you need without duplication, organized for practical daily use.