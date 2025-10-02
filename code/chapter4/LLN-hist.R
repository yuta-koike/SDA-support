### (LLN.rの続き)
### 上の実験を複数回行ったとき, サンプル数(試行の総回数)が
### 大きければ, 標本平均は実験によらずほとんどの場合に理論
### 平均に近い値を取ることをモンテカルロ・シミュレーションで確認
library(tidyverse)
## シミュレーターの作成
mymean <- function(n){ # nは1回の実験での試行の総回数
  x <- sample(omega, size = n, replace = TRUE) 
  return(mean(x)) 
} 
## シミュレーションの実行
MC <- 1000 # 各実験の繰り返し回数
## nがそれぞれ10, 100, 1000の場合にそれぞれ実験を
## MC回実行して, 標本平均を記録
out1 <- replicate(MC, mymean(10))
out2 <- replicate(MC, mymean(100))
out3 <- replicate(MC, mymean(1000))
## 実験結果を, サンプル数nの列とそれに対応する実験結果の列xbar
## をもつ形式のデータフレームにまとめておく
dat <- tibble(n = rep(c(10,100,1000), each = MC),
              xbar = c(out1, out2, out3))
## サンプル数ごとにヒストグラムを作成して結果を比較
obj <- ggplot(dat) +
  geom_histogram(aes(xbar)) +
  xlab(expression(bar(X)[n])) +
  coord_cartesian(xlim = c(1, 6)) + # x軸を1から6の範囲に固定
  geom_vline(aes(xintercept = mu), linetype ="dotted",
             linewidth = 1, color = "red") 
  # 理論平均に対応する値を赤の垂直破線で追加 
obj + facet_wrap(~ n, # サンプル数ごとに別々にヒストグラムを描く
                 nrow = 3, # 縦に3つ並べる
                 labeller = labeller(n = label_both)) # グラフタイトルにn:を追加
## アニメーションにしてみる
library(gganimate)
obj + transition_states(n)
