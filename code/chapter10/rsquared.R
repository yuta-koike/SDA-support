### 渋谷区の中古マンション価格の例
### モデル1: price ~ minute + area + age
### モデル2: price ~ area + age
### モデル3: price ~ area
### の決定係数・自由度調整済み決定係数を比較する
library(readr)
dat <- read_csv("shibuya21.csv") 
mod1 <- lm(price ~ minute + area + age, data = dat) # モデル1の推定
summary(mod1)$r.squared # モデル1の決定係数
summary(mod1)$adj.r.squared # モデル1の自由度調整済み決定係数
mod2 <- lm(price ~ area + age, data = dat) # モデル2の推定
summary(mod2) 
summary(mod2)$r.squared # モデル2の決定係数
# モデル1より(わずかに)小さい
# 変数を1つ減らしたため必ずそうなる
summary(mod2)$adj.r.squared # モデル2の自由度調整済み決定係数
# モデル1より(わずかに)大きい
# minuteを新たにモデルに加えることによる説明力の上昇はほとんどないため
mod3 <- lm(price ~ area, data = dat) # モデル3の推定
summary(mod3)$adj.r.squared
# 自由度調整済み決定係数はモデル2より小さい
# ageがモデルの説明力を上昇させるのに有用であることが示唆される