#!/usr/bin/env bash

main () {
  local name="$1"
  # If $name is empty, then it is shown the string 'you'
  echo "One for ${name:-you}, one for me."
}

main "$@"
