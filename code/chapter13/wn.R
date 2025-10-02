### ホワイトノイズのシミュレーション
library(forecast) # グラフィックス用
set.seed(100)
n <- 1000 # 時系列の長さ
x <- ts(rnorm(n)) # 正規分布の場合
autoplot(x)
ggAcf(x) # ほぼゼロ
ggPacf(x) # ほぼゼロ
y <- ts(rt(n, df = 4)) # 自由度4のt分布の場合
autoplot(y)
ggAcf(y) # ほぼゼロ
ggPacf(y) # ほぼゼロ
