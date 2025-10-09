### MA(2)モデルのシミュレーション
library(forecast) # グラフィックス用
n <- 1000
b <- c(-0.6, 0.3) # MAの係数
epsilon <- rnorm(n)
x0 <- epsilon[1:2] # 初期値はepsilon1, epsilon2とする
## for文で生成する方法
x <- ts(double(n))
x[1:2] <- x0
for(i in 3:n) x[i] <- b %*% epsilon[i - 1:2] + epsilon[i]
autoplot(x)
ggAcf(x) # 2より大きいラグでの自己相関がほぼ消滅
ggPacf(x) # ラグ4に少しだけ偏自己相関が残っている
## 関数filterを使う方法(こちらの方が速い)
y <- ts(stats::filter(epsilon, filter = c(1, b), method = "c", sides = 1))
# sides=1 はmoving averageを過去の方向にのみ行うことを意味する．
y[1:2] <- epsilon[1:2]
sum(abs(x - y)) # ほぼ0(数値計算上の問題からちょうど0でない)