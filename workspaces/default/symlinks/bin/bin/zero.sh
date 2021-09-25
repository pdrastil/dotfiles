#!/bin/bash

OPTS=$(getopt -o )


POSITIONAL=()
OPTIONS=()
while (( "$#" )); do
  key="$1"
  case $key in
    -*)
    OPTIONS+=("$key")
    shift
    ;;
    *)
    POSITIONAL+=("$key")
    shift
    ;;
  esac
done

if (( ${#POSITIONAL[@]} == 1 )); then

fi

echo $POSITIONAL
echo $OPTIONS
#set -x
#if [[ "$#" != "1" ]]; then
#  zero "$@"
#fi

#zero "$@" "default"
