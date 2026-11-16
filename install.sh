#!/usr/bin/env bash
#
# Install the Full Cycle OpenCode Pack globally.
#
# Usage:
#   ./install.sh                  # copy files
#   ./install.sh --symlink        # symlink files (keeps repo live)
#   OPENCODE_CONFIG_DIR=/custom ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_AGENTS_DIR="${SCRIPT_DIR}/.opencode/agents"
SOURCE_COMMANDS_DIR="${SCRIPT_DIR}/.opencode/commands"

USE_SYMLINK=false

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --symlink|-s)
      USE_SYMLINK=true
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--symlink]"
      echo "  --symlink  Create symlinks instead of copying files."
      echo "  Set OPENCODE_CONFIG_DIR to override the target config directory."
      exit 0
      ;;
  esac
done

# Determine OpenCode config directory
if [[ -n "${OPENCODE_CONFIG_DIR:-}" ]]; then
  CONFIG_DIR="${OPENCODE_CONFIG_DIR}"
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
