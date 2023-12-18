#!/bin/bash

#todo: make function easer.... for example: printf col green "123" 

# example
# printf "$(colorize blue "Compress...$some_variable") \n";

function colorize {
  local color="$1"
  local text="$2"
  local color_code
  case "$color" in
    red)
      color_code="\033[0;31m"
      ;;
    green)
      color_code="\033[0;32m"
      ;;
    yellow)
      color_code="\033[0;33m"
      ;;
    blue)
      color_code="\033[0;34m"
      ;;
    magenta)
      color_code="\033[0;35m"
      ;;
    cyan)
      color_code="\033[0;36m"
      ;;
    *)
      color_code=""
      ;;
  esac
  echo -en "${color_code}${text}\033[0m"
}


function printf_color {
  local color="$1"
  local text="$2"
  printf "$(colorize "$color" "$text")\n"
}
