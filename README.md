# nix-lefthook-nix-flake-eval

Lefthook-compatible nix flake eval checker, packaged as a Nix flake.

Evaluates a configurable flake output attribute to catch nix evaluation errors on pre-commit.

## Usage

Add to `lefthook.yml` remotes:

```yaml
remotes:
  - git_url: https://github.com/pr0d1r2/nix-lefthook-nix-flake-eval
    ref: main
    configs:
      - lefthook-remote.yml
```

Set the attribute to evaluate in your local `lefthook.yml`:

```yaml
pre-commit:
  commands:
    nix-flake-eval:
      env:
        LEFTHOOK_NIX_FLAKE_EVAL_ATTR: ".#darwinConfigurations.myhost.system"
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `LEFTHOOK_NIX_FLAKE_EVAL_ATTR` | (required) | Flake attribute to evaluate |
| `LEFTHOOK_NIX_FLAKE_EVAL_TIMEOUT` | `60` | Timeout in seconds |

## Nix flake

Add to your `flake.nix` inputs and dev shell packages:

```nix
nix-lefthook-nix-flake-eval.url = "github:pr0d1r2/nix-lefthook-nix-flake-eval";
```
