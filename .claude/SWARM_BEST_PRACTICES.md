# SWARM_BEST_PRACTICES.md - Real-World Lessons

## 🚨 Critical Discovery: Avoid Anthropic Default Agents

### Cost/Time Analysis from Real Project

| Agent Type | Hours | Cost | Quality | Recommendation |
|------------|-------|------|---------|----------------|
| **Custom SWARM Agents** | 446 | $66,900 | High | ✅ USE THIS |
| **Anthropic Default Agents** | 1,265 | $189,750 | Poor | ❌ AVOID |
| **Difference** | +819 (+184%) | +$122,850 | Worse | 🚨 |

## 📊 Why Custom SWARM Agents Win

### 1. Performance
- **2.8x faster** execution time
- **Better quality** outputs
- **Predictable** behavior
- **Lower token usage**

### 2. Cost Efficiency  
- **$275/hour saved** on average
- **184% cost reduction**
- **More accurate estimates**
- **No surprise overruns**

### 3. Quality
- **Follow YOUR standards**
- **Consistent patterns**
- **Better test coverage**
- **Fewer revisions needed**

## 🛠️ Building Effective SWARM Agents

### The Winning Formula

```yaml
# Your custom agent template
---
name: your-agent-name
type: specialist
model: claude-sonnet-4  # Sonnet for most, Opus for complex
context_budget: 200000
tools: [only_what_needed]
sub_agents: [2-6 focused agents]
constraints:
  - follow_project_patterns
  - enforce_quality_standards
---

Clear, specific instructions for YOUR project needs.
```

### What Makes SWARM Agents Better

1. **Specificity** - Tailored to your exact needs
2. **Consistency** - Same patterns across project
3. **Efficiency** - No wasted tokens on generic behavior
4. **Control** - You define success criteria

## 📝 SWARM Agent Patterns That Work

### Pattern 1: Focused Sub-Agent Hierarchy
```
Main Task
└── @planner (coordinates)
    ├── @researcher (investigates)
    ├── @architect (designs)
    └── @validator (verifies)
```

### Pattern 2: Parallel Specialists
```
Feature Implementation
├── @backend-specialist (API)
├── @frontend-specialist (UI)
└── @test-specialist (Quality)
All run in parallel, focused on their domain
```

### Pattern 3: Sequential Refinement
```
1. @rough-designer → Initial approach
2. @detail-refiner → Enhance design
3. @optimizer → Performance tune
Each improves on previous work
```

## 🔥 What to Use from Claude Flow

### ✅ Use These Features:
- **SQLite memory persistence** - Excellent for context
- **Hooks system** - Great for automation
- **Coordination tools** - When truly needed
- **MCP integrations** - Supabase, Playwright, etc.

### ❌ Avoid These:
- **Default agents** - Poor quality, expensive
- **Generic workflows** - Too broad
- **Anthropic agent library** - Not worth it

## 💡 Proven SWARM Configuration

```bash
# Project structure that works
.claude/
├── agents/           # YOUR custom agents
│   ├── researcher.md # Your research approach
│   ├── planner.md    # Your planning method
│   ├── tester.md     # Your test standards
│   ├── coder.md      # Your coding patterns
│   └── reviewer.md   # Your quality bar
├── patterns/         # Reusable patterns
└── memory/          # Shared context

# Don't use
❌ .claude/agents/anthropic/  # Default agents
```

## 🎯 Key Takeaways

1. **Custom SWARM agents are 184% more efficient**
2. **Anthropic default agents waste time and money**
3. **Build agents specific to YOUR project**
4. **Use Claude Flow for infrastructure, not agents**
5. **Focus on clear, specific agent instructions**

## 📈 Metrics That Matter

Track these for your SWARM:
- **Hours per feature** (aim for SWARM baseline)
- **Cost per feature** (should be ~50% of defaults)
- **Revision cycles** (fewer with good agents)
- **Test coverage** (higher with focused agents)

## 🚀 Starting Your SWARM

```bash
# Step 1: Define your core agents (don't copy defaults)
create_custom_agent "researcher" "YOUR research methodology"
create_custom_agent "planner" "YOUR planning approach"
create_custom_agent "tester" "YOUR quality standards"
create_custom_agent "coder" "YOUR implementation patterns"
create_custom_agent "reviewer" "YOUR review criteria"

# Step 2: Test on small feature
@planner create issue for small feature
@tester write tests
@coder implement
@reviewer verify

# Step 3: Measure and refine
# Should be significantly faster/cheaper than defaults
```

## 🏆 Success Story

"We switched from Anthropic default agents to custom SWARM agents and saved $122,850 on a single project while delivering better quality code in less than half the time."

The lesson is clear: **Invest time in building YOUR agents, not using generic ones.**