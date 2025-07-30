# DEVELOPER_CHEATSHEET.md - Practical Swarm Usage Guide

## 📌 Key Updates (Based on Documentation Review)

### What's New:
1. **Best Practices Section** - 10 proven patterns for effective agent prompting
2. **Agent-Specific Patterns** - Tailored prompts for each custom agent type
3. **Memory Integration** - SQLite persistence for context retention
4. **Parallel Execution** - Mandatory for efficiency (up to 10x faster)
5. **Model Selection Guide** - When to use Sonnet 4 vs Opus 4
6. **MCP Integration** - Leverage 87 claude-flow MCP tools

### Critical Rules:
- **ALWAYS** start with research phase - no exceptions
- **ALWAYS** use parallel execution for multiple agents
- **ALWAYS** provide complete context upfront
- **NEVER** use Claude Flow default agents
- **NEVER** use Opus 4 except for complex coordination

## 🎯 Quick Decision Tree

```
What are you building?
├── Bug fix (<2 hours) → No swarm, direct commands
├── Small feature (<1 day) → Mini swarm (2-3 agents)
├── Medium feature (1-3 days) → Standard swarm (5-6 agents)
├── Large feature (3-5 days) → Full swarm (8-10 agents)
└── Epic (>5 days) → Multi-issue with coordinated swarms
```

## 🚀 Best Practices for Prompting Custom SWARM Agents

### 1. Always Use Parallel Execution
```bash
# ❌ WRONG: Sequential (slow and inefficient)
@researcher investigate feature
# wait for completion...
@planner create issue
# wait for completion...
@tester write tests

# ✅ RIGHT: Parallel in ONE message (fast and efficient)
Think harder about [FEATURE]. Execute in parallel:

@researcher investigate latest patterns and save to /docs/phases/[phase]/research/
@planner coordinate 6 personas to create comprehensive GitHub issue
@tester prepare test structure and scenarios

All agents work simultaneously with shared context.
```

### 2. Provide Complete Context Upfront
```bash
# ❌ WRONG: Vague instructions
@coder implement authentication

# ✅ RIGHT: Complete context with constraints
@coder implement JWT authentication with:
- Supabase integration using existing RLS policies
- Token refresh every 15 minutes
- Session storage in httpOnly cookies
- Follow existing auth patterns in src/lib/auth/
- Use TypeScript strict mode
- Include error handling for all edge cases
```

### 3. Use Custom Agents, Not Defaults
```bash
# ❌ WRONG: Using Claude Flow defaults
/sparc dev --task "build feature"

# ✅ RIGHT: Use our custom agents
@researcher investigate best practices
@planner orchestrate comprehensive planning
@tester create TDD test suite
@coder implement to pass tests
```

### 4. Memory System for Context Retention
```bash
# Store critical decisions and patterns
@researcher store findings:
mcp__claude-flow__memory_usage {
    "action": "store",
    "key": "architecture/auth-pattern",
    "value": "JWT with Supabase RLS, 15min refresh",
    "namespace": "decisions",
    "ttl": 2592000  # 30 days
}

# Retrieve for consistency
@coder before implementing, retrieve:
mcp__claude-flow__memory_usage {
    "action": "retrieve",
    "key": "architecture/auth-pattern",
    "namespace": "decisions"
}
```

### 5. Model Selection Strategy
```bash
# Use Sonnet 4 for most tasks (fast, capable, cost-effective)
@researcher with model:claude-sonnet-4 investigate patterns
@tester with model:claude-sonnet-4 create test suite
@reviewer with model:claude-sonnet-4 validate quality

# Use Opus 4 ONLY for complex coordination
@planner with model:claude-opus-4 coordinate 6 personas
@epic-planner with model:claude-opus-4 decompose large project
```

### 6. Research-First Methodology
```bash
# ALWAYS start with research phase - no exceptions
Think ultrahard about [FEATURE]. First research, then plan:

@researcher investigate:
1. Latest [TECHNOLOGY] best practices 2025
2. Current OpenAI models and pricing (gpt-4o: $2.50/1M)
3. Available MCP tools: npx claude-flow@alpha mcp list --details
4. Security requirements (OWASP current year)
5. Similar patterns in codebase

Save ALL findings to /docs/phases/[phase]/research/
Store key decisions in SQLite memory for reuse
```

