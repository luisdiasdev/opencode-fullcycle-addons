# Full Cycle OpenCode Pack

A collection of [OpenCode](https://opencode.ai) agents and commands for software architecture and design documentation.

## What's Included

This pack provides four sets of agents and commands for architectural documentation and analysis:

- **[ADRs Management](./docs/adrs-management.md)** - Comprehensive Architecture Decision Records (ADRs) analysis, generation, and linking
- **[Diagrams Generator](./docs/diagrams-generator.md)** - Generate C4 and Mermaid diagrams from Feature Design Documents (FDDs)
- **[Project Analyzer](./docs/project-analyzer.md)** - Comprehensive architectural analysis, component deep-dive, and dependency auditing
- **[Development Guidelines](./docs/development-guidelines.md)** - Generate comprehensive language-specific development guideline documents

## Installation

The agents and commands live in [`.opencode/`](./.opencode) (8 subagents + 9 commands). Copy (or symlink) the files into your global OpenCode config:

```bash
cp .opencode/agents/*.md ~/.config/opencode/agents/
cp .opencode/commands/*.md ~/.config/opencode/commands/
```

Or into a single project's `.opencode/agents/` and `.opencode/commands/` for project-only use. You can also copy only the files you want. Restart OpenCode afterwards.

## Quick Start

### ADRs Management

Document architectural decisions systematically:

```bash
/adr-map                    # Phase 1: Map codebase
/adr-identify AUTH DATA     # Phase 2: Identify potential ADRs
/adr-generate BILLING       # Phase 3: Generate formal ADRs
/adr-link                   # Link ADRs with relationships
```

### Diagrams Generator

Create visual documentation from FDDs:

```bash
/c4-generate docs/features/payment-fdd.md
/mermaid-generate docs/features/auth-fdd.md
```

### Project Analyzer

Analyze project architecture and dependencies:

```bash
/generate-architectural-report
/run-dependency-audit
```

### Development Guidelines

Generate comprehensive development guidelines for any programming language:

```bash
/generate-development-guideline Python
/generate-development-guideline TypeScript --orm=prisma --web=express --testing=jest
/generate-development-guideline Go --orm=sqlc --web=chi --db=pgx
```

## Documentation

For detailed usage instructions, see each pack's documentation:

- [ADRs Management Usage Guide](./docs/adrs-management.md)
- [Diagrams Generator Usage Guide](./docs/diagrams-generator.md)
- [Project Analyzer Usage Guide](./docs/project-analizer.md)
- [Development Guidelines Usage Guide](./docs/development-guidelines.md)
