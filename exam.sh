#!/bin/bash

TOPIC="$1"
FILE="data/${TOPIC}.txt"

if [[ ! -f "$FILE" ]]; then
  echo "Тема '$TOPIC' не найдена."
  exit 1
fi

# Сохраняем текущую командную историю, чтобы не спалиться
history -a

# Выводим инструкцию и ловим Ctrl+X (ASCII 24)
clear
cat "$FILE"
echo
echo "Нажмите Ctrl+X чтобы очистить шпору..."

while true; do
  IFS= read -rsn1 key
  [[ $key == $'\x18' ]] && break
done

clear