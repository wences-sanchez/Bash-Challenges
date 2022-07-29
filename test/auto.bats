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
  # make executables in src/ visible to PATH
  PATH="$DIR/../src:$PATH"
}

teardown() {
  # executed after each test
  echo "teardown" >&3
}

@test "test_name" {
  run two_fer.sh
  assert_output 'Hola mundo'
}
