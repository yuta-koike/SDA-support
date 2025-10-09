### ヒストグラムの描画
## 気候データによる例
library(tidyverse) # ggplot2, dplyr, readr などをまとめて読み込む
kikou <- read_csv(file="kikou2021.csv",
                  locale=locale(encoding="sjis"))
## 気温のヒストグラム
ggplot(data = kikou) + 
  geom_histogram(mapping = aes(気温)) 

ggplot(kikou) + 
  geom_histogram(mapping=aes(気温),
                 breaks=seq(0, 35, by=2.5), # ビンを0から35まで刻み幅2.5で設定
                 fill="green", # 棒グラフの色
                 colour="black", # 境界の色
                 alpha=0.5) + # 透明度を上げる
  ylab("頻度") # y軸のラベル

## 月別に描画してみる
## そのまま月で分類してしまうと月を連続変数とみなして
## グラデーションで色分けしてしまうので，まずは月を
## 質的データ(区分を表すデータ)と認識させる
kikou <- kikou |> mutate(月=as.factor(月)) 
## as.factor()はデータのクラスをfactor(質的変数)に変換する関数
## パッケージforcatsの関数as_factor()も利用可能
ggplot(kikou) + 
  geom_histogram(mapping = aes(気温, fill = 月))

## もう少し見やすくする
cols <- rainbow(12)[c(8:1,12:9)] # 月ごとのイメージにあうように色を設定
kikou |>
  ggplot(aes(x=気温, fill=月)) + # 月ごとに色を変える
  geom_histogram(alpha=0.5) + # 透明度を上げる
  geom_rug(aes(colour=月)) + # データ点をrug plotで追加
  scale_fill_manual(values=cols) +
  scale_colour_manual(values=cols) +
  labs(y="頻度", title="月ごとの気温の分布")

## 別々のグラフとして表示する
kikou |>
  ggplot(aes(x=気温, fill=月)) + 
  geom_histogram(alpha=0.5, show.legend=FALSE) + 
  scale_fill_manual(values=cols) +
  labs(y="頻度", title="月ごとの気温の分布") +
  facet_wrap(~ 月) # 月ごとの別のグラフを描き並べる
