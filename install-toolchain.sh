#!/usr/bin/env bash
# install-toolchain.sh — set up the Lean 4 toolchain for this workspace on Arch Linux.
#
# Strategy: install `elan` (the Lean version manager, the rustup analog) from the AUR, then let elan
# fetch the exact toolchain named in ./lean-toolchain. This matches the de Bruijn standard
# ("Toolchains via elan; lean-toolchain pins the project") and gives per-project pinning, which the
# Mathlib workflow (and its build cache) depend on. elan installs `lean` and `lake` under ~/.elan.
#
# Lean is not in the official Arch repos; `elan-lean` lives in the AUR, so this uses your AUR helper
# (paru/yay). Run it yourself — the AUR build needs sudo:
#
#     ./install-toolchain.sh
#
# Alternative (a fixed, system-wide Lean without pinning): `paru -S lean4-bin`. Not recommended here,
# because it does not honor ./lean-toolchain and fights the Mathlib cache. Prefer elan.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!! \033[0m %s\n' "$*" >&2; }

# --- 1. elan — the toolchain manager ---------------------------------------------------------------
if command -v elan >/dev/null 2>&1; then
  log "elan already installed: $(elan --version)"
else
  log "Installing elan (Lean version manager) from the AUR (package: elan-lean)…"
  if   command -v paru >/dev/null 2>&1; then paru -S --needed elan-lean
  elif command -v yay  >/dev/null 2>&1; then yay  -S --needed elan-lean
  else
    warn "No AUR helper (paru/yay) found. Install one, or build elan-lean manually:"
    warn "  git clone https://aur.archlinux.org/elan-lean.git && cd elan-lean && makepkg -si"
    exit 1
  fi
  hash -r
fi

# elan's proxy binaries (lean, lake, …) live here; make sure this shell — and future ones — see them.
export PATH="$HOME/.elan/bin:$PATH"
if ! grep -qs '.elan/bin' "$HOME/.profile" 2>/dev/null; then
  printf '\n# Lean toolchain (elan)\nexport PATH="$HOME/.elan/bin:$PATH"\n' >> "$HOME/.profile"
  log "Added ~/.elan/bin to ~/.profile (open a new shell, or 'source ~/.profile', to pick it up)."
fi

# --- 2. The pinned toolchain -----------------------------------------------------------------------
if [[ ! -f lean-toolchain ]]; then
  warn "No ./lean-toolchain found; writing the de Bruijn epoch pin."
  printf '%s\n' "leanprover/lean4:v4.32.0" > lean-toolchain
fi
PIN="$(tr -d '[:space:]' < lean-toolchain)"

log "Installing Lean toolchain: $PIN"
elan toolchain install "$PIN"

# --- 3. Verify (from this directory, so ./lean-toolchain is honored) --------------------------------
log "Verifying — versions in this workspace:"
lean --version
lake --version
echo
elan show

log "Done. This directory is pinned to $PIN via ./lean-toolchain."
log "Next: stand up the Lake package deliberately through the debruijn-init skill (per WORKFLOW)."
