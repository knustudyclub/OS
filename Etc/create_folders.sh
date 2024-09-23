#!/bin/bash

# Week 01 ~ Week 12 폴더 생성 및 각 내부에 김준형, 윤정훈, 조재용 폴더 생성
# 그리고 각 주차 폴더에 README.md 파일을 생성
# 각 이름 폴더에 ../Template/Questions Template.md 및 ../Template/Summery Template.md 복사

for i in $(seq -w 1 12); do
  # 주차 폴더 생성
  mkdir -p "../Week $i/김준형" "../Week $i/윤정훈" "../Week $i/조재용"

  # 템플릿 파일을 각 이름 폴더로 복사
  cp ../Template/Questions_Template.md "../Week $i/김준형/"
  cp ../Template/Summery_Template.md "../Week $i/김준형/"

  cp ../Template/Questions_Template.md "../Week $i/윤정훈/"
  cp ../Template/Summery_Template.md "../Week $i/윤정훈/"

  cp ../Template/Questions_Template.md "../Week $i/조재용/"
  cp ../Template/Summery_Template.md "../Week $i/조재용/"
done


# 실행방법
# chmod +x create_folders.sh
# ./create_folders.sh
