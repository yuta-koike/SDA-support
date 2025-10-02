### 棒グラフの描画
## 気候データによる例
library(tidyverse)
kikou <- read_csv(file="kikou2021.csv",locale=locale(encoding="sjis")) |>
  mutate(月 = as_factor(月)) # 月を質的変数に変換しておく
## 月ごとの平均気温の棒グラフを描画
kikou |>
  group_by(月) |>
  summarise(気温 = mean(気温)) |> # ここまで月ごとの平均気温の計算
  ggplot() +
  geom_col(aes(月, 気温, fill = 月)) + # 月で色分け
  scale_fill_manual(values = rainbow(12)[c(8:1,12:9)]) # 色分けを手動で決定
## 東京都の新型コロナウイルス感染者の属性データによる例
covid <- read_csv("covid19attr.csv") |>
  mutate(年代 = as_factor(年代)) # 年代を質的変数に変換しておく
## 性別ごとの年代の度数分布表を作成
dat <- covid |> 
  group_by(性別, 年代) |> # 性別と年代で分類
  summarise(度数 = n()) # グループごとにデータ数をカウント
## 性別ごとに年代の棒グラフを作成
ggplot(dat) +
  geom_col(aes(年代, 度数, fill = 性別),
           # fillを性別に指定することで, 性別ごとに棒グラフを作成
           position = "dodge") # 棒グラフを横に並べて描く