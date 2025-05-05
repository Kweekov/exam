#!/bin/bash
mkdir -p ~/.exam/data
cp exam.sh ~/.exam/
cp -r data/* ~/.exam/data/
chmod +x ~/.exam/exam.sh

# Добавим алиас в .bashrc
echo 'alias exam="~/.exam/exam.sh"' >> ~/.bashrc
source ~/.bashrc

echo "Установлено. Используйте команду 'exam <тема>'"