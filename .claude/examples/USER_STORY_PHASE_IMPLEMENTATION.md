# User Story: Implementing a Chatbot Backend from Phase Plan

## 📖 Scenario Overview

A developer wants to implement a chatbot backend system based on a detailed phase plan. The system needs to:
- Connect to Supabase for data persistence
- Use agents to configure LLM prompts dynamically
- Make LLM API calls through specialized agents
- Store conversation history and results in Supabase
- Return formatted responses to the frontend

## 🎯 The Complete User Journey

### Step 1: Initial User Prompt

```markdown
I need to implement the chatbot backend from the phase plan at /docs/phases/phase-3-chatbot/implementation-plan.md

The plan includes:
- FastAPI backend with WebSocket support
- Supabase integration for conversation persistence
- Dynamic prompt configuration using prompt-builder agent
- LLM calls using llm-caller agent with fallback strategies
- Real-time response streaming
- Conversation history with vector embeddings

Please create GitHub issues following our SWARM methodology, then we'll implement them one by one.
```

### Step 2: Claude's Research & Planning Response

```bash
Think ultrahard about implementing the chatbot backend system. I'll follow our SWARM methodology to create comprehensive GitHub issues.

First, let me analyze the phase plan and spawn a research swarm:

@researcher investigate in parallel:
- Latest FastAPI WebSocket patterns 2025
- Supabase real-time subscriptions and RLS policies
- OpenAI streaming API with gpt-4o ($2.50/1M tokens)
- Vector embedding best practices for conversation search
- Agent-based prompt engineering patterns

Save findings to /docs/phases/phase-3-chatbot/research/

Then spawn epic planning team:
@epic-planner break this into manageable features:
1. Core WebSocket infrastructure
2. Supabase integration layer
3. Agent system for prompts
4. LLM service with fallbacks
5. Conversation persistence
6. Vector search capability

@planner coordinate 6 personas for each feature to create detailed issues
```

### Step 3: Epic Creation Output

```yaml
# GitHub Epic: Chatbot Backend System

## Overview
Implement a production-ready chatbot backend with agent-based prompt management and Supabase persistence.

## Features Breakdown

### Feature 1: WebSocket Infrastructure (2 days)
- FastAPI WebSocket endpoint with auth
- Connection pooling and heartbeat
- Graceful disconnection handling
- Rate limiting per user
- Swarm size: 5 agents

### Feature 2: Supabase Integration (1 day)
- Database schema with RLS
- Real-time subscriptions
- Connection pooling
- Error recovery
- Swarm size: 4 agents

### Feature 3: Agent System (3 days)
- Prompt builder agent
- LLM caller agent
- Response formatter agent
- Error handler agent
- Swarm size: 6 agents

### Feature 4: Conversation Management (2 days)
- History persistence
- Vector embeddings
- Search functionality
- Export capabilities
- Swarm size: 5 agents

## Resource Allocation
- Total estimated time: 8 days
- Token budget: 2.5M tokens
- Parallel work streams: Features 1&2, then 3&4
```

### Step 4: Creating Detailed GitHub Issues

```markdown
# Issue #147: Implement WebSocket Infrastructure

## 📋 Description
Create the core WebSocket infrastructure for real-time chat communication with proper auth and error handling.

## 🎯 Acceptance Criteria
- [ ] WebSocket endpoint at `/ws/chat/{conversation_id}`
- [ ] JWT authentication before connection
- [ ] Automatic reconnection with exponential backoff
- [ ] Message queuing during disconnections
- [ ] Prometheus metrics for monitoring

## 💻 Implementation Details

### WebSocket Manager
```python
# src/services/websocket_manager.py
from fastapi import WebSocket, WebSocketDisconnect
from typing import Dict, Set
import asyncio
import json

