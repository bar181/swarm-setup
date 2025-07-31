# CLAUDE_MODEL_REFERENCE.md - Claude Model Selection for Agents

## 🤖 Claude Models for Agents

All agents in Claude Code and Claude Flow use Claude models exclusively. Here's the optimal selection strategy:

## 📊 Model Selection Matrix

| Agent Type | Recommended Model | Why | Context Budget |
|------------|------------------|-----|----------------|
| **Researcher** | `claude-sonnet-4` | Excellent at finding and synthesizing information | 200k |
| **Planner** | `claude-opus-4` | Complex coordination of 6 personas | 200k |
| **Tester** | `claude-sonnet-4` | Test creation is well-structured | 200k |
| **Coder** | `claude-opus-4` | Complex implementation requiring deep reasoning | 200k |
| **Reviewer** | `claude-sonnet-4` | Pattern recognition and analysis | 200k |
| **Debugger** | `claude-sonnet-4` | Systematic problem solving | 200k |
| **Epic-Planner** | `claude-opus-4` | Complex decomposition and dependencies | 200k |
| **Domain Experts** | `claude-sonnet-4` | Specialized knowledge application | 200k |

## 🎯 Simple Rule of Thumb

```yaml
# Default for 90% of agents
model: claude-sonnet-4

# Only for complex reasoning/coordination
model: claude-opus-4
```

## 💡 When to Use Each Model

### Claude Sonnet 4 (Default Choice)
Use for:
- ✅ Research and investigation
- ✅ Test creation and validation
- ✅ Code review and analysis
- ✅ Documentation writing
- ✅ Bug fixing and debugging
- ✅ Domain-specific tasks
- ✅ Standard implementation
- ✅ Security reviews
- ✅ Performance analysis

### Claude Opus 4 (Complex Tasks Only)
Reserve for:
- ✅ Multi-agent coordination (planner spawning 6 personas)
- ✅ Complex implementation (coder working from tests)
- ✅ System architecture design
- ✅ Epic decomposition
- ✅ ML/AI algorithm implementation
- ✅ Cross-service integration
- ✅ Complex problem decomposition

## 📝 Agent Configuration Examples

### Standard Agent (Sonnet 4)
```yaml
# .claude/agents/api-developer.md
---
name: api-developer
type: developer
model: claude-sonnet-4  # Perfect for API development
context_budget: 200000
tools: [file_read, file_write, bash]
---
```

### Complex Coordination Agent (Opus 4)
```yaml
# .claude/agents/system-architect.md
---
name: system-architect
type: architect
model: claude-opus-4  # Needed for complex system design
context_budget: 200000
tools: [file_read, file_write, web_search]
sub_agents:
  - microservice-designer
  - database-architect
  - security-architect
spawn_strategy: parallel
---
```

## 🔄 Sub-Agent Model Inheritance

Sub-agents typically use Sonnet 4 unless specified:

```yaml
# Parent agent (Opus 4)
---
name: epic-coordinator
model: claude-opus-4
sub_agents:
  - feature-analyzer      # Inherits Sonnet 4
  - dependency-mapper     # Inherits Sonnet 4
  - resource-estimator    # Inherits Sonnet 4
---

# Override for specific sub-agent
sub_agents:
  - name: complex-analyzer
    model: claude-opus-4  # Override to Opus 4
```

## 💰 Cost Optimization

Since Claude models are priced differently:
- Use Sonnet 4 by default (more cost-effective)
- Only upgrade to Opus 4 when complexity demands it
- Sub-agents should mostly use Sonnet 4

## 🎨 Dynamic Agent Model Selection

```bash
# Simple task - use Sonnet
@dynamic-agent with \
  role:"test-data-generator" \
  model:"claude-sonnet-4" \
  task:"Create 1000 realistic user records"

# Complex task - use Opus
@dynamic-agent with \
  role:"distributed-system-designer" \
  model:"claude-opus-4" \
  task:"Design event-driven microservices with CQRS"
```

## ⚡ Performance Tips

1. **Start with Sonnet 4** - Upgrade only if needed
2. **Parallel Sonnet agents** often outperform single Opus agent
3. **Use Opus 4 for coordination**, Sonnet 4 for execution
4. **All agents get 200k context** - use it fully

## 📊 Recommended Distribution

For a typical project with 12 core agents:
- 10 agents use `claude-sonnet-4` (83%)
- 2 agents use `claude-opus-4` (17%)

This provides optimal balance of capability and efficiency!