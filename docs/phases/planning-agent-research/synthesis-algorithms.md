# Synthesis Algorithms for Multi-Persona Output Integration

This document provides detailed algorithms and strategies for synthesizing outputs from multiple personas into cohesive, comprehensive GitHub issues.

## Core Synthesis Algorithm

```python
class PersonaSynthesizer:
    """Main synthesis engine for multi-persona outputs."""
    
    def __init__(self):
        self.conflict_resolver = ConflictResolver()
        self.template_engine = TemplateEngine()
        self.validator = OutputValidator()
        
    async def synthesize(self, persona_outputs: Dict[str, str]) -> str:
        """
        Main synthesis algorithm combining all persona outputs.
        
        Args:
            persona_outputs: Dictionary mapping persona name to their output
            
        Returns:
            Synthesized GitHub issue content
        """
        # Step 1: Parse and structure each output
        structured_outputs = {}
        for persona, output in persona_outputs.items():
            structured_outputs[persona] = self.parse_persona_output(output)
        
        # Step 2: Identify and resolve conflicts
        conflicts = self.identify_conflicts(structured_outputs)
        resolutions = self.conflict_resolver.resolve(conflicts)
        
        # Step 3: Merge complementary information
        merged_data = self.merge_outputs(structured_outputs, resolutions)
        
        # Step 4: Apply template and formatting
        formatted_issue = self.template_engine.format(merged_data)
        
        # Step 5: Validate completeness
        validation_result = self.validator.validate(formatted_issue)
        if not validation_result.is_valid:
            formatted_issue = self.enhance_missing_sections(
                formatted_issue, 
                validation_result.missing_sections
            )
        
        return formatted_issue
```

## Conflict Resolution Strategies

### 1. Timeline Conflicts

```python
class TimelineConflictResolver:
    """Resolve conflicts in timeline estimates."""
    
    def resolve(self, estimates: Dict[str, int]) -> int:
        """
        Resolve different time estimates from personas.
        
        Strategy:
        1. Product Owner: Business deadline pressure
        2. Project Manager: Realistic with buffer
        3. Senior Developer: Technical estimate
        4. Apply weighted average with PM having highest weight
        """
        weights = {
            'product_owner': 0.15,      # Often optimistic
            'project_manager': 0.40,    # Most realistic
            'senior_developer': 0.35,   # Technical accuracy
            'test_writer': 0.10         # Testing overhead
        }
        
        # Calculate weighted average
        weighted_sum = sum(
            estimates.get(persona, 0) * weight 
            for persona, weight in weights.items()
        )
        
        # Add 20% buffer as per best practices
        final_estimate = int(weighted_sum * 1.2)
        
        # Round to nearest half-day
        return round(final_estimate * 2) / 2
```

### 2. Technical Approach Conflicts

```python
class TechnicalConflictResolver:
    """Resolve conflicts in technical approaches."""
    
    def resolve(self, approaches: Dict[str, Dict]) -> Dict:
        """
        Resolve different technical approaches.
        
        Priority order:
        1. Security requirements (non-negotiable)
        2. Performance requirements
        3. Developer preference
        4. Existing patterns
        """
        resolved = {}
        
        # Security expert's requirements are mandatory
        if 'security_expert' in approaches:
            resolved['security'] = approaches['security_expert']
        
        # Senior developer's architecture unless it conflicts with security
        if 'senior_developer' in approaches:
            dev_approach = approaches['senior_developer']
            if not self.conflicts_with_security(dev_approach, resolved.get('security')):
                resolved['architecture'] = dev_approach
            else:
                resolved['architecture'] = self.merge_with_security_requirements(
                    dev_approach, 
                    resolved['security']
                )
        
        # Frontend approach must align with backend
        if 'frontend_expert' in approaches:
            resolved['frontend'] = self.align_frontend_backend(
                approaches['frontend_expert'],
                resolved.get('architecture', {})
            )
        
        return resolved
```

### 3. Priority Conflicts

