#!/usr/bin/env bash

show_help() {
  cat <<EOF
Użycie: $0 [--date|-d] [--logs [N]|-l [N]] [--error [N]|-e [N]] [--init] [--help|-h]

  -h, --help            Pokazuje tę pomoc
  -d, --date            Wyświetla dzisiejszą datę w formacie YYYY-MM-DD
  -l, --logs [N]        Tworzy N plików log1.txt…logN.txt (domyślnie 100)
  -e, --error [N]       Tworzy N katalogów errorX z plikiem errorX.txt (domyślnie 100)
      --init            Klонuje repozyторій do подкаталогу и добавляет его в PATH
EOF
}

if [[ $# -eq 0 ]]; then
  show_help
  exit 1
fi

case "$1" in
  --help|-h)
    show_help
    exit 0
    ;;
  --date|-d)
    date +"%Y-%m-%d"
    exit 0
    ;;
  --logs|-l)
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
      count=$2
    else
      count=100
    fi
    for i in $(seq 1 "$count"); do
      fname="log${i}.txt"
      echo "File: $fname"            > "$fname"
      echo "Script: $(basename "$0")" >> "$fname"
      echo "Date: $(date +"%Y-%m-%d")" >> "$fname"
    done
    exit 0
    ;;
  --error|-e)
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
      count=$2
    else
      count=100
    fi
    for i in $(seq 1 "$count"); do
      dir="error${i}"
      file="$dir/error${i}.txt"
      mkdir -p "$dir"
      echo "Error file: $file"         > "$file"
      echo "Script: $(basename "$0")" >> "$file"
      echo "Date: $(date +"%Y-%m-%d")" >> "$file"
    done
    exit 0
    ;;
  --init)
    repo_url=$(git config --get remote.origin.url)
    dir_name=$(basename "$repo_url" .git)
    git clone "$repo_url" "./$dir_name"
    echo "export PATH=\"\$PATH:$(pwd)/$dir_name\"" >> ~/.bashrc
    echo "Repo cloned into ./$dir_name and added to PATH"
    exit 0
    ;;
  *)
    show_help
    exit 1
    ;;
esac
