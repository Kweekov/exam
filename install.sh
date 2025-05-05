#!/bin/bash
mkdir -p ~/.exam/data
cp exam.sh ~/.exam/
cp -r data/* ~/.exam/data/
chmod +x ~/.exam/exam.sh

cp exdel.sh ~/.exam/exdel.sh
chmod +x ~/.exam/exdel.sh
echo 'alias exdel="~/.exam/exdel.sh"' >> ~/.bashrc

# Добавим алиас в .bashrc
echo 'alias exam="~/.exam/exam.sh"' >> ~/.bashrc
source ~/.bashrc

echo "Установлено. Используйте команду 'exam <тема>'"