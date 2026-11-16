# Full Cycle OpenCode Pack — Documentation Index

Welcome to the documentation for the Full Cycle OpenCode Pack.

## What This Pack Provides

A set of [OpenCode](https://opencode.ai) agents and slash commands for
software architecture documentation, analysis, and team guidelines.

| Pack | Purpose | Agents | Commands |
| ------ | --------- | -------- | ---------- |
| [ADRs Management](./adrs-management.md) | Capture and document architectural decisions | 3 | 4 |
| [Diagrams Generator](./diagrams-generator.md) | Generate C4 and Mermaid diagrams from FDDs | 2 | 2 |
| [Project Analyzer](./project-analyzer.md) | Audit architecture, components, and dependencies | 3 | 2 |
| [Development Guidelines](./development-guidelines.md) | Generate language-specific dev guidelines | — | 1 |

## Quick Command Reference

### ADRs Management

```text
/adr-map [--project-dir=PATH] [--context-dir=PATH] [--output-dir=PATH]
/adr-identify [module-ids] [--output-dir=PATH] [--adrs-dir=PATH]
/adr-generate [modules] [--context-dir=PATH] [--language=LOCALE] [--include-consider] [--output-dir=PATH]
/adr-link [modules] [--validate] [--report-only] [--adrs-path=PATH] [--output-dir=PATH]
```

### Diagrams Generator

```text
/c4-generate <path-to-fdd.md> [output-folder] [--no-images]
/mermaid-generate <path-to-fdd.md> [output-folder]
```

### Project Analyzer

```text
/generate-architectural-report [--project-folder=PATH] [--output-folder=PATH] [--ignore-folders=LIST]
/run-dependency-audit [--project-folder=PATH] [--output-folder=PATH] [--ignore-folders=LIST]
```

### Development Guidelines

```text
/generate-development-guideline <language-name> [--param=value ...]
```

## Installation

See the [README](../README.md#installation) for setup options, including
install scripts, manual copy, and project-local installation.

## Suggested Workflows

### Document Architecture Decisions

```text
/adr-map
/adr-identify AUTH DATA API
/adr-generate --include-consider AUTH DATA API
/adr-link
```

### Analyze and Visualize a Feature

```text
/generate-architectural-report
/c4-generate docs/features/payment-fdd.md
/mermaid-generate docs/features/payment-fdd.md
```

### Onboard a Team with Guidelines

```text
/generate-development-guideline TypeScript --orm=prisma --web=express --testing=jest
```

## Need More Detail?

- Each pack has a dedicated guide linked in the table above.
- The [README](../README.md) covers installation, quick start, and project layout.
- The [AGENTS.md](../AGENTS.md) file contains contributor and maintainer guidance.
