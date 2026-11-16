# Agent Guidance: Full Cycle OpenCode Pack

This file is for OpenCode and other coding agents working on this repository.

## Project Overview

This repository is a **global OpenCode pack**: a curated collection of agents and
commands that extend OpenCode with architectural documentation and analysis
capabilities. It is NOT a runtime application. The deliverables are the
Markdown files under `.opencode/` plus the human documentation under `docs/`.

The pack is organized into four functional areas:

| Pack | Agents | Commands | Docs |
| ------ | -------- | ---------- | ------ |
| ADRs Management | `adr-analyzer`, `adr-generator`, `adr-linker` | `/adr-map`, `/adr-identify`, `/adr-generate`, `/adr-link` | `docs/adrs-management.md` |
| Diagrams Generator | `c4-diagram-generator`, `mermaid-diagram-generator` | `/c4-generate`, `/mermaid-generate` | `docs/diagrams-generator.md` |
| Project Analyzer | `architectural-analyzer`, `component-deep-analyzer`, `dependency-auditor` | `/generate-architectural-report`, `/run-dependency-audit` | `docs/project-analyzer.md` |
| Development Guidelines | (command only) | `/generate-development-guideline` | `docs/development-guidelines.md` |

## Directory Layout Conventions

OpenCode loads agents and commands from **flat** directories. Do **not** nest
files inside `.opencode/agents/` or `.opencode/commands/`.

```text
.
├── .opencode/
│   ├── agents/                 # 8 subagent definitions
│   │   ├── adr-analyzer.md
│   │   ├── adr-generator.md
│   │   ├── adr-linker.md
│   │   ├── architectural-analyzer.md
│   │   ├── c4-diagram-generator.md
│   │   ├── component-deep-analyzer.md
│   │   ├── dependency-auditor.md
│   │   └── mermaid-diagram-generator.md
│   └── commands/               # 9 slash-command definitions
│       ├── adr-generate.md
│       ├── adr-identify.md
│       ├── adr-link.md
│       ├── adr-map.md
│       ├── c4-generate.md
│       ├── generate-architectural-report.md
│       ├── generate-development-guideline.md
│       ├── mermaid-generate.md
│       └── run-dependency-audit.md
├── docs/                       # Human-facing usage guides
│   ├── index.md
│   ├── adrs-management.md
│   ├── diagrams-generator.md
│   ├── project-analyzer.md
│   └── development-guidelines.md
├── install.sh                  # macOS / Linux installer
├── install.ps1                 # Windows installer
├── README.md                   # Main project entry point
└── AGENTS.md                   # This file
```

### Naming Rules

- **Agents**: `{area}-{role}.md` or `{area}-{generator-type}.md`
- **Commands**: Mirror the slash command name exactly, e.g. `/adr-map` →
  `adr-map.md`
- **Docs**: `{pack-name}.md` in kebab-case

## How to Set Up / Test This Pack

### Option 1: Install scripts (recommended)

```bash
# macOS / Linux
./install.sh

# Windows (PowerShell)
.\install.ps1
```

The installers copy (or symlink) `.opencode/agents/*.md` and
`.opencode/commands/*.md` into the user's OpenCode config directory.

### Option 2: Manual copy

```bash
# Global install (Unix)
cp .opencode/agents/*.md ~/.config/opencode/agents/
cp .opencode/commands/*.md ~/.config/opencode/commands/

# Global install (Windows PowerShell)
Copy-Item .opencode\agents\*.md "$env:USERPROFILE\.config\opencode\agents\"
Copy-Item .opencode\commands\*.md "$env:USERPROFILE\.config\opencode\commands\"
```

### Option 3: Project-local install

Install the pack into a specific project so the agents and commands are
available only inside that project.

```bash
# macOS / Linux
./install.sh --project-dir /path/to/target/project

# Windows PowerShell
.\install.ps1 -ProjectDir C:\path\to\target\project
```

You can also copy the folder manually:

```bash
cp -r .opencode /path/to/target/project/
```

### Restart OpenCode

After installing, restart OpenCode so it loads the new agents and commands.

## How to Verify an Installation

1. Restart OpenCode.
2. Type `/` in the chat and confirm the new commands appear.
3. Run a lightweight smoke test, for example:
   - `/adr-map --output-dir=tmp/test-adrs`
   - `/generate-development-guideline Go`
4. Check that the expected output files are created.

## Maintenance Notes

- Keep `.opencode/agents/` and `.opencode/commands/` flat.
- When adding a new agent or command, update:
  - This `AGENTS.md` table
  - `README.md` (What's Included, Quick Start, Installation counts)
  - `docs/index.md`
  - `opencode-pack.json` manifest
- Keep command syntax consistent between the command file front matter,
  the command body, and the matching docs page.
- All generated content defaults to project-relative directories
  (`docs/adrs`, `docs/c4`, `docs/agents`, etc.). Do not change these defaults
  unless the user explicitly requests it.

## Common Issues

- **Commands do not appear after install**: OpenCode must be restarted.
- **Wrong config path**: Set `OPENCODE_CONFIG_DIR` (Unix) or
  `$env:OPENCODE_CONFIG_DIR` (Windows) before running the installer.
- **Conflicts with existing agents/commands**: The installers back up replaced
  files with a timestamp suffix.
