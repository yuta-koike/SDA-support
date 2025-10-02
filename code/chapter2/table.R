### 質的データの整理(気候データによる例)
library(readr)
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis")) 
## 降水の有無についての度数分布表
table(kikou$降水量 >= 1) 
## 降水日数と月の関係についての分割表
## withはデータフレームの変数名を関数内で参照できるようにするための関数
with(kikou, table(降水量 >= 1, 月))
