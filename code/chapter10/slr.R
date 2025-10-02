### 線形単回帰分析(消費関数の推定による例)
### 経済学者ケインズは, 消費は所得の一次関数で表されると考えて
### 分析を行なった(ケインズ型消費関数と呼ばれる)
### ここでは日本の都道府県・世帯主の性別ごとの消費と(可処分)所得を
### 記録したデータセットkakei19m.csvを用いてケインズ型消費関数を
### 推定してみる
## データの読み込み
library(tidyverse)
(dat <- read_csv("kakei19m.csv"))
x <- dat$可処分所得 # 説明変数の観測データ
y <- dat$消費 # 目的変数の観測データ
(out <- lm(y ~ x)) # 最小二乗法による回帰係数の推定
(b <- coef(out)) # 推定された回帰係数の出力
## データの散布図と回帰直線の図示
ggplot(dat, aes(可処分所得, 消費)) + 
  geom_point() + # 散布図の描画
  geom_abline(intercept = b[1], slope = b[2], # 回帰直線の描画
              color = "red", linewidth = 1) # linewidthは線の太さを指定
## 別のやり方(事前にlmを実行せずにすむ方法)
#ggplot(dat, aes(可処分所得, 消費)) + 
#  geom_point() + 
#  geom_smooth(method = "lm", se = FALSE,
#              color = "red", linewidth = 1)
## データフレームの変数名を指定するやり方
(out2 <- lm(消費 ~ 可処分所得, data = dat)) # outと同じ結果になる