```python
class PriorityConflictResolver:
    """Resolve conflicts in feature priorities."""
    
    def resolve(self, priorities: Dict[str, str]) -> str:
        """
        Resolve different priority assessments.
        
        Uses a scoring system based on:
        - Business value (Product Owner)
        - Technical risk (Senior Developer)
        - Resource availability (Project Manager)
        """
        priority_scores = {
            'critical': 4,
            'high': 3,
            'medium': 2,
            'low': 1
        }
        
        score_weights = {
            'product_owner': 0.4,     # Business priority
            'project_manager': 0.3,   # Resource constraints
            'senior_developer': 0.2,  # Technical complexity
            'security_expert': 0.1    # Security criticality
        }
        
        total_score = 0
        for persona, priority in priorities.items():
            if persona in score_weights:
                score = priority_scores.get(priority.lower(), 2)
                total_score += score * score_weights[persona]
        
        # Map score back to priority
        if total_score >= 3.5:
            return 'critical'
        elif total_score >= 2.5:
            return 'high'
        elif total_score >= 1.5:
            return 'medium'
        else:
            return 'low'
```

## Information Merging Strategies

### 1. Complementary Information Merger

```python
class ComplementaryMerger:
    """Merge non-conflicting, complementary information."""
    
    def merge_user_stories(self, stories: Dict[str, List[Dict]]) -> List[Dict]:
        """Merge user stories from different personas."""
        merged_stories = []
        seen_stories = set()
        
        # Product owner stories take precedence
        if 'product_owner' in stories:
            for story in stories['product_owner']:
                story_key = self.generate_story_key(story)
                if story_key not in seen_stories:
                    merged_stories.append(story)
                    seen_stories.add(story_key)
        
        # Add additional stories from other personas
        for persona, persona_stories in stories.items():
            if persona == 'product_owner':
                continue
                
            for story in persona_stories:
                story_key = self.generate_story_key(story)
                if story_key not in seen_stories:
                    # Tag with source persona
                    story['source'] = persona
                    merged_stories.append(story)
                    seen_stories.add(story_key)
        
        return self.prioritize_stories(merged_stories)
    
    def merge_test_scenarios(self, scenarios: Dict[str, List]) -> Dict:
        """Merge test scenarios ensuring comprehensive coverage."""
        merged = {
            'unit_tests': [],
            'integration_tests': [],
            'e2e_tests': [],
            'performance_tests': [],
            'security_tests': []
        }
        
        # Test writer provides primary test suite
        if 'test_writer' in scenarios:
            merged.update(scenarios['test_writer'])
        
        # Security expert adds security-specific tests
        if 'security_expert' in scenarios:
            merged['security_tests'].extend(
                scenarios['security_expert'].get('security_tests', [])
            )
        
        # Frontend expert adds UI-specific tests
        if 'frontend_expert' in scenarios:
            merged['e2e_tests'].extend(
                scenarios['frontend_expert'].get('ui_tests', [])
            )
        
        # Remove duplicates while preserving order
        for test_type in merged:
            merged[test_type] = self.deduplicate_tests(merged[test_type])
        
        return merged
```

### 2. Code Synthesis

