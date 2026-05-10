#!/usr/bin/env bats

setup() {
    load "${BATS_LIB_PATH}/bats-support/load.bash"
    load "${BATS_LIB_PATH}/bats-assert/load.bash"

    TMP="$BATS_TEST_TMPDIR"
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
    export LEFTHOOK_NIX_FLAKE_EVAL_ATTR=".#packages"
    run lefthook-nix-flake-eval
    assert_success
}
