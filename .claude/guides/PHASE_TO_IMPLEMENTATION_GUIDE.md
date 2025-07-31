# Phase to Implementation Guide - Complete Autonomous Workflow

## 🚀 Overview: From Phase Plan to Production Code

This guide provides a **complete, autonomous workflow** for transforming phase plans into implemented features using SWARM methodology, requiring minimal human intervention.

## ✅ Pre-Implementation Checklist

Before starting, ensure the phase plan includes:
- [ ] Feature requirements and acceptance criteria
- [ ] Data models and schemas
- [ ] API endpoints or UI components needed
- [ ] Performance and scaling requirements
- [ ] Security considerations
- [ ] Integration points with existing features

**If phase plan is insufficient**: Claude will request clarification ONCE before proceeding.

## 🔄 Complete Workflow with Specific Agents

### Phase 1: Research & Analysis (2-3 hours)
```yaml
swarm_configuration:
  topology: hierarchical
  max_agents: 10
  execution: parallel
  
agents:
  coordinator:
    type: orchestrator
    model: claude-opus-4
    role: Manage entire workflow
    
  research_team:
    - api_researcher:
        model: claude-sonnet-4
        tasks:
          - Latest API docs (OpenAI, Stripe, etc.)
          - Pricing updates
          - Breaking changes
        files_generated: /docs/phases/[phase]/research/api-findings.md
        
    - pattern_researcher:
        model: claude-sonnet-4
        tasks:
          - Current best practices 2025
          - Framework updates
          - Security advisories
        files_generated: /docs/phases/[phase]/research/patterns.md
        
    - mcp_researcher:
        model: claude-sonnet-4
        tasks:
          - Available MCP tools scan
          - Supabase MCP capabilities
          - Integration opportunities
        commands:
          - npx claude-flow@alpha mcp list --details
          - npx claude-flow@alpha mcp tools --category=supabase
```

### Phase 2: Epic & Issue Creation (1-2 hours)
```yaml
planning_swarm:
  execution: parallel_personas
  
  epic_planner:
    model: claude-opus-4
    sub_agents:
      - product_owner:
          focus: User value and acceptance criteria
          deliverable: User stories with BDD scenarios
          
      - project_manager:
          focus: Timeline, dependencies, resources
          deliverable: Gantt chart, critical path
          
      - senior_developer:
          focus: Technical architecture
          deliverable: Component diagrams, API specs
          
      - test_writer:
          focus: Test strategy
          deliverable: Test matrix, coverage goals
          
      - frontend_expert:
          focus: UI/UX requirements
          deliverable: Component specs, state management
          
      - security_expert:
          focus: Security requirements
          deliverable: Threat model, auth strategy
    
    github_commands:
      - gh issue create --title "Epic: [FEATURE]" --body "[EPIC_CONTENT]" --label epic
      - gh issue create --title "[FEATURE]: [COMPONENT]" --body "[ISSUE_CONTENT]" --label feature
```

### Phase 3: Implementation Per Issue (1-2 days/issue)
```yaml
implementation_swarm:
  execution: parallel_tdd
  hooks:
    pre_edit: "npx claude-flow@alpha validate --file '${file}'"
    post_test: "npx claude-flow@alpha coverage --min 95"
    pre_commit: "npx claude-flow@alpha lint --fix"
  
  test_team:
    - unit_tester:
        model: claude-sonnet-4
        coverage_target: 70%
        tools:
          - pytest (backend)
          - jest (frontend)
        real_data_validation: true
        
    - integration_tester:
        model: claude-sonnet-4
        coverage_target: 20%
        supabase_mcp:
          - mcp__supabase__query: Test data scenarios
          - mcp__supabase__rpc: Function testing
          
    - e2e_tester:
        model: claude-sonnet-4
        coverage_target: 10%
        tools:
          - playwright
          - real user scenarios
  
  implementation_team:
    - backend_coder:
        model: claude-opus-4
        parallel_with: frontend_coder
        supabase_integration:
          - mcp__supabase__create_table
          - mcp__supabase__create_rls_policy
          - mcp__supabase__create_function
        batch_operations:
          - Create all models
          - Create all endpoints
          - Create all validators
          
    - frontend_coder:
        model: claude-opus-4
        parallel_with: backend_coder
        batch_operations:
          - Create all components
          - Create all hooks
          - Create all stores
          
    - db_specialist:
        model: claude-sonnet-4
        tasks:
          - Schema optimization
          - Index creation
          - RLS policies
        supabase_mcp:
          - mcp__supabase__migrate
          - mcp__supabase__seed
```

