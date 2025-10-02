### 四半期データを用いた消費関数の推定による例
### データセットconsumption.csv
### 内閣府の2019年度国民経済計算のデータより作成
### https://www.esri.cao.go.jp/jp/sna/data/data_list/kakuhou/files/2019/2019_kaku_top.html
### YEAR: 年
### Q: 四半期を表す質的変数
### RC: 実質民間最終消費支出
### RYD: 実質国民総可処分所得
### 消費行動には季節性があるので, その調整のために消費関数の
### 推定の際には通常はQも説明変数に含める
### ここでは, Qが本当に必要か否か関数anova()を用いて検証してみる
library(readr)
dat <- read_csv("consumption.csv") # データの読み込み
str(dat) # データの構造(QはQ1からQ4の4つのカテゴリーを持つ)
mod0 <- lm(RC ~ RYD, data = dat) # Qを加えない場合の推定結果
mod1 <- lm(RC ~ RYD + Q, data = dat) # Qを加えた場合の推定結果
anova(mod0, mod1) # p値は非常に小さくQは必要だとわかる
summary(mod1) 
# 個々の回帰係数の推定結果を見てもいくつかのダミー変数が有意となっている