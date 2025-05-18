#!/usr/bin/env bash

show_help() {
  echo "Użycie: $0 [--date] [--logs [N]] [--help]"
}

if [[ "$1" == "--date" ]]; then
  date +"%Y-%m-%d"
  exit 0
fi

