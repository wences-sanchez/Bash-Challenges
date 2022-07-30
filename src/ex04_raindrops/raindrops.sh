#!/bin/bash

are_factors() {
  local num=$1
  local factor=$2
  [[ $((num % factor)) -eq 0 ]]
  echo $?
}

main() {

  if [[ $# -ne 1 ]];then
    echo "Usage: raindrops.sh <number>"
    exit 1
  fi

  local num=$1

  if [[ $num -eq 0 ]];then
    echo -e "ARG=0\tDivision by 0 not allowed."
    exit 1
  fi

  if [[ $(are_factors "$num" 3) -eq 0 ]]; then echo -n "Pling"; fi
  if [[ $(are_factors "$num" 5) -eq 0 ]]; then echo -n "Plang"; fi
  if [[ $(are_factors "$num" 7) -eq 0 ]]; then echo -n "Plong"; fi

  if [[ $(are_factors "$num" 3) -ne 0 ]] && \
      [[ $(are_factors "$num" 5) -ne 0 ]] && \
      [[ $(are_factors "$num" 7) -ne 0 ]];then
    echo "$num"
  fi

  exit 0
}

main "$@"
