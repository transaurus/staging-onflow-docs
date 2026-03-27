#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for onflow/docs
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
# Docusaurus 3.9.1 requires Node >=18; use Node 20+
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh"
    nvm use 20 2>/dev/null || nvm install 20
fi
echo "[INFO] Using Node $(node --version)"

# --- Package manager: Yarn (classic v1) ---
if ! command -v yarn &>/dev/null; then
    echo "[INFO] Installing yarn..."
    npm install -g yarn
fi

# --- Dependencies ---
yarn install --frozen-lockfile 2>/dev/null || yarn install

# --- Build ---
yarn build

echo "[DONE] Build complete."
