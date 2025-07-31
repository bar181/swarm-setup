# MCP Best Practices - Leveraging Claude-Flow's 87 Tools

## 🎯 Overview

Claude-flow provides a comprehensive MCP (Model Context Protocol) implementation with **87 tools** across 8 categories. This guide shows how to effectively use these tools in your SWARM workflows.

## 📊 Available MCP Categories

### 🐝 Swarm Coordination (12 tools)
```bash
# Initialize swarm with optimal topology
npx claude-flow@alpha mcp tools --category=swarm --verbose

# Key tools:
- swarm_init: 4 topologies (hierarchical, mesh, ring, star)
- agent_spawn: 8 agent types
- task_orchestrate: Complex workflow orchestration
- topology_optimize: Auto-optimize swarm structure
```

### 🧠 Neural Networks & AI (15 tools)
```bash
# Neural pattern training and analysis
npx claude-flow@alpha mcp tools --category=neural --verbose

# Key capabilities:
- WASM SIMD acceleration
- 27 neural models available
- Pattern recognition and cognitive analysis
- Transfer learning and model ensembles
```

### 💾 Memory & Persistence (12 tools)
```bash
# Cross-session memory management
npx claude-flow@alpha mcp tools --category=memory --verbose

# Key features:
- SQLite-based persistence
- Namespace organization
- TTL support
- Pattern-based search
```

## 🚀 Integration with Custom Agents

### Update Modular Designer Agent
The modular-designer agent should leverage MCP for module creation:

```bash
# When detecting MCP candidates, use:
mcp__claude-flow__workflow_create {
  "name": "module-mcp-setup",
  "steps": [
    {"action": "analyze_structure"},
    {"action": "generate_mcp_config"},
    {"action": "create_server"},
    {"action": "test_integration"}
  ]
}
```

### Agent Coordination via MCP
```bash
# Spawn agents using MCP tools
mcp__claude-flow__agent_spawn {
  "type": "modular-designer",
  "capabilities": ["folder_analysis", "mcp_creation"]
}

# Orchestrate parallel tasks
mcp__claude-flow__task_orchestrate {
  "task": "Analyze all modules for MCP opportunities",
  "strategy": "parallel",
  "maxAgents": 5
}
```

## 📋 Common MCP Patterns

### Pattern 1: Module to MCP Conversion
```bash
# 1. Analyze module structure
@modular-designer analyze ./modules/llm_providers

# 2. Create MCP workflow
mcp__claude-flow__workflow_create {
  "name": "llm-providers-mcp",
  "steps": [
    {"tool": "daa_agent_create", "config": {"type": "provider"}},
    {"tool": "workflow_template", "template": "multi-provider"},
    {"tool": "github_workflow_auto", "action": "create_ci"}
  ]
}

# 3. Execute workflow
mcp__claude-flow__workflow_execute {
  "workflowId": "llm-providers-mcp"
}
```

### Pattern 2: Swarm-Based Module Development
```bash
# Initialize module development swarm
mcp__claude-flow__swarm_init {
  "topology": "hierarchical",
  "maxAgents": 6,
  "strategy": "specialized"
}

# Spawn module specialists
mcp__claude-flow__agent_spawn {
  "type": "architect",
  "name": "module_architect"
}

# Orchestrate module creation
mcp__claude-flow__task_orchestrate {
  "task": "Create authentication module with MCP interface",
  "strategy": "parallel"
}
```

### Pattern 3: Performance Optimization
```bash
# Analyze module performance
mcp__claude-flow__bottleneck_analyze {
  "component": "auth_module"
}

# Optimize with neural patterns
mcp__claude-flow__neural_patterns {
  "action": "analyze",
  "operation": "module_optimization"
}

# Generate performance report
mcp__claude-flow__performance_report {
  "timeframe": "7d",
  "format": "detailed"
}
```

## 🔧 MCP Server Management

### Starting MCP Server
```bash
# Start with auto-orchestrator
npx claude-flow@alpha mcp start --auto-orchestrator --daemon

# Enable neural and WASM features
npx claude-flow@alpha mcp start --enable-neural --enable-wasm
```

### Monitoring MCP Status
```bash
# Check server status
npx claude-flow@alpha mcp status

# List available tools by category
npx claude-flow@alpha mcp tools --category=swarm
```

## 📈 Performance Benefits

Using MCP tools provides:
- **2.8-4.4x** speed improvement with parallel execution
- **32.3%** token reduction through optimization
- **84.8%** SWE-Bench solve rate with swarm coordination
- **WASM** neural processing with SIMD optimization

## 🎯 When to Use MCP Tools

### Use MCP for:
- ✅ Complex multi-agent orchestration
- ✅ Cross-session memory persistence
- ✅ Performance-critical operations
- ✅ GitHub integration workflows
- ✅ Neural pattern training
- ✅ Dynamic agent creation

### Use Direct Commands for:
- ❌ Simple file operations
- ❌ Basic agent spawning
- ❌ Quick one-off tasks

## 💡 Best Practices

1. **Leverage Existing Tools**: Use the 87 MCP tools before creating custom solutions
2. **Parallel Execution**: Use `task_orchestrate` for concurrent operations
3. **Memory Persistence**: Store important context using memory tools
4. **Performance Monitoring**: Use analysis tools to track efficiency
5. **Workflow Automation**: Create reusable workflows for common patterns

## 🔗 Integration Points

### With Modular Designer
```javascript
// modular-designer should check for MCP tools
if (folderIsMCPCandidate) {
  // Use workflow_create to setup MCP
  await mcp.workflow_create({
    name: `${moduleName}-mcp-setup`,
    steps: generateMCPSteps(module)
  });
}
```

### With Custom Agents
All custom agents can leverage MCP tools:
- **Researcher**: Use `memory_search` for context
- **Planner**: Use `task_orchestrate` for coordination
- **Tester**: Use `parallel_execute` for test runs
- **Reviewer**: Use `quality_assess` for validation

## 📝 Quick Reference

```bash
# Start MCP server
npx claude-flow@alpha mcp start --auto-orchestrator

# List all tools
npx claude-flow@alpha mcp tools --verbose

# Check specific category
npx claude-flow@alpha mcp tools --category=neural

# Run SPARC MCP mode
./claude-flow sparc run mcp "your task"

# Store in memory
mcp__claude-flow__memory_usage {
  "action": "store",
  "key": "module_patterns",
  "value": "...",
  "namespace": "modules"
}
```

---

Remember: Claude-flow's MCP implementation is already comprehensive. Focus on using it effectively rather than reinventing functionality.