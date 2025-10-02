### 中心極限定理(ベルヌーイ確率変数の場合)
library(tidyverse)
## パラメーターの設定
p <- 0.1 # 成功確率
mu <- p # 理論上の期待値
sigma <- sqrt(p * (1 - p)) # 理論上の標準偏差
## シミュレーターの作成
mysim <- function(n){ # nはサンプル数
  x <- rbinom(n, size = 1, prob = p) 
  # 成功確率pのBernoulli確率変数を独立にn個生成
  xbar <- mean(x) # 標本平均を計算
  z <- sqrt(n) * (xbar - mu)/sigma # 標本平均を標準化
  return(z) # 計算結果を出力
}
## シミュレーションの実行
set.seed(127) # 乱数の初期値の指定
MC <- 5000 # 各実験の繰り返し回数
## nがそれぞれ100, 1000, 10000の場合にそれぞれ実験を
## MC回実行して, 結果を記録
out1 <- replicate(MC, mysim(100))
out2 <- replicate(MC, mysim(1000))
out3 <- replicate(MC, mysim(10000))
## |z|>2となった割合をそれぞれのサンプル数で計算(理論上は5%に近いはず)
mean(abs(out1) > 2) # n=100のとき
mean(abs(out2) > 2) # n=1000のとき
mean(abs(out3) > 2) # n=10000のとき
## 実験結果をヒストグラムで可視化
## まず, 実験結果をサンプル数nの列とそれに対応する実験結果の列z
## をもつ形式のデータフレームにまとめておく
dat <- tibble(n = rep(c(100,1000,10000), each = MC),
              z = c(out1, out2, out3))
## サンプル数ごとにヒストグラムを作成して結果を比較
obj <- ggplot(dat) +
  geom_histogram(aes(x = z, y = after_stat(density)), 
                 # yをafter_stat(density)に指定することで, 
                 # 縦軸を密度スケールにしている
                 breaks = seq(-3, 3, by = 0.2)) +
  xlab(expression(sqrt(n) * (bar(X)[n] - mu)/sigma)) +
  coord_cartesian(xlim = c(-3, 3)) +
  stat_function(linewidth = 1, fun = dnorm, color = "red")
  # 標準正規密度を上書き
obj + facet_wrap(~ n, nrow = 3, 
                 labeller = labeller(n = label_both))
## アニメーションにしてみる
library(gganimate)
obj + transition_states(n, transition_length = 0.1,
                        state_length = 0.1) # 各結果の(相対的な)表示時間
