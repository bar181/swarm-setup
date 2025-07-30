# MODULAR_DESIGN.md - Modular Architecture for SWARM Development

## 🎯 Purpose

This guide defines modular design principles for SWARM-based development, ensuring clean component boundaries, independent deployability, and efficient parallel execution by custom agents.

## 🏗️ Core Modular Principles

### 1. Vertical Slice Architecture
Each feature is a complete, independently deployable unit:
- Frontend components
- Backend services  
- Database changes
- Test suites
- Documentation

### 2. Component Boundaries
Clear separation between modules:
- **Domain-Driven Design**: Each module owns its domain
- **Single Responsibility**: One module, one purpose
- **Loose Coupling**: Minimal dependencies between modules
- **High Cohesion**: Related functionality stays together

### 3. Agent-Based Development
Each module is developed by specialized agents:
- **Research Phase**: Domain investigation per module
- **Planning Phase**: Module-specific 6-persona design
- **Implementation**: Parallel development of modules
- **Integration**: Contract-based communication

## 📁 Modular Project Structure

```
project/
├── modules/                        # Feature modules
│   ├── authentication/            # Complete auth module
│   │   ├── frontend/             # React components
│   │   │   ├── components/       # UI components
│   │   │   ├── hooks/           # Custom hooks
│   │   │   └── services/        # API clients
│   │   ├── backend/             # FastAPI service
│   │   │   ├── api/            # Endpoints
│   │   │   ├── models/         # Pydantic models
│   │   │   ├── services/       # Business logic
│   │   │   └── repositories/   # Data access
│   │   ├── database/           # Module-specific schema
│   │   │   ├── migrations/     # Alembic migrations
│   │   │   └── schemas/        # SQLAlchemy models
│   │   ├── tests/              # Complete test suite
│   │   │   ├── unit/          # Unit tests
│   │   │   ├── integration/   # API tests
│   │   │   └── e2e/          # Playwright tests
│   │   └── docs/              # Module documentation
│   │       ├── API.md         # API specification
│   │       └── README.md      # Module overview
│   │
│   ├── user-management/        # Another complete module
│   ├── payment-processing/     # Another complete module
│   └── analytics-dashboard/    # Another complete module
│
├── shared/                     # Shared utilities (minimal)
│   ├── components/            # Common UI components
│   ├── utils/                 # Shared utilities
│   └── types/                 # Shared TypeScript types
│
└── infrastructure/            # Cross-cutting concerns
    ├── database/             # Database configuration
    ├── monitoring/           # Observability setup
    └── deployment/           # Deployment configs
```

## 🔧 Module Development Patterns

### 1. Module Interface Contract
Each module exposes a clear API contract:

```typescript
// modules/authentication/contracts/auth.contract.ts
export interface AuthenticationModule {
  // Public API
  authenticate(credentials: Credentials): Promise<AuthToken>;
  validateToken(token: string): Promise<User>;
  refreshToken(refreshToken: string): Promise<AuthToken>;
  
  // Events emitted
  events: {
    userLoggedIn: Event<User>;
    userLoggedOut: Event<User>;
    tokenRefreshed: Event<AuthToken>;
  };
}
```

```python
# modules/authentication/contracts/auth_contract.py
from abc import ABC, abstractmethod

class AuthenticationContract(ABC):
    """Public interface for authentication module"""
    
    @abstractmethod
    async def authenticate(self, credentials: dict) -> dict:
        """Authenticate user and return token"""
        pass
    
    @abstractmethod
    async def validate_token(self, token: str) -> dict:
        """Validate token and return user"""
        pass
```

### 2. Module Independence
Each module is self-contained:

```yaml
# modules/authentication/module.yaml
name: authentication
version: 1.0.0
dependencies:
  external:
    - fastapi: ^0.104.0
    - pydantic: ^2.0
    - supabase: ^2.0
  internal: []  # No dependencies on other modules
api:
  endpoints:
    - POST /auth/login
    - POST /auth/logout
    - POST /auth/refresh
    - GET /auth/me
database:
  tables:
    - users
    - sessions
    - refresh_tokens
```

### 3. Inter-Module Communication
Modules communicate through well-defined interfaces:

```python
# modules/user-management/services/user_service.py
from modules.authentication.contracts import AuthenticationContract

class UserService:
    def __init__(self, auth: AuthenticationContract):
        self.auth = auth  # Dependency injection
    
    async def get_current_user(self, token: str):
        # Use auth module through contract
        user = await self.auth.validate_token(token)
        return await self.get_user_profile(user.id)
```

## 🎨 Modular Design Patterns

### 1. Repository Pattern
Isolate data access within modules:

```python
# modules/authentication/repositories/user_repository.py
class UserRepository:
    def __init__(self, db: Database):
        self.db = db
    
    async def create_user(self, user_data: dict) -> User:
        # Module owns its data access
        return await self.db.users.create(user_data)
    
    async def find_by_email(self, email: str) -> Optional[User]:
        return await self.db.users.find_one({"email": email})
```

### 2. Service Layer Pattern
Business logic encapsulated in services:

```typescript
// modules/payment-processing/services/payment.service.ts
export class PaymentService {
  constructor(
    private readonly repository: PaymentRepository,
    private readonly gateway: PaymentGateway
  ) {}
  
  async processPayment(order: Order): Promise<Payment> {
    // Module-specific business logic
    const payment = await this.gateway.charge(order.amount);
    return await this.repository.save(payment);
  }
}
```

### 3. Event-Driven Communication
Loose coupling through events:

```python
# modules/analytics-dashboard/listeners/order_listener.py
from infrastructure.events import EventBus

class OrderAnalyticsListener:
    def __init__(self, event_bus: EventBus):
        event_bus.subscribe("order.created", self.handle_order_created)
    
    async def handle_order_created(self, event: OrderCreatedEvent):
        # Update analytics without tight coupling
        await self.update_revenue_metrics(event.order)
```

## 🚀 SWARM Agent Assignments

### Module Development Workflow

```bash
# 1. Research Phase (Per Module)
@researcher investigate authentication best practices:
- OAuth 2.0 / JWT patterns
- Security vulnerabilities
- Performance benchmarks
- Save to /docs/modules/authentication/research/

# 2. Planning Phase (Per Module)  
@planner coordinate 6 personas for authentication module:
- Define module boundaries
- Design API contracts
- Plan database schema
- Create test specifications

# 3. Parallel Module Development
parallel -j 3 << 'MODULES'
@module-team develop authentication module
@module-team develop user-management module  
@module-team develop payment-processing module
MODULES

# 4. Integration Testing
@integration-tester verify module contracts and communication
```

### Module Team Composition
Each module team consists of:
- 1 module-architect (designs contracts)
- 1 backend-coder (implements API)
- 1 frontend-coder (implements UI)
- 1 tester (writes all tests)
- 1 reviewer (ensures quality)

## 📊 Module Quality Metrics

### Independence Metrics
- **Coupling Score**: < 0.3 (low coupling)
- **Cohesion Score**: > 0.8 (high cohesion)
- **Dependency Count**: < 3 internal dependencies

### Completeness Metrics
- **API Coverage**: 100% endpoints documented
- **Test Coverage**: > 95% per module
- **Documentation**: README, API docs, examples

### Performance Metrics
- **Module Boot Time**: < 2 seconds
- **API Response Time**: < 100ms p95
- **Memory Footprint**: < 100MB per module

## 🔄 Module Lifecycle

### 1. Module Creation
```bash
# Use module generator
@module-creator generate payment-processing:
- Scaffold directory structure
- Create contract interfaces
- Setup test framework
- Initialize documentation
```

### 2. Module Evolution
```yaml
# Version management
authentication@1.0.0 → authentication@1.1.0
Changes:
  - Added: Social login support
  - Changed: Token expiry configurable
  - Deprecated: Legacy session API
  - Fixed: Token refresh race condition
```

### 3. Module Deprecation
```python
# Graceful deprecation
@deprecated("2.0.0", "Use authentication-v2 module")
class LegacyAuthModule:
    """Maintains backward compatibility"""
    pass
```

## 🎯 Best Practices

### 1. Module Design
- **Start with contracts**: Define interfaces first
- **Minimize shared code**: Prefer duplication over coupling
- **Own your data**: Each module manages its schema
- **Test in isolation**: Modules should run standalone

### 2. Module Communication  
- **Use async patterns**: Event-driven architecture
- **Version your APIs**: Support multiple versions
- **Handle failures**: Circuit breakers, retries
- **Monitor boundaries**: Track inter-module calls

### 3. Module Deployment
- **Independent deployment**: Deploy modules separately
- **Feature flags**: Control module activation
- **Backward compatibility**: Support rolling updates
- **Health checks**: Per-module monitoring

## 📋 Module Checklist

Before considering a module complete:

- [ ] **Contract defined**: Clear API specification
- [ ] **Tests comprehensive**: Unit, integration, E2E
- [ ] **Documentation complete**: README, API docs
- [ ] **Performance verified**: Meets SLA requirements
- [ ] **Security reviewed**: No vulnerabilities
- [ ] **Monitoring enabled**: Metrics and logging
- [ ] **Deployment automated**: CI/CD configured
- [ ] **Integration tested**: Works with other modules

## 🔗 Integration with SWARM Workflow

1. **Epic Planning**: Each module can be an epic feature
2. **Vertical Slices**: Modules are complete slices
3. **Parallel Execution**: Modules developed concurrently
4. **TDD Approach**: Tests drive module design
5. **Memory Persistence**: Module decisions stored in SQLite

## 🚨 Anti-Patterns to Avoid

### ❌ The "God Module"
One module that does everything - violates single responsibility

### ❌ The "Chatty Modules"  
Excessive inter-module communication - indicates poor boundaries

### ❌ The "Shared Database"
Modules sharing tables - creates tight coupling

### ❌ The "Circular Dependencies"
Module A depends on B, B depends on A - impossible to test

---

**Remember**: Good modular design enables parallel development, independent deployment, and maintainable systems. Each module should be a mini-application that could theoretically run as its own service.