```python
class CodeSynthesizer:
    """Synthesize code examples from multiple personas."""
    
    def synthesize_implementation(self, code_samples: Dict[str, Dict]) -> Dict:
        """
        Combine code samples into cohesive implementation.
        
        Returns:
            Dictionary with complete implementation code
        """
        implementation = {
            'backend': {},
            'frontend': {},
            'database': {},
            'tests': {},
            'infrastructure': {}
        }
        
        # Backend synthesis
        if 'senior_developer' in code_samples:
            implementation['backend'] = code_samples['senior_developer'].get('api', {})
        
        # Apply security enhancements
        if 'security_expert' in code_samples:
            implementation['backend'] = self.apply_security_patterns(
                implementation['backend'],
                code_samples['security_expert'].get('security_middleware', {})
            )
        
        # Frontend synthesis
        if 'frontend_expert' in code_samples:
            implementation['frontend'] = code_samples['frontend_expert']
        
        # Database schema
        if 'senior_developer' in code_samples:
            schema = code_samples['senior_developer'].get('database', {})
            
            # Apply security policies
            if 'security_expert' in code_samples:
                schema = self.add_security_policies(
                    schema,
                    code_samples['security_expert'].get('rls_policies', {})
                )
            
            implementation['database'] = schema
        
        # Test synthesis
        if 'test_writer' in code_samples:
            implementation['tests'] = code_samples['test_writer']
        
        return implementation
    
    def apply_security_patterns(self, base_code: Dict, security_code: Dict) -> Dict:
        """Apply security patterns to base implementation."""
        enhanced = base_code.copy()
        
        # Add authentication decorators
        if 'auth_decorators' in security_code:
            enhanced['decorators'] = security_code['auth_decorators']
        
        # Add input validation
        if 'validators' in security_code:
            enhanced['validators'] = security_code['validators']
        
        # Add security middleware
        if 'middleware' in security_code:
            enhanced['middleware'] = security_code['middleware']
        
        return enhanced
```

## Template Engine

### 1. Dynamic Template System

```python
class TemplateEngine:
    """Generate formatted GitHub issues from synthesized data."""
    
    def __init__(self):
        self.section_templates = self.load_section_templates()
        
    def format(self, data: Dict) -> str:
        """Format synthesized data into GitHub issue."""
        sections = []
        
        # Title
        title = self.generate_title(data)
        sections.append(f"# {title}")
        
        # Executive Summary
        if 'summary' in data:
            sections.append(self.format_summary(data['summary']))
        
        # Business Context (Product Owner)
        sections.append(self.format_business_context(data))
        
        # Project Planning (Project Manager)
        sections.append(self.format_project_planning(data))
        
        # Technical Architecture (Senior Developer)
        sections.append(self.format_technical_architecture(data))
        
        # Test Specifications (Test Writer)
        sections.append(self.format_test_specifications(data))
        
        # Frontend Implementation (Frontend Expert)
        if 'frontend' in data:
            sections.append(self.format_frontend_implementation(data))
        
        # Security Requirements (Security Expert)
        sections.append(self.format_security_requirements(data))
        
        # Implementation Code
        sections.append(self.format_implementation_code(data))
        
        # Definition of Done
        sections.append(self.format_definition_of_done(data))
        
        # Success Metrics
        sections.append(self.format_success_metrics(data))
        
        return "\n\n---\n\n".join(sections)
    
    def format_business_context(self, data: Dict) -> str:
        """Format business context section."""
        template = """
## 📊 Business Context

### User Stories
{user_stories}

### Business Value
{business_value}

### Success Criteria
{success_criteria}
"""
        
        user_stories = self.format_user_stories(data.get('user_stories', []))
        business_value = self.format_business_value(data.get('business_value', {}))
        success_criteria = self.format_success_criteria(data.get('acceptance_criteria', []))
        
        return template.format(
            user_stories=user_stories,
            business_value=business_value,
            success_criteria=success_criteria
        )
    
    def format_user_stories(self, stories: List[Dict]) -> str:
        """Format user stories with acceptance criteria."""
        formatted = []
        
        for i, story in enumerate(stories, 1):
            story_text = f"""
{i}. **{story.get('title', 'User Story')}**
   - **As a** {story.get('user_type', 'user')}
   - **I want** {story.get('feature', 'this feature')}
   - **So that** {story.get('benefit', 'I can achieve this goal')}
   
   **Acceptance Criteria:**
"""
            
            for criterion in story.get('acceptance_criteria', []):
                story_text += f"   - {criterion}\n"
            
            story_text += f"\n   **Priority:** {story.get('priority', 'Medium')}"
            formatted.append(story_text)
        
        return "\n".join(formatted)
```

### 2. Code Formatting

