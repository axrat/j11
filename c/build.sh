#!/bin/bash
if [ $# -ne 1 ]; then
  echo "require [name].c" 1>&2
  exit 1
fi
gcc -o $1.out $1.c
