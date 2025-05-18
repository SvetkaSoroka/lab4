#!/usr/bin/env bash

show_help() {
  cat <<EOF
Użycie: $0 [--date] [--logs [N]] [--help]

  --date       Wyświetla dzisiejszą datę
  --logs [N]   Tworzy N plików log1.txt…logN.txt
  --help       Pokazuje tę pomoc
EOF
}

if [[ "$1" == "--date" ]]; then
  date +"%Y-%m-%d"
  exit 0
fi

if [[ "$1" == "--logs" ]]; then
  if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
    count=$2
  else
    count=100
  fi

  for i in $(seq 1 $count); do
    fname="log${i}.txt"
    echo "File: $fname" > "$fname"
    echo "Script: $(basename "$0")" >> "$fname"
    echo "Date: $(date +"%Y-%m-%d")" >> "$fname"
  done
  exit 0
fi

if [[ "$1" == "--help" ]]; then
  show_help
  exit 0
fi

show_help
exit 1