```python
class CodeFormatter:
    """Format code sections with syntax highlighting."""
    
    def format_code_section(self, code_data: Dict) -> str:
        """Format implementation code section."""
        sections = []
        
        # API Implementation
        if 'api' in code_data:
            sections.append(self.format_api_code(code_data['api']))
        
        # Database Schema
        if 'database' in code_data:
            sections.append(self.format_database_code(code_data['database']))
        
        # Frontend Components
        if 'frontend' in code_data:
            sections.append(self.format_frontend_code(code_data['frontend']))
        
        # Tests
        if 'tests' in code_data:
            sections.append(self.format_test_code(code_data['tests']))
        
        return "\n\n".join(sections)
    
    def format_api_code(self, api_code: Dict) -> str:
        """Format API implementation code."""
        template = """
### API Implementation

```python
# {filename}
{code}
```

**Key Features:**
{features}
"""
        
        formatted_sections = []
        for filename, code in api_code.items():
            features = self.extract_code_features(code)
            formatted_sections.append(
                template.format(
                    filename=filename,
                    code=code,
                    features=self.format_features_list(features)
                )
            )
        
        return "\n".join(formatted_sections)
```

## Validation System

### 1. Completeness Validator

```python
class OutputValidator:
    """Validate synthesized output for completeness."""
    
    def __init__(self):
        self.required_sections = [
            'user_stories',
            'acceptance_criteria',
            'technical_architecture',
            'test_specifications',
            'security_requirements',
            'timeline',
            'success_metrics'
        ]
        
        self.required_code_examples = [
            'api_endpoint',
            'database_schema',
            'test_example'
        ]
    
    def validate(self, issue_content: str) -> ValidationResult:
        """Validate issue completeness."""
        result = ValidationResult()
        
        # Check required sections
        for section in self.required_sections:
            if not self.section_exists(issue_content, section):
                result.add_missing_section(section)
        
        # Check code examples
        if not self.has_sufficient_code(issue_content):
            result.add_issue("Insufficient code examples")
        
        # Check for placeholders
        placeholders = self.find_placeholders(issue_content)
        if placeholders:
            result.add_issue(f"Found placeholders: {placeholders}")
        
        # Check acceptance criteria format
        if not self.validate_acceptance_criteria(issue_content):
            result.add_issue("Acceptance criteria not in BDD format")
        
        # Check timeline realism
        if not self.validate_timeline(issue_content):
            result.add_issue("Timeline may be unrealistic")
        
        return result
    
    def has_sufficient_code(self, content: str) -> bool:
        """Check if issue has enough actual code examples."""
        code_blocks = re.findall(r'```[\w]*\n(.*?)```', content, re.DOTALL)
        
        # Need at least 3 substantial code blocks
        substantial_blocks = [
            block for block in code_blocks 
            if len(block.strip()) > 50 and not self.is_pseudo_code(block)
        ]
        
        return len(substantial_blocks) >= 3
    
    def is_pseudo_code(self, code: str) -> bool:
        """Detect if code block contains pseudo-code."""
        pseudo_indicators = [
            '// TODO',
            '// IMPLEMENT',
            '...', 
            'PSEUDO:',
            '// Add implementation here'
        ]
        
        return any(indicator in code for indicator in pseudo_indicators)
```

### 2. Enhancement System

```python
class OutputEnhancer:
    """Enhance output to fix validation issues."""
    
    def enhance_missing_sections(self, content: str, missing: List[str]) -> str:
        """Add missing sections to output."""
        enhanced = content
        
        for section in missing:
            if section == 'user_stories' and 'user_stories' not in enhanced:
                enhanced = self.add_generic_user_stories(enhanced)
            elif section == 'security_requirements' and 'security' not in enhanced.lower():
                enhanced = self.add_security_section(enhanced)
            elif section == 'test_specifications' and 'test' not in enhanced.lower():
                enhanced = self.add_test_section(enhanced)
        
        return enhanced
    
    def add_generic_user_stories(self, content: str) -> str:
        """Add generic user stories if missing."""
        stories = """
## 📊 Business Context

### User Stories

1. **Primary User Flow**
   - **As a** user
   - **I want** to use this feature
   - **So that** I can accomplish my task efficiently
   
   **Acceptance Criteria:**
   - Given I am an authenticated user
   - When I access this feature
   - Then I should see the expected interface
   - And be able to complete the primary action

*Note: Please refine these user stories based on specific requirements*
"""
        
        # Insert after title
        lines = content.split('\n')
        insert_pos = 2  # After title and first separator
        lines.insert(insert_pos, stories)
        
        return '\n'.join(lines)
```

