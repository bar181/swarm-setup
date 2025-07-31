# SWARM_BEST_PRACTICES.md - Practical Lessons

## 🚨 Key Discovery: Custom Agents Provide Better Control

### Why Build Custom SWARM Agents

Custom agents offer several advantages over generic defaults:

## 📊 Benefits of Custom SWARM Agents

### 1. Predictable Behavior
- **Tailored to your project** requirements
- **Consistent output** patterns
- **Clear documentation** of capabilities
- **Defined scope** and boundaries

### 2. Development Efficiency  
- **Parallel execution** of tasks
- **Focused responsibilities** per agent
- **Reusable patterns** across projects
- **Streamlined workflows**

### 3. Quality Control
- **Enforce project standards** consistently
- **Implement specific patterns** you need
- **Comprehensive test coverage** built-in
- **Reduce revision cycles** through clarity

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

1. **Custom SWARM agents provide better control and predictability**
2. **Build agents specific to YOUR project needs**
3. **Use Claude Flow for infrastructure support**
4. **Focus on clear, specific agent instructions**
5. **Leverage parallel execution for efficiency**

## 📈 Metrics to Track

Monitor these aspects of your SWARM:
- **Task completion time** per feature
- **Test coverage** percentage
- **Revision cycles** needed
- **Agent coordination** effectiveness

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

## 🏆 Key Takeaway

Custom SWARM agents provide better control, predictability, and alignment with your specific project needs compared to generic default agents.

The lesson is clear: **Invest time in building YOUR agents, not using generic ones.**