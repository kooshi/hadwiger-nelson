# EXT-OAI1: the Arch build environment for the working copy's toolchain (v4.34.1); source before lake.
# Same two variables as lean-dir's scripts/dev-env.sh, derived for the working copy's toolchain instead of lean-dir's.
export LEAN_CC=clang
export LEAN_ABORT_ON_PANIC=1
export LIBRARY_PATH="$HOME/.elan/toolchains/leanprover--lean4---v4.34.1/lib"
export OAI1_WC="$HOME/.cache/ext-oai1/lean"