## Quality Scoring System

```python
class QualityScorer:
    """Score the quality of synthesized output."""
    
    def score(self, issue_content: str, persona_outputs: Dict[str, str]) -> QualityScore:
        """Calculate quality score for the synthesis."""
        score = QualityScore()
        
        # Completeness (40%)
        completeness = self.calculate_completeness(issue_content)
        score.add_component('completeness', completeness * 0.4)
        
        # Code quality (30%)
        code_quality = self.calculate_code_quality(issue_content)
        score.add_component('code_quality', code_quality * 0.3)
        
        # Clarity (20%)
        clarity = self.calculate_clarity(issue_content)
        score.add_component('clarity', clarity * 0.2)
        
        # Consensus (10%)
        consensus = self.calculate_consensus(persona_outputs)
        score.add_component('consensus', consensus * 0.1)
        
        return score
    
    def calculate_code_quality(self, content: str) -> float:
        """Score code quality from 0 to 1."""
        code_blocks = re.findall(r'```[\w]*\n(.*?)```', content, re.DOTALL)
        
        if not code_blocks:
            return 0.0
        
        quality_score = 0.0
        for block in code_blocks:
            # Check for completeness
            if not self.is_pseudo_code(block):
                quality_score += 0.3
            
            # Check for error handling
            if any(pattern in block for pattern in ['try:', 'except:', 'catch', 'error']):
                quality_score += 0.2
            
            # Check for documentation
            if any(pattern in block for pattern in ['"""', "'''", '//', '/*']):
                quality_score += 0.2
            
            # Check for type hints (Python) or types (TypeScript)
            if any(pattern in block for pattern in ['->', ': str', ': int', ': List', 
                                                   'interface', 'type', ': number']):
                quality_score += 0.3
        
        return min(1.0, quality_score / len(code_blocks))
```

## Usage Example

```python
async def synthesize_planning_output(persona_outputs: Dict[str, str]) -> str:
    """
    Main entry point for synthesis.
    
    Args:
        persona_outputs: Dictionary of persona name to their output content
        
    Returns:
        Complete GitHub issue content
    """
    synthesizer = PersonaSynthesizer()
    
    # Perform synthesis
    synthesized = await synthesizer.synthesize(persona_outputs)
    
    # Score quality
    scorer = QualityScorer()
    quality = scorer.score(synthesized, persona_outputs)
    
    # If quality is low, enhance
    if quality.total_score < 0.7:
        enhancer = OutputEnhancer()
        synthesized = enhancer.enhance(synthesized, quality.issues)
    
    # Add metadata
    metadata = {
        'synthesis_timestamp': datetime.utcnow().isoformat(),
        'quality_score': quality.total_score,
        'personas_included': list(persona_outputs.keys()),
        'version': '1.0'
    }
    
    synthesized = add_metadata_to_issue(synthesized, metadata)
    
    return synthesized
```

## Key Principles

1. **Prioritize Clarity**: Business context should be immediately understandable
2. **Preserve Technical Accuracy**: Don't simplify technical details
3. **Maintain Completeness**: Every section must have actionable content
4. **Ensure Executability**: Include real code, not placeholders
5. **Respect Expertise**: Security requirements are non-negotiable
6. **Balance Perspectives**: All personas should be represented
7. **Validate Output**: Always check for completeness and quality

## Performance Considerations

- Synthesis should complete within 5 seconds
- Use parallel processing for parsing and validation
- Cache common patterns and templates
- Stream output for large issues
- Implement retry logic for enhancement steps