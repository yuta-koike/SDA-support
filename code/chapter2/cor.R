### 相関係数(気候データによる例)
library(tidyverse)
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis")) 
cor(kikou$気温, kikou$日射量) # 気温と日射量の相関係数
cor(kikou[ ,-(1:2)]) # 全変数間の相関行列(月日は除く)
## Rのデフォルトのパイプ演算子|>を使った書き方
kikou |> select(-c(月, 日)) |> cor()
## 相関がないがデータ間に関係がある例
x <- (-5):5
cor(x, x^2) # xとx^2は二次関数の関係にあるが, 相関は0
