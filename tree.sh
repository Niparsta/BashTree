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
            local char="└── "
            local next_p="${prefix}    "
        else
            local char="├── "
            local next_p="${prefix}│   "
        fi

        # Вывод с подкраской: папки синие (\e[34m), файлы обычные (\e[0m)
        if [ -d "$item" ]; then
            echo -e "${prefix}${char}\e[34m${name}\e[0m"
            draw_tree "$item" "$next_p"
        else
            echo -e "${prefix}${char}\e[0m${name}"
        fi
    done
}

# Подсветка корневой папки и запуск рекурсии
echo -e "\e[34m${dir}\e[0m"
draw_tree "$dir" ""