### 7. Effective Agent Coordination
```bash
# Coordinate sub-agents with clear responsibilities
@planner orchestrate feature planning:

Spawn these personas IN PARALLEL:
@product-owner: User stories with BDD acceptance criteria
@project-manager: Timeline with 20% buffer, dependency graph
@senior-developer: Architecture with ACTUAL CODE (no TODOs)
@test-writer: Complete test implementations (not descriptions)
@frontend-expert: React components with TypeScript code
@security-expert: Threat model and implementation details

Output: Single GitHub issue as executable specification
```

### 8. TDD Enforcement Pattern
```bash
# Red-Green-Refactor cycle is mandatory
@tester create comprehensive test suite:
- Write FAILING tests first (red phase)
- Include unit (70%), integration (20%), E2E (10%)
- Tests must fail for the right reasons
- Commit tests before any implementation

Then and ONLY then:
@coder implement to make tests pass (green phase)
@reviewer refactor for quality (refactor phase)
```

### 9. Batch Operations for Efficiency
```bash
# ❌ WRONG: Individual operations
Create todo 1
Create todo 2
Read file A
Read file B

# ✅ RIGHT: Batch everything
Single message with multiple operations:
- TodoWrite: Create 5-10 todos at once
- Read: Multiple files in parallel
- Agent spawn: All agents simultaneously
- Memory ops: Store/retrieve in batches
```

### 10. Clear Output Expectations
```bash
# Be explicit about output format and location
@researcher output structure:
/docs/phases/[phase]/research/
├── best-practices.md       # Current patterns
├── api-documentation.md    # With version numbers
├── security-matrix.md      # Vulnerabilities table
├── tool-availability.md    # MCP tools list
└── cost-estimate.md        # Token and $ budgets

Include code examples, not descriptions
Verify all sources < 6 months old
```

## 🚀 Copy-Paste Prompts by Scenario

### 1. Starting a New Epic (Multi-Feature Project)

```bash
# Use when: Building something that needs 3+ related features
# Swarm size: 8 agents (epic planning team)

Think ultrahard about creating an epic for [PROJECT NAME].

First, @researcher investigate:
- Current best practices for [MAIN TECHNOLOGY]
- Similar successful implementations
- Required integrations and APIs
- Security considerations
- Cost estimates for infrastructure

Then spawn epic planning team:
@epic-planner break this into 3-5 manageable features
@architect design overall system architecture
@security-expert identify security requirements across all features
@devops plan deployment strategy
@cost-analyst estimate total budget

Output:
1. Epic issue with feature breakdown
2. Dependency graph between features
3. Resource allocation per feature
4. Timeline with parallel work streams

Include in epic:
- Swarm size per feature (usually 5-6 agents)
- Shared research to avoid duplication
- Integration test strategy
```

### 2. Creating a Single Feature Issue

```bash
# Use when: Implementing one complete feature (1-3 days)
# Swarm size: 6 agents (standard team)

Think harder about implementing [FEATURE NAME].

Research phase:
@researcher find latest patterns for [SPECIFIC TECH] and save to /docs/phases/[PHASE]/research/

Planning phase - spawn all 6 personas:
@product-owner define user stories with measurable success criteria
@project-manager identify dependencies and create realistic timeline
@senior-developer write technical design with ACTUAL CODE SNIPPETS
@test-writer create COMPLETE test implementations (not descriptions)
@frontend-expert design UI components with React/TypeScript code
@security-expert specify security measures with implementation details

Create GitHub issue with:
- Complete code examples (no placeholders like "implement here")
- Full test suite code (pytest/jest)
- Exact database schemas
- API endpoint implementations
- Security measures
- Token budget: 500k total

Recommended swarm config:
```yaml
agents:
  researcher: 1 (sequential)
  planner: 1 (coordinates 6 personas)
  tester: 2 (unit + e2e)
  coder: 2 (backend + frontend)
  reviewer: 1
execution: parallel_tdd
```
```

### 3. Implementing from Existing Issue

