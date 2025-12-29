#!/bin/bash

# Путь из аргумента или текущий по умолчанию
dir="${1:-.}"

# Проверка на существование директории
[ ! -d "$dir" ] && echo "Error: directory not found" && exit 1

draw_tree() {
    local path="$1"
    local prefix="$2"
    local items=("$path"/*)

    # Выход, если папка пуста
    [ ! -e "${items[0]}" ] && return

    local total=${#items[@]}
    local n=0

    for item in "${items[@]}"; do
        ((n++))
        local name=$(basename "$item")

        # Выбор символа для ветки - последний элемент или нет
        if [ "$n" -eq "$total" ]; then
            echo "${prefix}└── $name"
            local next_p="${prefix}    "
        else
            echo "${prefix}├── $name"
            local next_p="${prefix}│   "
        fi

        # Рекурсия, если это папка
        [ -d "$item" ] && draw_tree "$item" "$next_p"
    done
}

echo "$dir"
draw_tree "$dir" ""
