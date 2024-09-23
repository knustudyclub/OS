#!/bin/bash

# 상위 디렉토리로 이동한 후 Week 01 ~ Week 12 폴더 생성 및 각 내부에 김준형, 윤정훈, 조재용 폴더 생성
# 그리고 각 주차 폴더에 README.md 파일을 생성

for i in $(seq -w 1 12); do
  # 상위 디렉토리로 이동하여 주차 폴더 생성
  mkdir -p "../Week $i/김준형" "../Week $i/윤정훈" "../Week $i/조재용"

  # README.md 파일 생성 및 "## Week 숫자" 내용 추가
  echo "## Week $i" > "../Week $i/README.md"
done


# 실행방법
# chmod +x create_folders.sh
# ./create_folders.sh