```bash
# Use when: Issue already exists with specifications
# Swarm size: 4-5 agents (implementation team)

Think about implementing issue #[NUMBER] using TDD approach.

@tester read issue #[NUMBER] and create comprehensive test suite:
- Unit tests for all functions
- Integration tests for APIs
- E2E tests for user flows
- Security tests for vulnerabilities
- Performance benchmarks
Ensure all tests FAIL initially (red phase)

Then parallel implementation:
@backend-coder implement API endpoints to pass tests
@frontend-coder implement UI to pass E2E tests

Finally:
@reviewer verify code quality and security
@performance-optimizer ensure <100ms response times

Swarm config: parallel_implementation with test_first guard
```

### 4. Quick Feature Addition

```bash
# Use when: Adding small feature to existing code (<1 day)
# Swarm size: 2-3 agents (mini team)

@senior-developer design approach for [SMALL FEATURE]

Then:
@tester write focused tests for new functionality
@coder implement feature to pass tests

No research needed - use existing patterns from codebase
```

### 5. Bug Fix / Debugging

```bash
# Use when: Fixing specific bug or error
# Swarm size: 0-1 agents (usually direct)

# Simple bug (no swarm):
Debug this error: [PASTE ERROR]
The error occurs when [CONTEXT]
Existing tests are in tests/[PATH]

# Complex bug (1 agent):
@debugger investigate root cause of [BUG DESCRIPTION]:
- Analyze stack trace
- Check related code paths
- Identify edge cases
- Write regression tests
- Implement fix
```

### 6. Code Review / Refactoring

```bash
# Use when: Improving existing code
# Swarm size: 3 agents (quality team)

Review and refactor [MODULE/FEATURE]:

@code-reviewer analyze for:
- Code smells
- Performance issues
- Security vulnerabilities
- Maintainability

@refactor-expert improve:
- Extract common patterns
- Reduce complexity
- Improve naming
- Add type safety

@tester ensure:
- All existing tests pass
- Add missing test coverage
- Performance doesn't degrade
```

### 7. Module Organization & MCP Creation

```bash
# Use when: Organizing code into modules or creating MCPs
# Swarm size: 1-2 agents

# Analyze project for modular boundaries
@modular-designer analyze project structure:
- Identify module boundaries
- Detect MCP candidates (3+ similar implementations)
- Generate AI-optimized READMEs
- Create MCP configurations

# Quick MCP detection
./.claude/scripts/detect-mcp-candidates.sh

# Example output:
✓ Strong MCP Candidate: ./agents/llm_providers
  - Implementations: 5 (openai, anthropic, google, cohere, mistral)
  - Has Interface: true
  - MCP Score: 3/3
```

### 8. Documentation Update

```bash
# Use when: Creating/updating docs
# Swarm size: 0-2 agents

# Simple docs (no swarm):
Update README to include [NEW FEATURE]
Add API documentation for [ENDPOINTS]

# Comprehensive docs (2 agents):
@doc-writer create full documentation for [PROJECT]:
- Getting started guide
- API reference
- Architecture diagrams
- Deployment guide

@reviewer ensure accuracy and completeness
```

## 📊 Swarm Size Guidelines

### No Swarm (0 agents) - Direct Commands
- Bug fixes with clear solutions
- Documentation updates
- Config changes
- Simple refactoring
- Code formatting

### Mini Swarm (2-3 agents)
- Small features (<1 day)
- Focused refactoring
- Performance optimization
- Adding tests to existing code

### Standard Swarm (5-6 agents)
- Complete features (1-3 days)
- API endpoints with UI
- Database schema changes
- Integration work

### Full Swarm (8-10 agents)
- Large features (3-5 days)
- System redesigns
- Multi-service integration
- Performance overhauls

## 🎨 When to Include Swarm Config

### Always Include Config When:
```yaml
# Complex coordination needed
swarm_config:
  execution: parallel_tdd
  agents: 6
  test_first: true
  
# Multiple phases
phases:
  research: sequential
  planning: parallel
  implementation: parallel_after_tests
  
# Specific agent roles
agents:
  security-specialist: "Focus on OAuth implementation"
  performance-expert: "Optimize database queries"
```

### Skip Config When:
- Simple, straightforward tasks
- Single agent work
- Following standard patterns
- Bug fixes

## 🧪 TDD Guidelines