## 📋 Detailed Process Steps

### Step 1: Initial Analysis & Validation
```bash
# Claude automatically executes:
Think ultrahard about implementing [FEATURE] from /docs/phases/[PHASE]/[PLAN].md

# Parallel validation tasks:
@validator check phase plan completeness
@researcher investigate current best practices
@analyzer identify integration points

# If plan insufficient:
HUMAN REQUIRED: "Phase plan missing [SPECIFIC_ITEMS]. Please provide:
1. [Missing requirement 1]
2. [Missing requirement 2]"
```

### Step 2: Research Phase (Fully Automated)
```bash
# Spawn research swarm in parallel:
@api_researcher investigate:
  - Latest [TECHNOLOGY] docs
  - API pricing (store in memory)
  - Breaking changes since last check
  
@pattern_researcher find:
  - 2025 best practices
  - Similar implementations
  - Performance benchmarks
  
@mcp_researcher catalog:
  - All relevant MCP tools
  - Supabase capabilities
  - Integration patterns

# Store findings:
mcp__claude-flow__memory_usage {
  "action": "store",
  "namespace": "research",
  "key": "phase-[NUMBER]-findings",
  "value": "[RESEARCH_SUMMARY]",
  "ttl": 2592000
}
```

### Step 3: Epic Creation with 6 Personas
```bash
# Automatic epic generation:
@epic_planner spawn 6 personas IN PARALLEL:

Each persona creates COMPLETE deliverables:
- Working code examples (no TODOs)
- Exact API implementations
- Full test scenarios
- Precise configurations

# GitHub integration:
gh issue create --title "Epic: [FEATURE]" \
  --body "[COMPLETE_EPIC]" \
  --label "epic,swarm-generated" \
  --assignee "@me"

# Create child issues:
parallel -j 6 ::: \
  "gh issue create --title 'Backend: [API]' --body '[DETAILS]'" \
  "gh issue create --title 'Frontend: [UI]' --body '[DETAILS]'" \
  "gh issue create --title 'Database: [SCHEMA]' --body '[DETAILS]'" \
  "gh issue create --title 'Tests: [COVERAGE]' --body '[DETAILS]'" \
  "gh issue create --title 'Docs: [API]' --body '[DETAILS]'" \
  "gh issue create --title 'Deploy: [CONFIG]' --body '[DETAILS]'"
```

### Step 4: TDD Implementation (Per Issue)
```bash
# Automatic test creation FIRST:
@test_team create failing tests:
  - Unit tests with real data scenarios
  - Integration tests using Supabase MCP
  - E2E tests with Playwright

# Parallel implementation:
parallel -j 3 ::: \
  "@backend_coder implement API to pass tests" \
  "@frontend_coder implement UI to pass tests" \
  "@db_specialist optimize queries"

# Real data validation:
@validator verify with production-like data:
  - Load test with 10k records
  - Concurrent user simulation
  - Edge case scenarios
  
# Supabase integration:
mcp__supabase__query {
  "query": "SELECT * FROM [TABLE] WHERE [CONDITIONS]",
  "params": {"real_data": true}
}
```

### Step 5: Integration & Verification
```bash
# Automatic integration testing:
@integration_specialist run:
  - Cross-feature compatibility
  - Performance benchmarks
  - Security scan
  
# Create PR:
gh pr create \
  --title "feat: [FEATURE] - Issue #[NUMBER]" \
  --body "[IMPLEMENTATION_SUMMARY]" \
  --reviewer "[TEAM]" \
  --label "ready-for-review"
```

## 🛠️ Tools & Integrations

### GitHub CLI Commands Used
```bash
# Issue management
gh issue create --title "[TITLE]" --body "[BODY]" --label "[LABELS]"
gh issue list --label "epic"
gh issue view [NUMBER]
gh issue edit [NUMBER] --add-assignee "[USER]"

# PR workflow
gh pr create --title "[TITLE]" --body "[BODY]"
gh pr checks
gh pr merge --auto --squash
```

