#!/usr/bin/env bats

setup() {
  # executed before each test
  echo "setup" >&3
  load '../test_helper/bats-support/load'
  load '../test_helper/bats-assert/load'
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  # make executables in src/two-fer visible to PATH
  # just because we want separate directories for every script (for clarity)
#  chmod +x $DIR/../../src/ex04_raindrops/*
  PATH="$DIR/../../src/ex04_raindrops/:$PATH"
}

teardown() {
  # executed after each test
  echo "teardown" >&3
}

@test "test_factor_is_3" {
  run raindrops.sh 3
  assert_output --partial "Pling"

  run raindrops.sh 15
  assert_output --partial "Pling"

  run raindrops.sh 33
  assert_output --partial "Pling"

  run raindrops.sh -3000
  assert_output --partial "Pling"
}

@test "test_factor_is_not_3" {
  run raindrops.sh 0
  refute_output --partial "Pling"

  run raindrops.sh 1
  refute_output --partial "Pling"

  run raindrops.sh -3001
  refute_output --partial "Pling"

  run raindrops.sh -1
  refute_output --partial "Pling"

  run raindrops.sh 4
  refute_output --partial "Pling"

  run raindrops.sh 2
  refute_output --partial "Pling"
}

@test "test_factor_is_5" {
  run raindrops.sh 5
  assert_output --partial "Plang"

  run raindrops.sh 15
  assert_output --partial "Plang"

  run raindrops.sh -50
  assert_output --partial "Plang"
}

@test "test_factor_is_not_5" {
  run raindrops.sh 0
  refute_output --partial "Plang"

  run raindrops.sh -1
  refute_output --partial "Plang"

  run raindrops.sh 1
  refute_output --partial "Plang"

  run raindrops.sh 4
  refute_output --partial "Plang"

  run raindrops.sh 6
  refute_output --partial "Plang"

  run raindrops.sh 101
  refute_output --partial "Plang"
}

@test "test_factor_is_7" {
  run raindrops.sh 7
  assert_output --partial "Plong"

  run raindrops.sh 21
  assert_output --partial "Plong"

  run raindrops.sh -70
  assert_output --partial "Plong"
}

@test "test_factor_is_not_7" {
  run raindrops.sh 0
  refute_output --partial "Plong"

  run raindrops.sh -1
  refute_output --partial "Plong"

  run raindrops.sh 1
  refute_output --partial "Plong"

  run raindrops.sh 6
  refute_output --partial "Plong"

  run raindrops.sh 8
  refute_output --partial "Plong"

  run raindrops.sh -69
  refute_output --partial "Plong"

  run raindrops.sh 71
  refute_output --partial "Plong"
}

@test "test_is_not_3_nor_5_nor_7" {
  run raindrops.sh 34
  assert_output '34'
}

@test "test_too_much_args" {
  run raindrops.sh 5 10
  assert_output "Usage: raindrops.sh <number>"
}