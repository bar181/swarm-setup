# Modular Design Example

## Scenario: LLM Provider Module

Imagine a project with multiple LLM integrations:

```
agents/
└── llm_providers/
    ├── openai/
    │   ├── client.ts
    │   ├── types.ts
    │   └── config.ts
    ├── anthropic/
    │   ├── client.ts
    │   ├── types.ts
    │   └── config.ts
    ├── google/
    │   ├── client.ts
    │   ├── types.ts
    │   └── config.ts
    ├── cohere/
    │   ├── client.ts
    │   ├── types.ts
    │   └── config.ts
    └── base_provider.ts
```

## Modular Designer Analysis

The `@modular-designer` agent would:

### 1. Detect MCP Opportunity
- 4 similar implementations ✓
- Shared interface (base_provider.ts) ✓
- Similar structure across providers ✓
- **MCP Score: 3/3** → Strong candidate!

### 2. Generate Module README
```markdown
# Module: LLM Providers

## Purpose
Unified interface for multiple LLM providers (OpenAI, Anthropic, Google, Cohere) with consistent API and automatic failover.

## API
```typescript
interface LLMProvider {
  complete(prompt: string, options?: CompletionOptions): Promise<Response>;
  stream(prompt: string, options?: StreamOptions): AsyncIterator<Token>;
  embed(text: string): Promise<number[]>;
}
```

## Quick Usage
```typescript
import { getLLMProvider } from './llm_providers';

const provider = getLLMProvider('openai');
const response = await provider.complete('Hello, world!');
```

## For AI Code Writers
- **Entry Point**: `./index.ts`
- **Test Command**: `npm test -- llm_providers`
- **Add Provider**: Copy existing provider folder, implement base interface
```

### 3. Create MCP Configuration
```json
{
  "name": "llm-providers-mcp",
  "version": "1.0.0",
  "description": "MCP server for LLM provider integrations",
  "server": {
    "command": ["node", "./mcp/server.js"]
  },
  "methods": [
    "listProviders",
    "complete",
    "stream",
    "embed",
    "switchProvider"
  ],
  "schema": "./mcp/schema.json"
}
```

### 4. Generate MCP Server
```typescript
// llm_providers/mcp/server.ts
import { MCPServer } from '@mcp/framework';
import * as providers from '../index';

const server = new MCPServer({
  name: 'llm-providers-mcp',
  version: '1.0.0',
  
  handlers: {
    listProviders: async () => Object.keys(providers),
    
    complete: async ({ provider, prompt, options }) => {
      const llm = providers[provider];
      return await llm.complete(prompt, options);
    },
    
    stream: async function* ({ provider, prompt, options }) {
      const llm = providers[provider];
      yield* llm.stream(prompt, options);
    }
  }
});

export default server;
```

## Benefits

1. **For Developers**: Clear module boundaries, easy to add new providers
2. **For AI Agents**: Can use any LLM provider through consistent MCP interface
3. **For Testing**: Each provider tested independently, shared test suite
4. **For Deployment**: Can deploy as microservice or embedded module

## Command to Run

```bash
# Analyze your project
@modular-designer analyze ./my-project

# Or use the detection script
./.claude/scripts/detect-mcp-candidates.sh
```

This demonstrates how the modular designer identifies opportunities to improve code organization and create reusable MCP servers.