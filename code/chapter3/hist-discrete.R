### 離散的なデータの頻度分布のグラフ化
### 東京都の新型コロナウイルス感染者の属性データによる例
### データセットcovid19attr.csv
### 東京都の新型コロナウイルス感染症対策サイトより取得(現在は閉鎖)
### 2020年3月から12月までの東京都の新型コロナウイルス感染者の
### 公表月・日・曜日, 年代(何歳台か), 性別を記録したデータセット
### 年代または性別が不明なデータは削除してある
## 年代の頻度分布をグラフ化してみる
library(tidyverse) # ggplot2, dplyr, readr などをまとめて読み込む
covid <- read_csv("covid19attr.csv") # データの読み込み
str(covid) # データの構造の確認
## 年代の頻度分布を棒グラフで表示
ggplot(covid) + 
  geom_bar(aes(年代))
## 性別ごとに分けて描画してみる
covid |> 
  mutate(年代 = as.factor(年代)) |> 
  # 年代を質的データに変更. x軸の目盛りが見やすくなる
  ggplot() + 
  geom_bar(aes(年代, 
               y = after_stat(count/max(count)), # y軸を割合にする
               fill = 性別), # 性別ごとにグラフを作成
           position = "dodge") + # グラフを横に並べる
  ylab("割合") # y軸のラベルを変更