#!/usr/bin/env bats

setup() {
    load "${BATS_LIB_PATH}/bats-support/load.bash"
    load "${BATS_LIB_PATH}/bats-assert/load.bash"

    unset LEFTHOOK_NIX_FLAKE_EVAL_ATTR
}

@test "fails when LEFTHOOK_NIX_FLAKE_EVAL_ATTR not set" {
    run lefthook-nix-flake-eval
    assert_failure
    assert_output --partial "LEFTHOOK_NIX_FLAKE_EVAL_ATTR not set"
}

@test "fails when LEFTHOOK_NIX_FLAKE_EVAL_ATTR is empty" {
    export LEFTHOOK_NIX_FLAKE_EVAL_ATTR=""
    run lefthook-nix-flake-eval
    assert_failure
    assert_output --partial "LEFTHOOK_NIX_FLAKE_EVAL_ATTR not set"
}

@test "succeeds evaluating own flake packages" {
    run nix --extra-experimental-features 'nix-command flakes' eval .#packages
    if [ "$status" -ne 0 ]; then
        skip "nix eval unavailable in this environment"
    fi
    export LEFTHOOK_NIX_FLAKE_EVAL_ATTR=".#packages"
    run lefthook-nix-flake-eval
    assert_success
}
