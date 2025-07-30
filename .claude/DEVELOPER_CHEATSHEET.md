# DEVELOPER_CHEATSHEET.md - Practical Swarm Usage Guide

## 🎯 Quick Decision Tree

```
What are you building?
├── Bug fix (<2 hours) → No swarm, direct commands
├── Small feature (<1 day) → Mini swarm (2-3 agents)
├── Medium feature (1-3 days) → Standard swarm (5-6 agents)
├── Large feature (3-5 days) → Full swarm (8-10 agents)
└── Epic (>5 days) → Multi-issue with coordinated swarms
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

### 7. Documentation Update

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

**Pro tip**: Save your favorite prompts as snippets in your IDE for instant access!