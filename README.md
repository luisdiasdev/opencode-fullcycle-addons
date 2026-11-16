# Full Cycle OpenCode Pack

A collection of [OpenCode](https://opencode.ai) agents and commands for software
architecture and design documentation.

## What's Included

This pack provides four sets of agents and commands for architectural
documentation and analysis:

- **[ADRs Management](./docs/adrs-management.md)** — Comprehensive Architecture
  Decision Records (ADRs) analysis, generation, and linking.
- **[Diagrams Generator](./docs/diagrams-generator.md)** — Generate C4 and
  Mermaid diagrams from Feature Design Documents (FDDs).
- **[Project Analyzer](./docs/project-analyzer.md)** — Comprehensive
  architectural analysis, component deep-dive, and dependency auditing.
- **[Development Guidelines](./docs/development-guidelines.md)** — Generate
  comprehensive language-specific development guideline documents.

The pack ships with **8 subagents** and **9 slash commands**.

## Directory Layout

OpenCode loads agents and commands from flat directories, so the `.opencode/`
folder keeps them at the top level:

```text
.
├── .opencode/
│   ├── agents/           # 8 subagent definitions
│   └── commands/         # 9 slash-command definitions
├── docs/                 # Usage guides
│   ├── index.md
│   ├── adrs-management.md
│   ├── diagrams-generator.md
│   ├── project-analyzer.md
│   └── development-guidelines.md
├── install.sh            # macOS / Linux installer
├── install.ps1           # Windows installer
├── opencode-pack.json    # Pack metadata
├── README.md             # This file
└── AGENTS.md             # Contributor / maintainer notes
```

## Installation

Choose one of the methods below. After installing, **restart OpenCode** so it
loads the new agents and commands.

### Option 1: Install script (recommended)

**macOS / Linux**

```bash
./install.sh
```

**Windows (PowerShell)**

```powershell
.\install.ps1
```

Use the `--symlink` (Linux/macOS) or `-Symlink` (Windows) flag to keep the
files linked to this repository instead of copying them. On Windows, symlinks
require Administrator rights or Developer Mode; the installer automatically
falls back to copy mode if symlinks cannot be created.

### Option 2: Manual copy

#### Global install (macOS / Linux)

```bash
cp .opencode/agents/*.md ~/.config/opencode/agents/
cp .opencode/commands/*.md ~/.config/opencode/commands/
```

#### Global install (Windows — PowerShell)

```powershell
Copy-Item .opencode\agents\*.md "$env:USERPROFILE\.config\opencode\agents\"
Copy-Item .opencode\commands\*.md "$env:USERPROFILE\.config\opencode\commands\"
```

### Option 3: Project-local install

Copy the `.opencode/` folder into a target project. The agents and commands
will be available only inside that project.

```bash
cp -r .opencode /path/to/your/project/
```

### Custom config directory

If OpenCode is installed in a non-standard location, set the config directory
before running the installer:

```bash
# Linux / macOS
export OPENCODE_CONFIG_DIR=/path/to/opencode/config
./install.sh

# Windows PowerShell
$env:OPENCODE_CONFIG_DIR = "C:\path\to\opencode\config"
.\install.ps1
```

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

- [Documentation Index](./docs/index.md)
- [ADRs Management Usage Guide](./docs/adrs-management.md)
- [Diagrams Generator Usage Guide](./docs/diagrams-generator.md)
- [Project Analyzer Usage Guide](./docs/project-analyzer.md)
- [Development Guidelines Usage Guide](./docs/development-guidelines.md)

## Verification

After installation and restart:

1. Type `/` in the OpenCode chat and confirm the new commands appear.
2. Run a lightweight smoke test, for example:

   ```bash
   /adr-map --output-dir=tmp/test-adrs
   ```

3. Check that the expected output files are created.

## Contributing / Maintenance

See [AGENTS.md](./AGENTS.md) for file-naming conventions, directory-layout
rules, and the checklist to follow when adding new agents or commands.
