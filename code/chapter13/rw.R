### ランダムウォークのシミュレーション
library(forecast) # グラフィックス用
n <- 1000
x0 <- 1 # 初期値
epsilon <- rnorm(n-1)
## for文によって生成する方法
x <- ts(double(n))
x[1] <- x0
for(i in 2:n) x[i] <- x[i-1] + epsilon[i-1]
autoplot(x)
ggAcf(x) # 自己相関がなかなか減衰しない
ggPacf(x) # ラグ2以降ほぼゼロ
## 関数diffinvを使う方法(こちらの方が速い)
y <- ts(diffinv(epsilon, xi = x0))
sum(abs(x - y)) # x と y は全く同じ系列
