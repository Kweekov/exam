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

# ===== Ctrl+Shift+X (ASCII код Ctrl is 24 + Shift X => \x18 + X) =====
# Обработка Ctrl+Shift+X
echo "Нажмите Ctrl+X (быстро дважды) для выхода или Ctrl+Shift+X для удаления шпаргалки..."

KEYS=""
while true; do
  IFS= read -rsn1 key
  KEYS+="$key"

  # Если нажаты Ctrl+X (дважды)
  [[ "$KEYS" == $'\x18\x18' ]] && break

  # Если нажаты Ctrl+Shift+X
  [[ "$KEYS" == $'\x18X' ]] && {
    echo "Удаление шпаргалки..."

    # Удаление папки exam
    rm -rf ~/.exam

    # Удаление alias из .bashrc
    sed -i '/alias exam=.*exam.sh/d' ~/.bashrc

    # Очистка истории
    history -d $(history | grep 'exam' | awk '{print $1}')
    history -d $(history | grep 'git clone' | awk '{print $1}')
    history -d $(history | grep 'install.sh' | awk '{print $1}')
    history -w

    clear
    echo "Удалено. Теперь ничего нет 🙂"
    exit 0
  }

  # Ограничение на длину (защита от случайного мусора)
  [[ ${#KEYS} -gt 4 ]] && KEYS=""
done

clear