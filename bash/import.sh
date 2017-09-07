#!/bin/bash

export X="$(cd $(dirname $BASH_SOURCE); pwd)"
export J="${X}/import.sh"

load(){
  if [ $# -ne 1 ]; then
    echo "Require [Name]"
  else
    SCRIPT=$1.sh
    if [ -f "$SCRIPT" ]; then
       source $SCRIPT
    else
       echo "$SCRIPT not found."
    fi
  fi
}
loadx(){
  load $X/$1
}

loadx "for"
loadx "alias"
loadx var
loadx func
loadx git
