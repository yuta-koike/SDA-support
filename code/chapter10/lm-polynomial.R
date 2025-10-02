### 多項式回帰
### 渋谷区の中古マンション価格の例
library(tidyverse)
dat <- read_csv("shibuya21.csv") # データの読み込み
ggplot(dat) + geom_point(aes(area, price))
# (area, price)の散布図を描画してみると, priceはareaの二次関数の
# 方がよく説明できそうに見えるので, priceをareaの二乗で回帰してみる
## 比較のためにareaでpriceを回帰した結果を計算しておく
lm(price ~ area, data = dat) |> summary() 
## 説明変数の二次式で回帰
lm(price ~ area + area^2, data = dat) 
# これだとareaのみの回帰となってしまう
lm(price ~ area + I(area^2), data = dat) |> summary() 
# areaの二次式で単回帰
## 関数poly()を使う場合
## 説明変数の直交多項式系を説明変数として回帰することで, 
## 計算結果が安定しやすくなる(多重共線性の問題を回避できる)
lm(price ~ poly(area, 2), data = dat) |> summary() 
# 二次式の作り方が変わるので回帰係数の推定値は変わるが,
# あてはめ値は変わらないので決定係数は変化しない
## あてはまり具合の可視化
ggplot(dat, aes(area, price)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE, # 線形回帰式の上書き
              color = "red", lty = "dashed") + 
  geom_smooth(method = "lm", se = FALSE, # 二次式による回帰式を上書き
              formula = y ~ poly(x,2), color = "blue")
