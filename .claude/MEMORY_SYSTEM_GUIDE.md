# MEMORY_SYSTEM_GUIDE.md - Claude Flow SQLite Memory System

## 🧠 Overview

Claude Flow provides a powerful SQLite-based memory system that enables persistent storage across sessions. This allows your custom SWARM agents to maintain context, learn from past interactions, and build knowledge over time.

## 📁 Memory Database Location

```
.swarm/
├── memory.db       # Main SQLite database
├── memory.db-shm   # Shared memory file
└── memory.db-wal   # Write-ahead log
```

The database is automatically created when you first use memory features.

## 🗄️ Database Schema

```sql
CREATE TABLE memory_entries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key TEXT NOT NULL,                    # Unique identifier for memory
    value TEXT NOT NULL,                  # The actual memory content
    namespace TEXT NOT NULL DEFAULT 'default',  # Organization namespace
    metadata TEXT,                        # JSON metadata
    created_at INTEGER,                   # Creation timestamp
    updated_at INTEGER,                   # Last update timestamp
    accessed_at INTEGER,                  # Last access timestamp
    access_count INTEGER DEFAULT 0,       # Number of times accessed
    ttl INTEGER,                          # Time-to-live in seconds
    expires_at INTEGER,                   # Expiration timestamp
    UNIQUE(key, namespace)
);
```

## 🔧 MCP Memory Tools

### 1. Memory Storage & Retrieval

```javascript
// Store memory
mcp__claude-flow__memory_usage {
    "action": "store",
    "key": "project/architecture",
    "value": "Microservices with event-driven communication",
    "namespace": "architecture",
    "ttl": 2592000  // 30 days
}

// Retrieve memory
mcp__claude-flow__memory_usage {
    "action": "retrieve",
    "key": "project/architecture",
    "namespace": "architecture"
}

// List all memories
mcp__claude-flow__memory_usage {
    "action": "list",
    "namespace": "default"
}
```

### 2. Memory Search

```javascript
// Search by pattern
mcp__claude-flow__memory_search {
    "pattern": "auth*",           // Finds all auth-related memories
    "namespace": "security",
    "limit": 10
}

// Search across namespaces
mcp__claude-flow__memory_search {
    "pattern": "*api*",
    "limit": 20
}
```

## 📚 Memory Organization Strategy

### Namespace Structure
Use namespaces to organize memories by category:

```yaml
Recommended Namespaces:
- default: General project information
- architecture: System design decisions
- security: Security configurations and decisions
- api: API designs and endpoints
- database: Schema and query patterns
- testing: Test strategies and patterns
- deployment: Deployment configurations
- performance: Optimization decisions
- research: Research findings
- decisions: Architectural decision records
```

### Key Naming Conventions

```bash
# Pattern: category/subcategory/specific
"api/auth/jwt-strategy"
"database/schema/users-table"
"architecture/decisions/microservices"
"testing/patterns/tdd-workflow"
"security/config/cors-settings"
```

## 🎯 Integration with Custom SWARM Agents

### Research Agent Memory Pattern

```bash
# When @researcher completes investigation
@researcher investigate OAuth 2.0 best practices and:
1. Save findings to /docs/phases/auth/research/
2. Store key insights in memory:
   - Key: "research/auth/oauth2-findings"
   - Namespace: "research"
   - TTL: 30 days
```

### Planner Agent Memory Pattern

```bash
# When @planner creates comprehensive issue
@planner coordinate 6 personas and:
1. Create GitHub issue with full details
2. Store planning decisions in memory:
   - Key: "planning/issue-123/decisions"
   - Namespace: "planning"
   - Include: architecture choices, dependencies
```

### Code Implementation Memory

```bash
# When @coder implements feature
@coder implement authentication and:
1. Follow patterns from memory
2. Store new patterns discovered:
   - Key: "patterns/auth/jwt-implementation"
   - Namespace: "implementation"
```

## 💡 Best Practices

### 1. Hierarchical Storage
```javascript
// Store related information hierarchically
"project/overview" → High-level project info
"project/phase1/requirements" → Phase-specific
"project/phase1/decisions/api" → Detailed decisions
```

### 2. Metadata Usage
```javascript
// Include rich metadata
{
    "action": "store",
    "key": "api/design/v2",
    "value": "RESTful API with GraphQL gateway",
    "metadata": {
        "decided_by": "senior-developer",
        "rationale": "Performance and flexibility",
        "related_issues": ["#45", "#67"],
        "tags": ["api", "architecture", "graphql"]
    }
}
```