### Always Use TDD When:
- Building new features
- Refactoring critical code
- Fixing complex bugs
- API development
- Working with financial/security code

**TDD Prompt Pattern:**
```bash
@tester create failing tests for [FEATURE]
# WAIT for completion
@coder implement to make tests pass
# Tests are the specification!
```

### Can Skip TDD When:
- UI-only changes
- Documentation
- Config updates
- Prototyping/experiments

## 💾 Real Data Usage

### Use Real Data When:
- Performance testing
- Data migration scripts
- Reporting features
- ML/AI features

**Real Data Prompt:**
```bash
@data-engineer create realistic test dataset:
- 10,000 user records
- 50,000 transactions
- Edge cases included
- Performance test ready
```

### Use Mock Data When:
- Unit tests
- UI development
- API development
- Security testing

## ⚡ Performance Tips

### 1. Front-load Research
```bash
# Do extensive research ONCE per epic
@researcher investigate ALL aspects of [EPIC] and save to /docs/epics/[NAME]/research/
# All features reference this shared research
```

### 2. Parallel Everything Possible
```bash
# Bad: Sequential
@tester create unit tests
@tester create integration tests
@tester create e2e tests

# Good: Parallel
parallel -j 3 ::: \
  "@tester create unit tests" \
  "@tester create integration tests" \
  "@tester create e2e tests"
```

### 3. Reuse Agent Configurations
```bash
# Define once in .claude/agents/
# Reuse across all features
@standard-tester  # Uses predefined config
@standard-coder   # Uses predefined config
```

### 4. Cost Optimization
```bash
# Expensive model for complex tasks
@architect design with model:gpt-4o

# Cheap model for simple tasks
@tester write tests with model:gpt-4o-mini
```

## 🚨 Common Mistakes to Avoid

### ❌ Vague Instructions
```bash
# Bad
Implement user authentication

# Good
@planner create GitHub issue for JWT authentication with:
- Complete API endpoints code
- Database schema for sessions
- Test implementations
- Security measures
```

### ❌ Skipping Tests
```bash
# Bad
@coder implement feature quickly

# Good
@tester create tests first
@coder implement to pass tests
```

### ❌ Sequential When Could Be Parallel
```bash
# Bad
@backend-coder implement API
# wait...
@frontend-coder implement UI

# Good
parallel -j 2 ::: "@backend-coder implement API" "@frontend-coder implement UI"
```

### ❌ Over-engineering Simple Tasks
```bash
# Bad (for adding a button)
Spawn 8 agent swarm for UI button

# Good
Add button to trigger [ACTION] in [COMPONENT]
```

## 📱 Quick Reference Card

```
SWARM SIZES:
0 agents  = Bug fixes, docs
2-3       = Small features  
5-6       = Standard features
8-10      = Large features/epics

ALWAYS INCLUDE:
- Actual code (not "implement here")
- Complete tests (not "write tests")  
- Real examples (not placeholders)
- Token budgets for swarms

PARALLEL WHEN:
- Planning (6 personas)
- Implementation (backend/frontend)
- Reviews (quality/security/perf)

SEQUENTIAL WHEN:
- Research
- Test creation (before code)
- Deployment
```

## 🎯 One-Line Starters

```bash
# New epic
"Think ultrahard about [EPIC]. Research, then plan with 8 agents."

# New feature  
"Think harder about [FEATURE]. Research, 6 personas plan, then TDD."

# From issue
"Implement issue #X using TDD. Tests first, parallel coding, review."

# Bug fix
"Debug [ERROR]. Find root cause, write test, fix."

# Quick add
"Add [SMALL FEATURE] using existing patterns. Mini swarm if needed."
```

---

## 🤖 Agent-Specific Prompting Patterns

### Researcher Agent
```bash
# Exhaustive investigation with multi-source validation
@researcher investigate [FEATURE] with sub-agents:
@api-researcher: Find official docs, SDK examples, rate limits
@security-researcher: OWASP guidelines, vulnerability databases
@pattern-researcher: Architecture patterns, scaling strategies

Requirements:
- Verify dates < 6 months old
- Include code examples
- Calculate cost implications
- Save to /docs/phases/[phase]/research/
```

