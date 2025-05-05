#!/bin/bash

# 1. Удаляем директорию со шпаргалками
rm -rf ~/.exam

# 2. Удаляем алиас из .bashrc
sed -i '/alias exam=/d' ~/.bashrc

# 3. Удаляем строки из ~/.bash_history и текущей истории
KEYWORDS=("exam" "install.sh" "exdel" "git clone" "cd exam" "bash install.sh" "rm -rf ~/.exam")

# Очищаем из истории в памяти
for word in "${KEYWORDS[@]}"; do
  while read -r num; do
    history -d "$num" 2>/dev/null
  done < <(history | grep "$word" | awk '{print $1}')
done

# Очищаем ~/.bash_history на диске
cp ~/.bash_history ~/.bash_history.bak
grep -v -e "exam" -e "install.sh" -e "exdel" -e "git clone" -e "cd exam" -e "bash install.sh" -e "rm -rf ~/.exam" ~/.bash_history.bak > ~/.bash_history
rm ~/.bash_history.bak

# Применяем новую историю
history -c
history -r

echo "[exdel] Всё удалено. Следов не осталось."