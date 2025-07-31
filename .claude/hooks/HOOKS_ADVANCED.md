# Claude Code Hooks Guide - Complete Integration with SWARM

## 📚 Table of Contents
1. [Overview](#overview)
2. [Hook Types](#hook-types)
3. [Configuration](#configuration)
4. [SWARM Integration](#swarm-integration)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)
7. [Examples](#examples)

## 🎯 Overview

Claude Code hooks provide automated orchestration points throughout your development workflow. When integrated with custom SWARM agents, hooks enable:

- **Automatic agent assignment** based on operation context
- **Pre-validation** of commands and file operations
- **Post-processing** with formatting and optimization
- **Session management** with memory persistence
- **Performance tracking** and neural pattern training

### Key Benefits
- 🚀 **300% faster execution** through parallel agent coordination
- 🧠 **Continuous learning** from successful operations
- 💾 **Cross-session memory** for context retention
- 🔒 **Security validation** before dangerous operations
- 📊 **Real-time metrics** for optimization

## 🪝 Hook Types

### 1. Pre-Operation Hooks

#### `pre-task`
Automatically spawns appropriate agents based on task complexity.

```javascript
// Triggered before task execution
npx claude-flow hooks pre-task --description "Build authentication system" --auto-spawn-agents

// What it does:
// - Analyzes task complexity
// - Spawns researcher, planner, tester, coder agents
// - Loads relevant context from memory
// - Prepares workspace
```

#### `pre-edit`
Validates files and prepares resources before modification.

```javascript
// Triggered before file edits
npx claude-flow hooks pre-edit --file "src/api/auth.ts" --auto-assign-agents true

// What it does:
// - Checks file permissions
// - Loads file-specific context
// - Assigns appropriate coder agent
// - Validates against project patterns
```

#### `pre-command`
Security validation before command execution.

```javascript
// Triggered before bash commands
npx claude-flow hooks pre-command --command "rm -rf node_modules" --validate-safety true

// What it does:
// - Validates command safety
// - Checks against deny list
// - Prepares execution environment
// - Logs command intent
```

#### `pre-search`
Caches searches for improved performance.

```javascript
// Triggered before search operations
npx claude-flow hooks pre-search --query "authentication patterns" --cache-results true

// What it does:
// - Checks memory cache first
// - Optimizes search parameters
// - Prepares parallel searches
// - Loads previous results
```

### 2. Post-Operation Hooks

#### `post-edit`
Auto-formats code and updates memory.

```javascript
// Triggered after file modifications
npx claude-flow hooks post-edit --file "src/api/auth.ts" --format true --train-neural true

// What it does:
// - Runs language-specific formatters
// - Updates file metadata in memory
// - Trains neural patterns
// - Validates code quality
```

#### `post-task`
Trains neural patterns from successful operations.

```javascript
// Triggered after task completion
npx claude-flow hooks post-task --task-id "auth-implementation" --success true

// What it does:
// - Analyzes execution patterns
// - Stores successful strategies
// - Updates agent performance metrics
// - Generates optimization suggestions
```

#### `post-command`
Updates memory with operation context.

```javascript
// Triggered after command execution
npx claude-flow hooks post-command --command "npm test" --store-results true

// What it does:
// - Logs command results
// - Updates performance metrics
// - Stores output patterns
// - Tracks success rates
```

#### `notification`
Real-time progress updates.

```javascript
// Triggered during long operations
npx claude-flow hooks notification --message "Swarm completed phase 1" --progress 33

// What it does:
// - Sends progress notifications
// - Updates swarm status
// - Logs milestone completion
// - Triggers dependent operations
```

### 3. Session Hooks

#### `session-start`
Restores previous context automatically.

```javascript
// Triggered at session start
npx claude-flow hooks session-start --restore-context true --load-agents true

// What it does:
// - Loads previous session state
// - Restores active swarms
// - Rehydrates memory cache
// - Prepares workspace
```

#### `session-end`
Generates summaries and persists state.

```javascript
// Triggered at session end
npx claude-flow hooks session-end --generate-summary true --persist-state true

// What it does:
// - Generates session summary
// - Persists swarm states
// - Exports metrics
// - Cleans up resources
```

#### `session-restore`
Loads memory from previous sessions.

```javascript
// Triggered for context restoration
npx claude-flow hooks session-restore --session-id "previous-session" --merge-memory true

// What it does:
// - Loads specific session data
// - Merges with current context
// - Restores agent configurations
// - Rebuilds swarm topology
```

## ⚙️ Configuration

### Basic Configuration (.claude/settings.json)

```json
{
  "env": {
    "CLAUDE_FLOW_HOOKS_ENABLED": "true",
    "CLAUDE_FLOW_AUTO_COMMIT": "false",
    "CLAUDE_FLOW_TELEMETRY_ENABLED": "true"
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "cat | jq -r '.tool_input.command // empty' | tr '\\n' '\\0' | xargs -0 -I {} npx claude-flow@alpha hooks pre-command --command '{}' --validate-safety true"
          }
        ]
      },
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "cat | jq -r '.tool_input.file_path // .tool_input.path // empty' | tr '\\n' '\\0' | xargs -0 -I {} npx claude-flow@alpha hooks pre-edit --file '{}' --auto-assign-agents true"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "cat | jq -r '.tool_input.file_path // .tool_input.path // empty' | tr '\\n' '\\0' | xargs -0 -I {} npx claude-flow@alpha hooks post-edit --file '{}' --format true --update-memory true"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "npx claude-flow@alpha hooks session-end --generate-summary true --persist-state true"
          }
        ]
      }
    ]
  }
}
```

### Advanced SWARM Integration

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Task",
        "hooks": [
          {
            "type": "command",
            "command": "npx claude-flow@alpha hooks pre-task --auto-spawn-swarm true --topology hierarchical --max-agents 8"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Task",
        "hooks": [
          {
            "type": "command",
            "command": "npx claude-flow@alpha hooks post-task --train-patterns true --optimize-topology true"
          }
        ]
      }
    ]
  }
}
```

## 🐝 SWARM Integration

### Automatic Agent Assignment

Hooks can automatically assign the right agents based on context:

```javascript
// File type detection
pre-edit hook detects:
- *.py → Python specialist agent
- *.ts → TypeScript expert agent
- *.test.* → Test specialist agent
- *.sql → Database expert agent

// Task complexity analysis
pre-task hook analyzes:
- Simple tasks → 2-3 agents
- Medium tasks → 5-6 agents
- Complex tasks → 8-10 agents
- Epic tasks → Multiple swarms
```

### Swarm Coordination Patterns

```javascript
// Hierarchical swarm for complex features
{
  "preTaskHook": {
    "command": "npx claude-flow@alpha swarm init --topology hierarchical",
    "args": ["--max-agents", "8", "--strategy", "specialized"]
  }
}

// Mesh swarm for collaborative tasks
{
  "preTaskHook": {
    "command": "npx claude-flow@alpha swarm init --topology mesh",
    "args": ["--max-agents", "6", "--strategy", "balanced"]
  }
}
```

### Memory Integration

```javascript
// Store successful patterns
{
  "postTaskHook": {
    "command": "npx claude-flow@alpha memory store",
    "args": [
      "--key", "patterns/${task_type}",
      "--namespace", "swarm_patterns",
      "--ttl", "2592000"
    ]
  }
}

// Retrieve context for new tasks
{
  "preTaskHook": {
    "command": "npx claude-flow@alpha memory search",
    "args": [
      "--pattern", "*${task_type}*",
      "--namespace", "swarm_patterns"
    ]
  }
}
```

## 📋 Best Practices

### 1. Performance Optimization

```javascript
// Keep hooks lightweight
- Target < 100ms execution time
- Use async operations when possible
- Cache frequently accessed data
- Batch related operations

// Example: Optimized pre-edit hook
{
  "command": "npx claude-flow@alpha hooks pre-edit",
  "args": ["--file", "${file}", "--quick-check", "true"],
  "timeout": 100
}
```

### 2. Security Considerations

```javascript
// Validate all external inputs
{
  "preCommandHook": {
    "command": "npx claude-flow@alpha hooks validate-command",
    "args": ["--strict", "true", "--log-attempts", "true"]
  }
}

// Protected file patterns
const protectedFiles = [
  ".env*",
  "*.key",
  "*.pem",
  "secrets/*"
];
```

### 3. Error Handling

```javascript
// Graceful degradation
{
  "hooks": [{
    "type": "command",
    "command": "npx claude-flow@alpha hooks pre-edit || echo 'Hook failed, continuing...'"
  }]
}

// Retry logic for critical hooks
{
  "hooks": [{
    "type": "command",
    "command": "npx claude-flow@alpha hooks session-end --retry 3"
  }]
}
```

### 4. Monitoring and Metrics

```javascript
// Track hook performance
{
  "postHook": {
    "command": "npx claude-flow@alpha metrics track",
    "args": ["--event", "hook_execution", "--duration", "${duration}"]
  }
}

// Generate performance reports
npx claude-flow@alpha hooks report --timeframe 7d --format json
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Variable Interpolation Not Working

**Problem**: `${file}` variables not expanding in hooks.

**Solution**: Use the fix-hook-variables command:
```bash
# Fix all settings.json files
npx claude-flow@alpha fix-hook-variables

# Fix specific file
npx claude-flow@alpha fix-hook-variables .claude/settings.json
```

This converts:
- `${file}` → `$CLAUDE_EDITED_FILE`
- `${command}` → `$CLAUDE_COMMAND`
- `${tool}` → `$CLAUDE_TOOL`

#### 2. Hooks Not Firing

**Problem**: Hooks configured but not executing.

**Solution**: Check configuration and permissions:
```bash
# Verify hooks are enabled
cat .claude/settings.json | jq '.env.CLAUDE_FLOW_HOOKS_ENABLED'

# Test hook manually
npx claude-flow@alpha hooks test pre-edit --file test.js

# Check permissions
ls -la .claude/settings.json
```

#### 3. Performance Issues

**Problem**: Hooks causing slowdowns.

**Solution**: Profile and optimize:
```bash
# Profile hook execution
npx claude-flow@alpha hooks profile --hook pre-edit

# Disable non-critical hooks
export CLAUDE_FLOW_CRITICAL_HOOKS_ONLY=true

# Use async execution
{
  "alwaysRun": false,
  "async": true
}
```

#### 4. Memory Leaks

**Problem**: Memory usage increasing over time.

**Solution**: Implement cleanup:
```bash
# Add cleanup to session-end hook
npx claude-flow@alpha hooks session-end --cleanup-memory true

# Set memory limits
export CLAUDE_FLOW_MEMORY_LIMIT=512MB
```

### Debug Mode

Enable comprehensive debugging:
```bash
# Set debug environment
export CLAUDE_FLOW_DEBUG=true
export CLAUDE_FLOW_HOOK_DEBUG=true

# Test specific hook with debug output
npx claude-flow@alpha hooks pre-edit --file test.js --debug

# View hook execution logs
tail -f ~/.claude-flow/logs/hooks.log
```

## 📝 Examples

### Example 1: Auto-Format Python Files

```json
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "if [[ '${tool.params.file_path}' == *.py ]]; then black '${tool.params.file_path}' && isort '${tool.params.file_path}'; fi"
      }]
    }
  ]
}
```

### Example 2: Auto-Spawn Test Agent

```json
{
  "PreToolUse": [
    {
      "matcher": "Write",
      "hooks": [{
        "type": "command",
        "command": "if [[ '${tool.params.file_path}' == *.test.* ]]; then npx claude-flow@alpha agent spawn --type tester --auto-assign true; fi"
      }]
    }
  ]
}
```

### Example 3: Protected File Detection

```json
{
  "PreToolUse": [
    {
      "matcher": "Write|Edit|MultiEdit",
      "hooks": [{
        "type": "command",
        "command": "npx claude-flow@alpha hooks check-protected --file '${tool.params.file_path}' --block-on-match true"
      }]
    }
  ]
}
```

### Example 4: Swarm Performance Tracking

```json
{
  "PostToolUse": [
    {
      "matcher": "Task",
      "hooks": [{
        "type": "command",
        "command": "npx claude-flow@alpha swarm metrics --export true --format json > .swarm/metrics/${task_id}.json"
      }]
    }
  ]
}
```

### Example 5: Intelligent Context Loading

```json
{
  "PreToolUse": [
    {
      "matcher": "Task",
      "hooks": [{
        "type": "command",
        "command": "npx claude-flow@alpha memory search --pattern '*${task_description}*' | npx claude-flow@alpha context load --merge true"
      }]
    }
  ]
}
```

## 🚀 Advanced Patterns

### Pattern 1: Multi-Stage Pipeline

```javascript
// Complex task with staged execution
{
  "preTaskHook": [
    // Stage 1: Research
    {
      "command": "npx claude-flow@alpha agent spawn --type researcher",
      "stage": "research"
    },
    // Stage 2: Planning
    {
      "command": "npx claude-flow@alpha agent spawn --type planner",
      "stage": "planning",
      "dependsOn": "research"
    },
    // Stage 3: Implementation
    {
      "command": "npx claude-flow@alpha swarm init --topology hierarchical",
      "stage": "implementation",
      "dependsOn": "planning"
    }
  ]
}
```

### Pattern 2: Conditional Agent Assignment

```javascript
// Dynamic agent selection based on context
{
  "preEditHook": {
    "command": "npx claude-flow@alpha hooks assign-agent",
    "args": [
      "--rules", "'{\"*.py\": \"python-expert\", \"*.ts\": \"typescript-expert\"}'",
      "--fallback", "general-coder"
    ]
  }
}
```

### Pattern 3: Performance-Based Optimization

```javascript
// Adjust swarm size based on performance
{
  "preTaskHook": {
    "command": "npx claude-flow@alpha hooks optimize-swarm",
    "args": [
      "--metric", "execution_time",
      "--target", "< 5 minutes",
      "--adjust-agents", "true"
    ]
  }
}
```

## 📊 Metrics and Monitoring

### Available Metrics

```bash
# Hook execution times
npx claude-flow@alpha metrics hooks --timeframe 24h

# Agent performance
npx claude-flow@alpha metrics agents --group-by type

# Memory usage
npx claude-flow@alpha metrics memory --namespace all

# Success rates
npx claude-flow@alpha metrics success --by-hook-type
```

### Custom Dashboards

```javascript
// Export metrics for visualization
{
  "sessionEndHook": {
    "command": "npx claude-flow@alpha metrics export",
    "args": [
      "--format", "prometheus",
      "--output", ".metrics/session_${timestamp}.prom"
    ]
  }
}
```

## 🔮 Future Enhancements

### Planned Features
1. **AI-Powered Hook Suggestions** - ML-based hook recommendations
2. **Visual Hook Editor** - GUI for hook configuration
3. **Hook Templates Library** - Pre-built hook patterns
4. **Distributed Hook Execution** - Scale across multiple machines
5. **Hook Version Control** - Track and rollback hook changes

### Community Contributions
- Submit hook patterns to the community library
- Share performance optimization techniques
- Contribute to hook documentation
- Report issues and suggest improvements

## 📚 Additional Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Claude Flow GitHub](https://github.com/ruvnet/claude-flow)
- [Hook Examples Repository](https://github.com/ruvnet/claude-flow-hooks)
- [Community Discord](https://discord.gg/claude-flow)

---

**Remember**: Hooks are powerful automation tools. Use them wisely to enhance, not complicate, your workflow. Start simple, measure impact, and iterate based on real usage patterns.