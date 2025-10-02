### 線形制約の検定
### データセットmanufacturing18.csvにコブ・ダグラス型生産関数を
### あてはめて, 収穫一定の仮定が成立するか否か検定する
library(readr)
dat <- read_csv("manufacturing18.csv") # データセットの読み込み
(mod <- lm(log(Q) ~ log(K) + log(L), data = dat)) # 対数線形モデルの推定
library(car) # パッケージのロード
linearHypothesis(mod, "log(K) + log(L) = 1") 
# 収穫一定の仮定の検定(10%水準でも棄却されない)
lht(mod, "log(K) + log(L) = 1") # 上のコマンドの略記法
## 「収穫一定の仮定が成立し, かつA=1」という仮説を検定してみる
lht(mod, c("log(K) + log(L) = 1", "(Intercept) = 0"))
# 1%水準で棄却される