### Supabase MCP Integration
```javascript
// Database operations
mcp__supabase__create_table({
  name: "conversations",
  columns: { /* schema */ }
})

mcp__supabase__create_rls_policy({
  table: "conversations",
  policy: "users_own_data"
})

// Data operations
mcp__supabase__insert({
  table: "messages",
  data: { /* real data */ }
})

mcp__supabase__query({
  query: "SELECT * FROM messages WHERE user_id = $1",
  params: [userId]
})

// Real-time
mcp__supabase__subscribe({
  table: "messages",
  event: "INSERT"
})
```

### Hooks Configuration
```json
{
  "preEditHook": {
    "command": "npx claude-flow@alpha lint --check '${file}'",
    "blocking": true
  },
  "postTestHook": {
    "command": "npx claude-flow@alpha coverage --file '${file}' --min 95",
    "blocking": true
  },
  "preCommitHook": {
    "command": "npm run format && npm run lint:fix",
    "blocking": true
  }
}
```

## 🎯 Complete Implementation Checklist

### Pre-Implementation
- [ ] Phase plan validated for completeness
- [ ] Research completed and stored in memory
- [ ] MCP tools identified and configured
- [ ] Epic created with all child issues
- [ ] Swarm configuration defined

### During Implementation
- [ ] Tests written FIRST (TDD)
- [ ] All tests failing initially
- [ ] Parallel implementation active
- [ ] Real data validation included
- [ ] Supabase MCP used for data operations
- [ ] Hooks running on file changes
- [ ] Performance benchmarks met

### Post-Implementation
- [ ] All tests passing (>95% coverage)
- [ ] Integration tests complete
- [ ] PR created with GitHub CLI
- [ ] Documentation updated
- [ ] Monitoring configured
- [ ] Deployment scripts ready

### Human Requirements
- [ ] **Initial**: Provide phase plan link
- [ ] **If needed**: Clarify missing requirements
- [ ] **Final**: Approve PR for production
- [ ] **Optional**: Performance testing at scale

## 📊 Process Tracking

### Files Generated Per Phase
```yaml
research_phase:
  - /docs/phases/[phase]/research/api-findings.md
  - /docs/phases/[phase]/research/patterns.md
  - /docs/phases/[phase]/research/mcp-tools.md
  - /docs/phases/[phase]/research/cost-analysis.md

planning_phase:
  - /docs/phases/[phase]/epic.md
  - /docs/phases/[phase]/issues/issue-[NUMBER].md
  - /docs/phases/[phase]/architecture/components.md
  - /docs/phases/[phase]/test-strategy.md

implementation_phase:
  - /src/[feature]/models.py
  - /src/[feature]/api.py
  - /tests/test_[feature].py
  - /frontend/components/[Feature].tsx
  - /docs/api/[feature].md
```

### Agent Performance Metrics
```yaml
token_usage:
  research: ~500k tokens
  planning: ~800k tokens
  implementation: ~1.5M tokens per issue
  total_budget: 5M tokens per epic

execution_time:
  research: 2-3 hours
  planning: 1-2 hours
  implementation: 1-2 days per issue
  
parallel_efficiency:
  research: 3x faster with parallel agents
  implementation: 2.5x faster with parallel coding
```

## 🚀 Single Command Execution

For complete automation, use:
```bash
# One command to rule them all
claude "Implement the complete feature from /docs/phases/[PHASE]/[PLAN].md 
using our SWARM methodology. Create epic, all issues, and implement 
issue #1 with full TDD, real data validation, and Supabase integration."
```

## ⚠️ Failure Handling

### Automatic Recovery
- Failed tests: Re-run with detailed diagnostics
- API errors: Retry with exponential backoff
- Timeout: Break into smaller parallel tasks

### Human Escalation Triggers
1. Phase plan missing critical information
2. Conflicting requirements detected
3. Security vulnerability found
4. Performance requirements impossible
5. Cost exceeds budget by >20%

## 📈 Success Metrics

- **Autonomous completion**: 85% without human intervention
- **Test coverage**: >95% with real data
- **Performance**: Meets all stated requirements
- **Time efficiency**: 2.5x faster than sequential
- **Cost efficiency**: Within token budget
- **Quality**: Zero critical bugs in production

---

**Remember**: This workflow is designed for maximum automation. Human intervention is only required for initial input and final approval. All research, planning, implementation, and testing happens automatically with parallel agent execution.