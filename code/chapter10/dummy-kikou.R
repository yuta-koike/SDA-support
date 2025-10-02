### ダミー変数(気候データによる例)
### 2021年の東京における降水の有無と気温の関係を調べる
## データの読み込み
library(tidyverse)
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis"))
## 降水の有無を表す変数をデータフレームに追加
kikou <- mutate(kikou, 降水の有無 = as_factor(降水量 >= 1)) 
lm(気温 ~ 降水の有無, data = kikou) |> summary() 
# 雨の日の方が気温が高いという結果(1%水準で有意)
## 東京では冬より夏の方が降水が多いことを考慮して, 
## 月を表すダミー変数を追加する
kikou <- mutate(kikou, 月 = as_factor(月))
lm(気温 ~ 降水の有無 + 月, data = kikou) |> summary()
# 雨の日の方が気温が低いという結果(0.1%水準で有意)
# はじめの結果では「月」が交絡因子となっていた