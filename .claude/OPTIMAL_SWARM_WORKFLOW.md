# OPTIMAL_SWARM_WORKFLOW.md - The Complete Guide

## 🎯 Purpose

This is the master guide for Claude Code to execute feature development using native sub-agents and Claude Flow swarms. Follow this workflow for maximum effectiveness.

## 📁 Required File Structure

```
project/
├── .claude/
│   ├── CLAUDE.md                    # Base instructions
│   ├── OPTIMAL_SWARM_WORKFLOW.md    # This file
│   ├── SWARM_EXECUTION_GUIDE.md     # Detailed steps
│   ├── SWARM_QUICK_REFERENCE.md     # Quick commands
│   ├── EPIC_BREAKDOWN_EXAMPLES.md   # Epic patterns
│   └── agents/                      # Agent definitions
│       ├── researcher.md
│       ├── epic-planner.md
│       ├── planner.md
│       ├── product-owner.md
│       ├── project-manager.md
│       ├── senior-developer.md
│       ├── test-writer.md
│       ├── frontend-expert.md
│       ├── security-expert.md
│       ├── tester.md
│       ├── backend-coder.md
│       ├── frontend-coder.md
│       └── reviewer.md
├── docs/
│   ├── phases/                      # Phase documentation
│   └── epics/                       # Epic breakdowns
└── .github/
    └── ISSUE_TEMPLATE/
        ├── swarm-epic.yml
        └── swarm-task.yml
```

## 🚀 The Optimal Workflow

### Step 0: Initialization (One Time)

```bash
# Verify setup
test -d .claude/agents || mkdir -p .claude/agents
test -f .claude/CLAUDE.md || echo "ERROR: Missing CLAUDE.md"
gh auth status || gh auth login
npx claude-flow@alpha --version || npm install -g claude-flow@alpha
```

### Step 1: Receive Requirements

When given a task/phase/feature, first determine scope:

```python
def analyze_scope(feature):
    if feature.estimated_days > 3 or feature.components > 3:
        return "EPIC"  # Multiple issues needed
    else:
        return "SINGLE_ISSUE"  # One comprehensive issue
```

### Step 2: Research Phase (ALWAYS FIRST!)

```bash
# Configure researcher for maximum effectiveness
@researcher with settings:
  context_budget: 100000
  parallel_searches: 5
  save_all_findings: true
  
# Execute comprehensive research
@researcher investigate $FEATURE_NAME:
1. Latest best practices (web search: "$FEATURE 2025 best practices")
2. Current OpenAI models and pricing (web search: "OpenAI API pricing gpt-4o")
3. Available MCP tools (execute: npx claude-flow@alpha mcp list --details)
4. Security requirements (web search: "$FEATURE OWASP security")
5. Similar code in project (search codebase for patterns)

# Save to structured format
/docs/phases/$PHASE_NAME/research/
├── best-practices.md       # Latest patterns and approaches
├── openai-current.md       # API details and costs  
├── mcp-available.json      # Tool capabilities
├── security-matrix.md      # Vulnerabilities to prevent
├── codebase-patterns.md    # Existing conventions
└── cost-estimate.md        # Token and dollar budgets
```

### Step 3: Epic or Issue Decision

```bash
# For EPIC (large features)
if [[ $SCOPE == "EPIC" ]]; then
    @epic-planner create epic breakdown:
    - Analyze feature complexity
    - Identify logical separations  
    - Create 3-6 sub-issues
    - Define dependencies
    - Allocate resources
    
    # Create epic issue
    gh issue create --title "[EPIC] $FEATURE_NAME" \
        --label "epic,swarm" \
        --body "$(cat epic-template.md)"
    
    # Generate sub-issues
    for component in "${COMPONENTS[@]}"; do
        create_comprehensive_issue "$component"
    done
else
    # For SINGLE_ISSUE
    create_comprehensive_issue "$FEATURE_NAME"
fi
```

### Step 4: Multi-Persona Issue Creation

This is the CRITICAL step - creating a comprehensive issue with ALL details:

```bash
# Spawn 6 personas in parallel for complete perspectives
parallel -j 6 << 'PERSONAS'
@product-owner write:
  - User stories with acceptance criteria
  - Business value and ROI
  - Success metrics (measurable!)
  Output: /tmp/swarm/product.md

@project-manager create:
  - Timeline with milestones
  - Dependencies (internal and external)
  - Risk assessment and mitigation
  Output: /tmp/swarm/project.md

@senior-developer design:
  - System architecture (with diagrams)
  - API design with actual code
  - Database schema (complete SQL)
  - Integration patterns
  Output: /tmp/swarm/technical.md

@test-writer specify:
  - Complete test implementations (not descriptions!)
  - Unit tests with pytest code
  - Integration tests with examples
  - E2E tests with Playwright scripts
  Output: /tmp/swarm/tests.md

@frontend-expert architect:
  - Component hierarchy
  - State management design
  - Responsive approach
  - Actual React code examples
  Output: /tmp/swarm/frontend.md

@security-expert define:
  - Threat model
  - Security requirements
  - Implementation specifics
  - Audit checklist
  Output: /tmp/swarm/security.md
PERSONAS

# Wait for all personas
wait

# Merge into comprehensive issue
@planner synthesize all persona outputs into single GitHub issue:
- Must include actual code (not placeholders)
- Must include complete test code
- Must include security implementation
- Must include token budgets
- Must include parallel execution plan
```