class ConnectionManager:
    def __init__(self):
        self.active_connections: Dict[str, WebSocket] = {}
        self.message_queues: Dict[str, asyncio.Queue] = {}
        self.heartbeat_interval = 30
        
    async def connect(self, websocket: WebSocket, user_id: str, conversation_id: str):
        await websocket.accept()
        connection_key = f"{user_id}:{conversation_id}"
        self.active_connections[connection_key] = websocket
        self.message_queues[connection_key] = asyncio.Queue()
        
        # Start heartbeat task
        asyncio.create_task(self._heartbeat(connection_key))
        
    async def disconnect(self, user_id: str, conversation_id: str):
        connection_key = f"{user_id}:{conversation_id}"
        if connection_key in self.active_connections:
            del self.active_connections[connection_key]
            # Save queued messages to Redis
            await self._persist_queue(connection_key)
```

### FastAPI Endpoint
```python
# src/api/v1/websocket.py
from fastapi import APIRouter, WebSocket, Depends, Query
from src.auth import verify_jwt_token
from src.services.websocket_manager import ConnectionManager

router = APIRouter()
manager = ConnectionManager()

@router.websocket("/ws/chat/{conversation_id}")
async def websocket_endpoint(
    websocket: WebSocket,
    conversation_id: str,
    token: str = Query(...),
):
    # Verify JWT token
    try:
        user = await verify_jwt_token(token)
    except InvalidTokenError:
        await websocket.close(code=4001, reason="Invalid authentication")
        return
        
    try:
        await manager.connect(websocket, user.id, conversation_id)
        
        while True:
            # Receive message
            data = await websocket.receive_text()
            message = json.loads(data)
            
            # Process through agent system
            response = await process_message(message, user.id, conversation_id)
            
            # Send response
            await websocket.send_json(response)
            
    except WebSocketDisconnect:
        await manager.disconnect(user.id, conversation_id)
```

## 🧪 Test Implementation
```python
# tests/test_websocket.py
import pytest
from httpx_ws import aconnect_ws
from src.tests.factories import UserFactory

@pytest.mark.asyncio
async def test_websocket_authentication():
    """Test that WebSocket requires valid JWT"""
    async with aconnect_ws(
        "ws://localhost:8000/ws/chat/123",
        params={"token": "invalid"}
    ) as ws:
        assert ws.close_code == 4001

@pytest.mark.asyncio  
async def test_websocket_message_flow():
    """Test complete message flow"""
    user = await UserFactory.create()
    token = generate_jwt(user)
    
    async with aconnect_ws(
        f"ws://localhost:8000/ws/chat/123",
        params={"token": token}
    ) as ws:
        # Send message
        await ws.send_json({
            "type": "message",
            "content": "Hello, chatbot!"
        })
        
        # Receive response
        response = await ws.receive_json()
        assert response["type"] == "response"
        assert response["conversation_id"] == "123"
        assert "content" in response

@pytest.mark.asyncio
async def test_websocket_reconnection():
    """Test reconnection preserves message queue"""
    # Implementation here...
```

## 🔧 Configuration
```yaml
# config/websocket.yaml
websocket:
  heartbeat_interval: 30
  max_connections_per_user: 5
  message_queue_size: 100
  reconnection_timeout: 300
  rate_limit:
    messages_per_minute: 60
    tokens_per_minute: 10000
```

## 📊 Monitoring
- Add Prometheus metrics:
  - `websocket_active_connections`
  - `websocket_messages_received_total`
  - `websocket_errors_total`
  - `websocket_reconnections_total`

## 🎯 Definition of Done
- [ ] All tests passing (100% coverage)
- [ ] WebSocket handles 1000 concurrent connections
- [ ] Graceful shutdown implemented
- [ ] Monitoring dashboard created
- [ ] Documentation updated

## 👥 Assigned Team
- @backend-coder: Core implementation
- @tester: Test suite
- @devops: Deployment config
- @reviewer: Code review

---
Token Budget: 150k
```

### Step 5: User Requests Implementation

```markdown
Great! I see issue #147 for WebSocket infrastructure. Let's implement this using TDD approach with our SWARM agents.
```

### Step 6: Claude's Implementation Response

