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
  chmod +x $DIR/../../src/ex03_error-handling/*
  PATH="$DIR/../../src/ex03_error-handling:$PATH"
}

teardown() {
  # executed after each test
  echo "teardown" >&3
}

@test "test_arg_included_in_output" {
  run error_handling.sh "Wences"
  assert_output --partial "Wences"

  run error_handling.sh "Wenceslao Sánchez Pino"
  assert_output --partial "Wenceslao Sánchez Pino"
}

@test "test_error_message_when_more_than_one_arg" {
  run error_handling.sh Wences Sanchez
  assert_output "Usage: error_handling.sh <person>"
}

@test "test_error_message_when_no_args" {
  run error_handling.sh
  assert_output "Usage: error_handling.sh <person>"
}
