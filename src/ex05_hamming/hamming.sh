#!/usr/bin/env bash

# The following comments should help you get started:
main () {
  if [[ $# -ne 2 ]];then
    echo "Usage: hamming.sh <string1> <string2>"
    exit 1
  fi

  sequence1=$1
  sequence2=$2

  if [[ ${#sequence1} -ne ${#sequence2} ]];then
    echo "Usage: The strands must be of equal length"
    exit 1
  fi

  first_arg_split_in_lines=$(echo "$sequence1" | grep -o .)
  second_arg_split_in_lines=$(echo "$sequence2" | grep -o .)

  first_arg_in_array=( $first_arg_split_in_lines )
  second_arg_in_array=( $second_arg_split_in_lines )

  cont=0

  for i in "${!first_arg_in_array[@]}"
  do
    if [[ "${first_arg_in_array[$i]}" != "${second_arg_in_array[$i]}" ]];then
      cont=$((cont + 1))
    fi
  done
  echo $cont

  exit 0
}

main "$@"