### Planner Agent (Opus 4)
```bash
# Multi-persona orchestration for comprehensive issues
@planner coordinate planning for [FEATURE]:

Context for all personas:
- Feature: [DESCRIPTION]
- Research: /docs/phases/[phase]/research/*
- Stack: React, TypeScript, FastAPI, Supabase
- Standards: >95% coverage, <100ms response

Spawn 6 personas simultaneously
Synthesize outputs into GitHub issue
Validate completeness >95% before creation
```

### Tester Agent
```bash
# TDD test creation before implementation
@tester create failing test suite for [FEATURE]:

Structure:
- Unit tests (70%): Service logic, edge cases
- Integration (20%): API contracts, database
- E2E (10%): User workflows, accessibility

Requirements:
- All tests MUST fail initially
- No implementation code
- Include performance benchmarks
- Commit before coding starts
```

### Coder Agents
```bash
# Implementation to pass tests
@backend-coder implement API to pass tests:
- Follow FastAPI patterns in src/api/
- Use Pydantic v2 for validation
- Include comprehensive error handling
- Optimize database queries

@frontend-coder implement UI to pass E2E tests:
- Use existing component patterns
- Zustand for state management
- TypeScript strict mode
- Accessibility WCAG 2.1 AA
```

### Reviewer Agent
```bash
# Quality assurance and optimization
@reviewer validate implementation:
- Code quality and patterns
- Security vulnerabilities
- Performance bottlenecks
- Test coverage >95%
- Documentation completeness

Output: Actionable improvements only
```

## 📋 Common Agent Combinations

### For New Features
```bash
# Standard feature team (parallel execution)
@researcher → @planner → @tester → @coder → @reviewer
```

### For Bug Fixes
```bash
# Minimal team
@debugger investigate root cause
@tester write regression tests
@coder implement fix
```

### For Refactoring
```bash
# Quality team
@code-reviewer analyze technical debt
@refactor-expert improve architecture
@tester ensure no regressions
```

## 💾 Memory Patterns for Agents

### Store Architecture Decisions
```bash
@planner after planning:
Store ADR (Architecture Decision Record):
- Key: "adr/[date]-[feature]"
- Namespace: "architecture"
- Value: JSON with decision, rationale, alternatives
```

### Reuse Successful Patterns
```bash
@coder before implementing:
Search memory for similar implementations:
- Pattern: "*auth*" in namespace "patterns"
- Use proven approaches from past features
```

### Track Performance Metrics
```bash
@reviewer after optimization:
Store performance baseline:
- Key: "perf/[feature]/baseline"
- Value: Response times, memory usage
- TTL: 90 days for trending
```

## 🔧 MCP (Model Context Protocol) Quick Reference

### Available MCP Tools (87 total)
```bash
# Start MCP server with all features
npx claude-flow@alpha mcp start --auto-orchestrator --enable-neural --enable-wasm

# List tools by category
npx claude-flow@alpha mcp tools --category=swarm    # 12 swarm tools
npx claude-flow@alpha mcp tools --category=neural   # 15 AI tools
npx claude-flow@alpha mcp tools --category=memory   # 12 persistence tools
npx claude-flow@alpha mcp tools --category=workflow # 11 automation tools
```

### Common MCP Patterns
```bash
# Spawn agents using MCP
mcp__claude-flow__agent_spawn {
  "type": "researcher",
  "capabilities": ["web_search", "analysis"]
}

# Orchestrate parallel tasks
mcp__claude-flow__task_orchestrate {
  "task": "Analyze codebase for improvements",
  "strategy": "parallel",
  "maxAgents": 5
}

# Store in persistent memory
mcp__claude-flow__memory_usage {
  "action": "store",
  "key": "project/decisions/auth",
  "value": "JWT with 15min refresh",
  "namespace": "architecture"
}

# Create automated workflow
mcp__claude-flow__workflow_create {
  "name": "test-and-deploy",
  "steps": ["test", "build", "deploy"]
}
```

### MCP Performance Benefits
- 🚀 2.8-4.4x speed improvement
- 📉 32.3% token reduction
- 🎯 84.8% SWE-Bench solve rate
- ⚡ WASM neural processing

**Pro tip**: Save your favorite prompts as snippets in your IDE for instant access!