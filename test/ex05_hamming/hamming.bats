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
  chmod +x $DIR/../../src/ex05_hamming/hamming.sh
  PATH="$DIR/../../src/ex05_hamming/:$PATH"
}

teardown() {
  # executed after each test
  echo "teardown" >&3
}

@test "test_one_distinct_char" {
  run hamming.sh "CAG" "AAG"
  assert_output 1

  run hamming.sh "CAGTAAGTCCAT" "TAGTAGGTTCAC"
  assert_output 4
}

@test "test_incorrect_number_of_args" {
  run hamming.sh "CATG"
  assert_output "Usage: hamming.sh <string1> <string2>"
}

@test "test_args_of_different_lengths" {
  run hamming.sh "TGA" "CAGT"
  assert_output "Usage: The strands must be of equal length"
}