#!/usr/bin/env bash
#
# Install the Full Cycle OpenCode Pack globally or into a specific project.
#
# Usage:
#   ./install.sh                       # copy files globally
#   ./install.sh --symlink             # symlink files globally
#   ./install.sh --project-dir ./my-project
#   OPENCODE_CONFIG_DIR=/custom ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_AGENTS_DIR="${SCRIPT_DIR}/.opencode/agents"
SOURCE_COMMANDS_DIR="${SCRIPT_DIR}/.opencode/commands"

USE_SYMLINK=false
PROJECT_DIR=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --symlink|-s)
      USE_SYMLINK=true
      shift
      ;;
    --project-dir)
      PROJECT_DIR="$2"
      shift 2
      ;;
    --help|-h)
      echo "Usage: $0 [--symlink] [--project-dir <path>]"
      echo "  --symlink       Create symlinks instead of copying files."
      echo "  --project-dir   Install the pack into a project's .opencode folder."
      echo "  Set OPENCODE_CONFIG_DIR to override the global config directory."
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--symlink] [--project-dir <path>]"
      exit 1
      ;;
  esac
done

# Determine OpenCode config directory
if [[ -n "${OPENCODE_CONFIG_DIR:-}" ]]; then
  CONFIG_DIR="${OPENCODE_CONFIG_DIR}"
elif [[ -n "${PROJECT_DIR}" ]]; then
  # Project-local install: place files under <PROJECT_DIR>/.opencode
  CONFIG_DIR="$(cd "${PROJECT_DIR}" && pwd)/.opencode"
elif [[ "${OSTYPE:-}" == darwin* ]]; then
  CONFIG_DIR="${HOME}/Library/Application Support/opencode"
else
  CONFIG_DIR="${HOME}/.config/opencode"
fi

TARGET_AGENTS_DIR="${CONFIG_DIR}/agents"
TARGET_COMMANDS_DIR="${CONFIG_DIR}/commands"

mkdir -p "${TARGET_AGENTS_DIR}" "${TARGET_COMMANDS_DIR}"

install_file() {
  local src="$1"
  local dst_dir="$2"
  local filename
  filename="$(basename "${src}")"
  local dst="${dst_dir}/${filename}"

  if [[ -e "${dst}" ]] && [[ ! -L "${dst}" ]]; then
    local backup
    backup="${dst}.backup.$(date +%Y%m%d%H%M%S)"
    cp -a "${dst}" "${backup}"
    echo "  Backed up existing ${filename} -> ${backup}"
  fi

  if [[ "${USE_SYMLINK}" == true ]]; then
    rm -f "${dst}"
    ln -s "${src}" "${dst}"
  else
    cp -a "${src}" "${dst}"
  fi
}

echo "Installing Full Cycle OpenCode Pack..."
echo "  Source: ${SCRIPT_DIR}/.opencode"
echo "  Target: ${CONFIG_DIR}"
echo "  Mode:   $([[ "${USE_SYMLINK}" == true ]] && echo "symlink" || echo "copy")"
echo

echo "Installing agents into ${TARGET_AGENTS_DIR}:"
for f in "${SOURCE_AGENTS_DIR}"/*.md; do
  [[ -e "$f" ]] || continue
  install_file "$f" "${TARGET_AGENTS_DIR}"
  echo "  + $(basename "$f")"
done

echo
echo "Installing commands into ${TARGET_COMMANDS_DIR}:"
for f in "${SOURCE_COMMANDS_DIR}"/*.md; do
  [[ -e "$f" ]] || continue
  install_file "$f" "${TARGET_COMMANDS_DIR}"
  echo "  + $(basename "$f")"
done

echo
echo "Installation complete."
echo "Restart OpenCode to load the new agents and commands."