### Step 5: GitHub Issue Creation

```bash
# Create the issue with all details
gh issue create \
  --repo $GITHUB_REPO \
  --title "[SWARM] $FEATURE_NAME" \
  --label "swarm,phase-$PHASE_NUMBER,tdd" \
  --body "$(generate_comprehensive_issue_body)"

# Capture issue number
ISSUE_NUMBER=$(gh issue list --limit 1 --json number -q '.[0].number')

# Verify issue quality
ISSUE_QUALITY=$(analyze_issue_completeness $ISSUE_NUMBER)
if [[ $ISSUE_QUALITY -lt 90 ]]; then
    echo "WARNING: Issue lacks detail. Enhancing..."
    @planner enhance issue $ISSUE_NUMBER with missing details
fi
```

### Step 6: TDD Implementation Flow

```bash
# CRITICAL: Tests MUST be created first!

# 6.1: Test Creation Phase
@tester configure:
  tools: [file_write, file_read, bash, playwright_mcp]
  context_budget: 150000
  constraint: "NEVER write implementation code"

@tester create all tests from issue #$ISSUE_NUMBER:
- Read test specifications from issue
- Create unit tests in tests/unit/
- Create integration tests in tests/integration/
- Create E2E tests in tests/e2e/
- Run tests to confirm they FAIL
- Commit: "test: add failing tests for $FEATURE_NAME (TDD red)"

# 6.2: Verification Gate
if ! pytest tests/ | grep -q "FAILED"; then
    echo "ERROR: Tests must fail before implementation!"
    exit 1
fi

# 6.3: Parallel Implementation
parallel -j 3 << 'IMPLEMENTATION'
@backend-coder implement API to make backend tests pass
@frontend-coder implement UI to make E2E tests pass  
@integration-coder connect frontend to backend
IMPLEMENTATION

# 6.4: Continuous Testing
while true; do
    TEST_RESULTS=$(pytest tests/ --tb=short)
    if echo "$TEST_RESULTS" | grep -q "failed=0"; then
        echo "All tests passing!"
        break
    fi
    sleep 30
done

# 6.5: Quality Gates
pytest tests/ --cov --cov-report=term
COVERAGE=$(coverage report | grep TOTAL | awk '{print $4}' | sed 's/%//')
if [[ $COVERAGE -lt 95 ]]; then
    @tester add tests to increase coverage above 95%
fi
```

### Step 7: Review and Optimization

```bash
# Parallel review by specialists
parallel -j 4 << 'REVIEW'
@code-reviewer check code quality, patterns, maintainability
@security-reviewer scan for vulnerabilities using OWASP checklist
@performance-reviewer profile and identify bottlenecks
@accessibility-reviewer ensure WCAG 2.1 AA compliance
REVIEW

# Apply feedback iteratively
for feedback in /tmp/swarm/reviews/*.md; do
    @backend-coder apply feedback from $feedback keeping tests green
    @frontend-coder apply feedback from $feedback keeping tests green
    pytest tests/ || exit 1  # Ensure tests still pass
done
```

### Step 8: Final Validation

```bash
# Automated quality checks
run_final_validation() {
    local CHECKS_PASSED=0
    local TOTAL_CHECKS=10
    
    # 1. All tests passing
    pytest tests/ && ((CHECKS_PASSED++))
    
    # 2. Coverage > 95%
    [[ $(coverage report | grep TOTAL | awk '{print $4}' | sed 's/%//') -gt 95 ]] && ((CHECKS_PASSED++))
    
    # 3. No security vulnerabilities  
    semgrep --config=auto . | grep -q "0 findings" && ((CHECKS_PASSED++))
    
    # 4. Performance benchmarks met
    [[ $(measure_api_response_time) -lt 100 ]] && ((CHECKS_PASSED++))
    
    # 5. Linting passes
    pylint src/ --score=yes | grep -q "10.00/10" && ((CHECKS_PASSED++))
    
    # 6. Type checking passes
    mypy src/ | grep -q "Success" && ((CHECKS_PASSED++))
    
    # 7. Documentation complete
    [[ -f README.md && -f API.md ]] && ((CHECKS_PASSED++))
    
    # 8. GitHub issue updated
    gh issue comment $ISSUE_NUMBER --body "Implementation complete" && ((CHECKS_PASSED++))
    
    # 9. Cost within budget
    [[ $(claude-flow report cost --issue $ISSUE_NUMBER) < 10.00 ]] && ((CHECKS_PASSED++))
    
    # 10. All commits have tests
    git log --oneline | grep -E "(test:|fix:|feat:)" | wc -l && ((CHECKS_PASSED++))
    
    echo "Validation: $CHECKS_PASSED/$TOTAL_CHECKS passed"
    [[ $CHECKS_PASSED -eq $TOTAL_CHECKS ]]
}

run_final_validation || @reviewer fix remaining validation issues
```