```bash
Think harder about implementing issue #147 using TDD approach.

@tester create comprehensive failing test suite for WebSocket infrastructure:
- Authentication tests (valid/invalid JWT)
- Connection lifecycle tests
- Message flow tests  
- Reconnection with queue preservation
- Rate limiting tests
- Concurrent connection tests
- Error handling scenarios

Ensure all tests FAIL initially (red phase).

Then parallel implementation:
@backend-coder implement WebSocket manager and endpoint to pass tests
@devops create Kubernetes deployment configs and monitoring

Finally:
@reviewer verify code quality, security, and performance
@performance-optimizer ensure <50ms message latency

Swarm execution: parallel_tdd with test_first guard
```

### Step 7: Test Creation Output

```python
# tests/test_websocket_infrastructure.py
"""
Comprehensive test suite for WebSocket infrastructure
All tests should FAIL initially until implementation
"""

import pytest
import asyncio
import json
from httpx_ws import aconnect_ws
from datetime import datetime, timedelta
from unittest.mock import AsyncMock, patch

from src.tests.factories import UserFactory, ConversationFactory
from src.auth import generate_jwt, InvalidTokenError
from src.services.websocket_manager import ConnectionManager

class TestWebSocketAuthentication:
    """Test WebSocket authentication requirements"""
    
    @pytest.mark.asyncio
    async def test_websocket_requires_token(self, test_client):
        """WebSocket should reject connections without token"""
        with pytest.raises(Exception) as exc:
            async with aconnect_ws(
                f"{test_client}/ws/chat/conv123"
            ) as ws:
                pass
        assert "Missing token parameter" in str(exc.value)
    
    @pytest.mark.asyncio
    async def test_websocket_validates_jwt(self, test_client):
        """WebSocket should validate JWT tokens"""
        async with aconnect_ws(
            f"{test_client}/ws/chat/conv123",
            params={"token": "invalid.jwt.token"}
        ) as ws:
            assert ws.close_code == 4001
            assert ws.close_reason == "Invalid authentication"
    
    @pytest.mark.asyncio
    async def test_websocket_accepts_valid_token(self, test_client):
        """WebSocket should accept valid JWT tokens"""
        user = await UserFactory.create()
        token = generate_jwt(user.id, expires_in=3600)
        
        async with aconnect_ws(
            f"{test_client}/ws/chat/conv123",
            params={"token": token}
        ) as ws:
            # Should connect successfully
            assert ws.state.name == "CONNECTED"
            
            # Should receive welcome message
            welcome = await ws.receive_json()
            assert welcome["type"] == "connection"
            assert welcome["status"] == "connected"
            assert welcome["user_id"] == user.id

class TestWebSocketMessageFlow:
    """Test message sending and receiving"""
    
    @pytest.mark.asyncio
    async def test_send_receive_message(self, test_client, authenticated_user):
        """Test basic message flow"""
        token = generate_jwt(authenticated_user.id)
        
        async with aconnect_ws(
            f"{test_client}/ws/chat/conv123", 
            params={"token": token}
        ) as ws:
            # Skip welcome message
            await ws.receive_json()
            
            # Send chat message
            await ws.send_json({
                "type": "message",
                "content": "Hello chatbot",
                "timestamp": datetime.utcnow().isoformat()
            })
            
            # Should receive acknowledgment
            ack = await ws.receive_json()
            assert ack["type"] == "acknowledgment"
            assert ack["status"] == "received"
            
            # Should receive AI response
            response = await ws.receive_json()
            assert response["type"] == "response"
            assert response["conversation_id"] == "conv123"
            assert "content" in response
            assert response["user_id"] == authenticated_user.id
    
    @pytest.mark.asyncio
    async def test_message_validation(self, test_client, authenticated_ws):
        """Test message format validation"""
        # Missing required fields
        await authenticated_ws.send_json({"type": "message"})
        
        error = await authenticated_ws.receive_json()
        assert error["type"] == "error"
        assert error["code"] == "INVALID_MESSAGE"
        assert "content is required" in error["message"]
    
    @pytest.mark.asyncio
    async def test_rate_limiting(self, test_client, authenticated_user):
        """Test rate limiting per user"""
        token = generate_jwt(authenticated_user.id)
        
        async with aconnect_ws(
            f"{test_client}/ws/chat/conv123",
            params={"token": token}
        ) as ws:
            await ws.receive_json()  # Skip welcome
            
            # Send 61 messages (limit is 60/min)
            for i in range(61):
                await ws.send_json({
                    "type": "message",
                    "content": f"Message {i}"
                })
            
            # 61st message should be rate limited
            error = await ws.receive_json()
            assert error["type"] == "error"
            assert error["code"] == "RATE_LIMITED"
            assert "60 messages per minute" in error["message"]

class TestWebSocketReconnection:
    """Test reconnection and message queue preservation"""
    
    @pytest.mark.asyncio
    async def test_reconnection_preserves_queue(self, test_client, authenticated_user):
        """Test that queued messages survive reconnection"""
        token = generate_jwt(authenticated_user.id)
        conversation_id = "conv123"
        
        # First connection
        async with aconnect_ws(
            f"{test_client}/ws/chat/{conversation_id}",
            params={"token": token}
        ) as ws:
            await ws.receive_json()  # Welcome
            
            # Send message
            await ws.send_json({
                "type": "message",
                "content": "Message before disconnect"
            })
            
            # Simulate processing delay
            await asyncio.sleep(0.1)
        
        # Reconnect
        async with aconnect_ws(
            f"{test_client}/ws/chat/{conversation_id}",
            params={"token": token}
        ) as ws:
            # Should receive queued messages
            welcome = await ws.receive_json()
            assert welcome["type"] == "connection"
            
            # Should receive pending response
            queued = await ws.receive_json()
            assert queued["type"] == "response"
            assert "Message before disconnect" in queued["original_message"]
    
    @pytest.mark.asyncio
    async def test_heartbeat_keeps_alive(self, test_client, authenticated_ws):
        """Test heartbeat prevents timeout"""
        # Wait for heartbeat
        await asyncio.sleep(31)  # Heartbeat interval + 1
        
        # Connection should still be active
        await authenticated_ws.send_json({
            "type": "ping"
        })
        
        pong = await authenticated_ws.receive_json()
        assert pong["type"] == "pong"
        assert authenticated_ws.state.name == "CONNECTED"

class TestConcurrentConnections:
    """Test concurrent connection handling"""
    
    @pytest.mark.asyncio
    async def test_multiple_users_same_conversation(self, test_client):
        """Multiple users can connect to same conversation"""
        conv_id = "shared-conv"
        users = await asyncio.gather(*[
            UserFactory.create() for _ in range(3)
        ])
        
        websockets = []
        for user in users:
            token = generate_jwt(user.id)
            ws = await aconnect_ws(
                f"{test_client}/ws/chat/{conv_id}",
                params={"token": token}
            ).__aenter__()
            websockets.append(ws)
        
        try:
            # All should be connected
            for ws in websockets:
                assert ws.state.name == "CONNECTED"
            
            # Message from one user
            await websockets[0].send_json({
                "type": "message",
                "content": "Hello everyone"
            })
            
            # All users should receive broadcast
            for i, ws in enumerate(websockets):
                if i > 0:  # Skip sender
                    broadcast = await ws.receive_json()
                    assert broadcast["type"] == "broadcast"
                    assert broadcast["content"] == "Hello everyone"
                    assert broadcast["user_id"] == users[0].id
        
        finally:
            for ws in websockets:
                await ws.__aexit__(None, None, None)
    
    @pytest.mark.asyncio
    async def test_max_connections_per_user(self, test_client, authenticated_user):
        """Test max connections limit per user"""
        token = generate_jwt(authenticated_user.id)
        connections = []
        
        # Create 5 connections (the limit)
        for i in range(5):
            ws = await aconnect_ws(
                f"{test_client}/ws/chat/conv{i}",
                params={"token": token}
            ).__aenter__()
            connections.append(ws)
        
        # 6th connection should fail
        with pytest.raises(Exception) as exc:
            async with aconnect_ws(
                f"{test_client}/ws/chat/conv6",
                params={"token": token}
            ) as ws:
                error = await ws.receive_json()
                assert error["code"] == "MAX_CONNECTIONS"
        
        # Clean up
        for ws in connections:
            await ws.__aexit__(None, None, None)

class TestErrorHandling:
    """Test error scenarios"""
    
    @pytest.mark.asyncio
    async def test_handles_invalid_json(self, test_client, authenticated_ws):
        """Test handling of invalid JSON"""
        await authenticated_ws.send_text("not json{")
        
        error = await authenticated_ws.receive_json()
        assert error["type"] == "error"
        assert error["code"] == "INVALID_JSON"
    
    @pytest.mark.asyncio
    async def test_handles_agent_errors(self, test_client, authenticated_ws):
        """Test handling when agent system fails"""
        with patch('src.agents.process_message', side_effect=Exception("Agent failed")):
            await authenticated_ws.send_json({
                "type": "message",
                "content": "Trigger agent error"
            })
            
            error = await authenticated_ws.receive_json()
            assert error["type"] == "error"
            assert error["code"] == "PROCESSING_ERROR"
            assert "try again" in error["message"].lower()
    
    @pytest.mark.asyncio
    async def test_graceful_shutdown(self, test_client, authenticated_ws):
        """Test graceful shutdown notification"""
        # Simulate shutdown signal
        with patch('src.services.websocket_manager.shutting_down', True):
            notification = await authenticated_ws.receive_json()
            assert notification["type"] == "system"
            assert notification["action"] == "shutdown"
            assert "reconnect_after" in notification

# Fixtures
@pytest.fixture
async def authenticated_ws(test_client, authenticated_user):
    """Provide authenticated WebSocket connection"""
    token = generate_jwt(authenticated_user.id)
    
    async with aconnect_ws(
        f"{test_client}/ws/chat/test-conv",
        params={"token": token}
    ) as ws:
        await ws.receive_json()  # Skip welcome
        yield ws

@pytest.fixture
async def authenticated_user():
    """Create and return authenticated user"""
    return await UserFactory.create(
        email="test@example.com",
        is_active=True
    )
```

