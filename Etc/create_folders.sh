#!/bin/bash

# Week 01 ~ Week 12 폴더 생성 및 각 내부에 김준형, 윤정훈, 조재용 폴더 생성
for i in $(seq -w 1 12); do
  mkdir -p "Week $i/김준형" "Week $i/윤정훈" "Week $i/조재용"
done

# 실행방법
# chmod +x create_folders.sh
# ./create_folders.sh