## 📊 Optimal Configuration Reference

### Swarm Sizes by Feature Complexity

| Complexity | Research | Planning | Testing | Coding | Review | Total | Max Parallel |
|------------|----------|----------|---------|--------|--------|-------|--------------|
| Small | 1 | 4 | 2 | 2 | 1 | 10 | 6 |
| Medium | 1 | 6 | 3 | 4 | 2 | 16 | 8 |
| Large | 2 | 6 | 4 | 6 | 3 | 21 | 10 |
| Epic | 2 | 8 | 6 | 10 | 4 | 30 | 12 |

### Token Budget Allocation

```yaml
token_budgets:
  by_phase:
    research: 15%     # Deep investigation
    planning: 20%     # Multiple personas
    testing: 20%      # Comprehensive tests
    coding: 35%       # Implementation
    review: 10%       # Quality checks
  
  by_model:
    complex_tasks: "gpt-4o"        # $2.50/1M tokens
    simple_tasks: "gpt-4o-mini"    # $0.15/1M tokens
    
  limits:
    per_feature: 1_000_000        # ~$10 budget
    per_epic: 5_000_000           # ~$50 budget
    warning_threshold: 80%
    halt_threshold: 95%
```

### Parallel Execution Strategy

```python
PARALLEL_STRATEGY = {
    "research": {
        "parallel": True,
        "max_concurrent": 5,
        "tasks": ["best_practices", "apis", "security", "performance", "existing_code"]
    },
    "planning": {
        "parallel": True, 
        "max_concurrent": 6,
        "tasks": ["product", "project", "technical", "tests", "frontend", "security"]
    },
    "testing": {
        "parallel": False,  # Must complete before coding
        "tasks": ["unit", "integration", "e2e"]
    },
    "coding": {
        "parallel": True,
        "max_concurrent": 4,
        "tasks": ["backend", "frontend", "integration", "infrastructure"]
    },
    "review": {
        "parallel": True,
        "max_concurrent": 4,
        "tasks": ["code", "security", "performance", "accessibility"]
    }
}
```

## 🎯 Success Metrics

Track these metrics for every feature:

```python
SUCCESS_METRICS = {
    "quality": {
        "test_coverage": ">= 95%",
        "security_scan": "0 critical/high vulnerabilities",
        "code_quality": "pylint >= 9.0",
        "performance": "p95 < 100ms"
    },
    "efficiency": {
        "time_to_complete": "< estimated * 1.2",
        "token_usage": "< budget * 0.9",
        "cost": "< $10 per feature",
        "rework_rate": "< 10%"
    },
    "process": {
        "tdd_adherence": "100% (tests first)",
        "review_coverage": "100% of code",
        "documentation": "100% of public APIs",
        "issue_completeness": ">= 90% detail score"
    }
}
```

## 🚨 Common Pitfalls to Avoid

1. **Skipping Research**: Always research first, even for "simple" features
2. **Vague Issues**: Include actual code, not placeholders
3. **Skipping Tests**: TDD means tests FIRST, always
4. **Serial Execution**: Use parallel execution wherever possible
5. **Ignoring Budgets**: Monitor token usage continuously
6. **Poor Coordination**: Use explicit guards between phases
7. **Missing Personas**: All 6 personas provide unique value

## 📋 Final Checklist

Before starting ANY feature:
- [ ] `/docs` directory exists with phase structure
- [ ] All agent definition files created in `.claude/agents/`
- [ ] GitHub CLI authenticated
- [ ] Claude Flow Alpha installed
- [ ] Issue templates configured
- [ ] Token budget approved
- [ ] Research phase completed
- [ ] Multi-persona planning done
- [ ] Comprehensive issue created
- [ ] TDD workflow ready

## 🎖️ The Golden Rules

1. **Research First**: 30-60 minutes of research saves days of rework
2. **Plan Completely**: 6 personas = comprehensive coverage
3. **Test First**: Red → Green → Refactor (always!)
4. **Code in Parallel**: Backend + Frontend simultaneously
5. **Review Everything**: Security + Performance + Quality
6. **Measure Success**: Track metrics, learn, improve

---

**This is your complete guide. Follow it precisely for optimal results. The key is comprehensive planning with actual code in issues, followed by disciplined TDD execution.**