### 3. TTL Strategy
```javascript
// Set appropriate TTLs
Research findings: 30 days (2592000 seconds)
Architecture decisions: No TTL (permanent)
Temporary patterns: 7 days (604800 seconds)
Session-specific: 1 day (86400 seconds)
```

### 4. Cross-Agent Coordination
```javascript
// Share context between agents
@researcher stores → "research/security/owasp-top10"
@planner reads → Creates security requirements
@tester reads → Writes security tests
@coder reads → Implements secure code
```

## 📊 Memory Usage Examples

### 1. Project Context Initialization
```javascript
// Beginning of project
mcp__claude-flow__memory_usage {
    "action": "store",
    "key": "project/context",
    "value": "E-commerce platform with microservices, React frontend, FastAPI backend",
    "namespace": "default"
}
```

### 2. Architecture Decision Records
```javascript
// ADR storage
mcp__claude-flow__memory_usage {
    "action": "store",
    "key": "adr/001-database-choice",
    "value": "PostgreSQL chosen for ACID compliance and JSON support",
    "namespace": "architecture",
    "metadata": {
        "date": "2025-07-30",
        "alternatives": ["MongoDB", "DynamoDB"],
        "decision_makers": ["architect", "senior-dev"]
    }
}
```

### 3. Pattern Library
```javascript
// Store successful patterns
mcp__claude-flow__memory_usage {
    "action": "store",
    "key": "patterns/error-handling/api",
    "value": "Consistent error response format with correlation IDs",
    "namespace": "patterns",
    "metadata": {
        "example": {
            "error": "ValidationError",
            "message": "Invalid input",
            "correlationId": "uuid-here"
        }
    }
}
```

## 🔍 Querying Strategies

### 1. Find Related Memories
```javascript
// Before implementing new feature
mcp__claude-flow__memory_search {
    "pattern": "*authentication*",
    "limit": 10
}
```

### 2. Check Existing Decisions
```javascript
// Before making architecture choice
mcp__claude-flow__memory_search {
    "pattern": "adr/*",
    "namespace": "architecture"
}
```

### 3. Retrieve Implementation Patterns
```javascript
// When coding similar feature
mcp__claude-flow__memory_search {
    "pattern": "patterns/*/api",
    "namespace": "patterns"
}
```

## 🚀 Command Line Usage

```bash
# Store memory via CLI
npx claude-flow@alpha memory store "key" "value" --namespace "custom"

# Retrieve memory
npx claude-flow@alpha memory get "key" --namespace "custom"

# Search memories
npx claude-flow@alpha memory search "pattern*"

# Export memories
npx claude-flow@alpha memory export backup.json

# Import memories
npx claude-flow@alpha memory import backup.json

# View statistics
npx claude-flow@alpha memory stats
```

## 📈 Memory Maintenance

### 1. Regular Cleanup
```javascript
// Remove expired memories
// Automatic based on TTL

// Manual cleanup of old entries
mcp__claude-flow__memory_usage {
    "action": "delete",
    "key": "old-pattern",
    "namespace": "temp"
}
```

### 2. Backup Strategy
```bash
# Regular backups
cp .swarm/memory.db .swarm/backups/memory-$(date +%Y%m%d).db

# Export to JSON for version control
npx claude-flow@alpha memory export > memory-backup.json
```

## 🎯 Integration with Custom Workflow

### Phase-Based Memory Usage

```yaml
Research Phase:
  - Store: Latest API docs, best practices, security guidelines
  - Namespace: "research"
  - TTL: 30 days

Planning Phase:
  - Store: Decisions, dependencies, timelines
  - Namespace: "planning"
  - TTL: None (permanent)

Implementation Phase:
  - Read: Patterns, decisions, requirements
  - Store: New patterns discovered
  - Namespace: "implementation"

Review Phase:
  - Read: All relevant memories
  - Store: Review outcomes, improvements
  - Namespace: "review"
```

## 🔒 Security Considerations

1. **No Secrets**: Never store API keys, passwords, or sensitive data
2. **Local Storage**: Database is local to your machine/workspace
3. **Access Control**: Use namespaces to organize access
4. **Regular Audits**: Review stored memories periodically

## 📊 Success Metrics

Track memory effectiveness:
- Reuse rate: How often memories are accessed
- Pattern discovery: New patterns stored vs used
- Decision consistency: ADRs referenced in implementation
- Time savings: Reduced research duplication

---

**Remember**: The memory system enhances your custom SWARM agents by providing persistent context. Use it to build institutional knowledge that improves with every project iteration.