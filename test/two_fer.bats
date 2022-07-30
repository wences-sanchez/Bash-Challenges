#!/usr/bin/env bats

setup() {
  # executed before each test
  echo "setup" >&3
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  # make executables in src/two-fer visible to PATH
  # just because we want separate directories for every script (for clarity)
  PATH="$DIR/../src/two-fer:$PATH"
}

teardown() {
  # executed after each test
  echo "teardown" >&3
}

@test "test_name_is_included" {
  run two_fer.sh "Wences"
  assert_output --partial "Wences"
}

@test "test_complete_exact_message_when_given_arg" {
  run two_fer.sh "David"
  assert_output "One for David, one for me."

  run two_fer.sh "Billy Jean"
  assert_output "One for Billy Jean, one for me."
}

@test "test_message_when_no_args" {
  run two_fer.sh
  assert_output "One for you, one for me."
}