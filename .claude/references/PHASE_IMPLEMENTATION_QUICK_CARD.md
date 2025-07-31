# Phase Implementation Quick Reference Card

## 🚀 One-Command Execution

```bash
claude "Implement the complete feature from /docs/phases/[PHASE]/[PLAN].md 
using our SWARM methodology. Create epic, all issues, and implement 
issue #1 with full TDD, real data validation, and Supabase integration."
```

## 📋 Pre-Flight Checklist

Phase plan must include:
- [ ] Feature requirements & acceptance criteria
- [ ] Data models/schemas
- [ ] API endpoints or UI components
- [ ] Performance requirements
- [ ] Security considerations
- [ ] Integration points

## 🤖 Agent Roster

### Research Phase (Parallel)
- `@api_researcher` - Latest docs, pricing, breaking changes
- `@pattern_researcher` - 2025 best practices, frameworks
- `@mcp_researcher` - MCP tools, Supabase capabilities

### Planning Phase (6 Personas)
- `@product_owner` - User stories, BDD scenarios
- `@project_manager` - Timeline, dependencies
- `@senior_developer` - Architecture, API specs
- `@test_writer` - Test strategy, coverage
- `@frontend_expert` - UI/UX, components
- `@security_expert` - Threat model, auth

### Implementation Phase (Parallel TDD)
- `@unit_tester` - 70% coverage, real data
- `@integration_tester` - 20% coverage, Supabase MCP
- `@e2e_tester` - 10% coverage, Playwright
- `@backend_coder` - API, models, validators
- `@frontend_coder` - Components, hooks, stores
- `@db_specialist` - Schema, indexes, RLS

## 🛠️ Key Commands

### GitHub CLI
```bash
gh issue create --title "Epic: [FEATURE]" --body "[CONTENT]" --label epic
gh pr create --title "feat: [FEATURE]" --body "[SUMMARY]"
gh pr merge --auto --squash
```

### Supabase MCP
```javascript
mcp__supabase__create_table({ name, columns })
mcp__supabase__create_rls_policy({ table, policy })
mcp__supabase__query({ query, params })
mcp__supabase__subscribe({ table, event })
```

### Parallel Execution
```bash
parallel -j 6 ::: \
  "gh issue create --title 'Backend: API'" \
  "gh issue create --title 'Frontend: UI'" \
  "gh issue create --title 'Database: Schema'"
```

## 🔄 Workflow Steps

1. **Validate** → Phase plan completeness
2. **Research** → APIs, patterns, MCP tools (2-3h)
3. **Plan** → Epic + issues with 6 personas (1-2h)
4. **Test** → Write failing tests first
5. **Code** → Parallel implementation
6. **Verify** → Real data, performance, security
7. **PR** → Create and auto-merge

## ⚡ Hooks Active

- **Pre-edit**: Validation check
- **Post-test**: Coverage >95%
- **Pre-commit**: Lint & format

## 🚨 Human Touch Points

1. **Start**: Provide phase plan link
2. **If needed**: Clarify missing info
3. **End**: Approve PR for production

## 📊 Success Metrics

- Autonomous: 85% completion
- Coverage: >95% with real data
- Performance: Meets all requirements
- Speed: 2.5x faster than sequential
- Quality: Zero critical bugs

## 💡 Pro Tips

- Research saves 10x implementation time
- Use `parallel -j` for everything
- Real data from minute one
- TDD is non-negotiable
- Let agents work simultaneously

---

**Emergency**: If blocked, check:
1. Phase plan completeness
2. MCP tools availability
3. Token budget status
4. Human escalation triggers