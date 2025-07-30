# Module: {{MODULE_NAME}}

## Purpose
{{MODULE_PURPOSE}} - A concise 1-2 sentence description for AI agents to quickly understand this module's role.

## API
```{{LANGUAGE}}
// Core interface - AI agents can use these methods
{{API_INTERFACE}}
```

## Quick Usage
```{{LANGUAGE}}
// Minimal example for AI to understand usage
{{USAGE_EXAMPLE}}
```

## Module Structure
```
{{MODULE_NAME}}/
├── api/          # Public interfaces
├── core/         # Business logic
├── tests/        # Test suite
└── README.md     # This file
```

## Dependencies
- **{{DEP1}}**: {{WHY_NEEDED}}
- **{{DEP2}}**: {{WHY_NEEDED}}

## Constraints
- {{CONSTRAINT1}}
- {{CONSTRAINT2}}
- {{CONSTRAINT3}}

## For AI Code Writers
- **Entry Point**: `{{ENTRY_POINT}}`
- **Test Command**: `{{TEST_COMMAND}}`
- **Build Command**: `{{BUILD_COMMAND}}`
- **Key Files**: {{KEY_FILES}}

## MCP Interface
{{#IF_MCP}}
```json
{
  "name": "{{MODULE_NAME}}-mcp",
  "methods": ["{{METHOD1}}", "{{METHOD2}}", "{{METHOD3}}"],
  "schema": "./mcp/schema.json"
}
```

To use as MCP:
```bash
npx @mcp/cli connect {{MODULE_NAME}}-mcp
```
{{/IF_MCP}}

## Module Contract
```{{LANGUAGE}}
{{MODULE_CONTRACT}}
```

---
*This README is optimized for AI consumption. Keep updates concise.*