### Step 8: Implementation Based on Tests

```python
# The implementation continues with the backend-coder agent creating code
# that makes all tests pass, following TDD principles
```

## 🔄 Typical Workflow Pattern

### Phase 1: Planning (2-3 hours)
1. User provides link to phase plan
2. Research swarm investigates latest best practices
3. Epic planner creates feature breakdown
4. Planning swarm creates detailed GitHub issues

### Phase 2: Implementation (Per Issue)
1. User selects specific issue to implement
2. Test writer creates comprehensive failing tests
3. Coders implement in parallel (backend/frontend)
4. Reviewer ensures quality

### Phase 3: Integration
1. Each feature is integrated incrementally
2. E2E tests verify complete flow
3. Performance optimization as needed

## 💡 Key Success Factors

1. **Research First** - Always investigate current best practices
2. **Detailed Issues** - Include actual code, not placeholders
3. **TDD Approach** - Tests before implementation
4. **Parallel Execution** - Multiple agents work simultaneously
5. **Incremental Delivery** - One issue at a time

## 📝 Example Prompts for Different Stages

### Creating Epic from Phase Plan
```
I have a phase plan at /docs/phases/[PHASE]/plan.md for [FEATURE].
Please create a GitHub epic with detailed issues following our SWARM methodology.
Research latest best practices and use 6-persona planning for comprehensive coverage.
```

### Implementing Specific Issue
```
Let's implement issue #[NUMBER] using TDD approach.
Create failing tests first, then parallel implementation with backend/frontend coders.
Ensure all tests pass and meet performance requirements.
```

### Adding Enhancement to Existing Feature
```
We need to add [ENHANCEMENT] to the existing [FEATURE].
Research if this changes our architecture, create focused issue, then implement.
Keep changes minimal and maintain backward compatibility.
```

## 🎯 Expected Outcomes

- **Well-Researched Solutions** - Using latest APIs and patterns
- **Comprehensive Test Coverage** - 95%+ with all edge cases
- **Production-Ready Code** - Error handling, monitoring, scaling
- **Clear Documentation** - Both in code and separate docs
- **Maintainable Architecture** - Following established patterns

This user story demonstrates the complete workflow from phase plan to implemented feature, showing how SWARM agents coordinate to deliver high-quality results efficiently.