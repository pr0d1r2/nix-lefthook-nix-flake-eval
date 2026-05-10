# shellcheck shell=bash
# Lefthook-compatible nix flake eval checker.
# Evaluates a configurable flake output attribute to catch nix errors early.
# Usage: lefthook-nix-flake-eval
# Environment:
#   LEFTHOOK_NIX_FLAKE_EVAL_ATTR — attribute to evaluate (required)
#     e.g. ".#darwinConfigurations.myhost.system"
# NOTE: sourced by writeShellApplication - no shebang or set needed.

attr="${LEFTHOOK_NIX_FLAKE_EVAL_ATTR:-}"
if [ -z "$attr" ]; then
    echo "lefthook-nix-flake-eval: LEFTHOOK_NIX_FLAKE_EVAL_ATTR not set" >&2
    echo "  Set it in lefthook.yml env or shell, e.g.:" >&2
    echo "  LEFTHOOK_NIX_FLAKE_EVAL_ATTR='.#darwinConfigurations.myhost.system'" >&2
    exit 1
fi

nix --extra-experimental-features 'nix-command flakes' eval "$attr" > /dev/null 2>&1
