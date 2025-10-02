### 渋谷区の中古マンション価格の例
### 交絡因子の検証
library(readr)
dat <- read_csv("shibuya21.csv") 
## 散布図行列の描画・相関係数の計算
library(GGally)
ggpairs(dat) 
# minuteとareaに正の相関が若干ある
## minuteとageで回帰した場合
lm(price ~ minute + age, data = dat) |> summary()
# minuteのp値は小さく1%水準で有意
# 交絡因子のareaを説明変数に加えていないので, 
# minuteの回帰係数はareaの効果をまだ含んでいる
# (ただし, ageの効果が排除された分, minuteの回帰係数は
# 若干0に近づいている)
## minuteとareaで回帰した場合
lm(price ~ minute + area, data = dat) |> summary()
# minuteのp値は大きく有意でない
# 交絡因子のareaを説明変数を加えたため, 
# minuteの回帰係数からareaの効果が排除されている
## Frisch-Waugh-Lovell定理の確認
eps.y <- lm(price ~ area + age, data = dat) |> resid()
# minute以外の説明変数でpriceを回帰した残差
eps.x <- lm(minute ~ area + age, data = dat) |> resid()
# minute以外の説明変数でminuteを回帰した残差
coef(lm(eps.y ~ eps.x))[2] 
# すべての説明変数でpriceを回帰したときの
# minuteの回帰係数の推定値と一致