### ARMA(2,1)モデルのシミュレーション
library(forecast) # グラフィックス用
n <- 1000
a <- c(0.8, -0.64) # ARの係数
b <- -0.5 # MAの係数
## for文で生成する方法
epsilon <- rnorm(n)
x0 <- rnorm(2) # 初期値を乱数で設定
x <- ts(double(n))
x[1:2] <- x0
for(i in 3:n) x[i] <- a %*% x[i - 1:2] + b * epsilon[i - 1] + epsilon[i]
autoplot(x)
ggAcf(x) # 周期性が観察される
ggPacf(x) # 周期成分はほぼ無くなっている
## arima.simで生成する方法(初期値の指定はできない)
## 関数arima.simのノイズはデフォルトでは標準正規列である
y <- arima.sim(list(ar = a, ma = b), n)
autoplot(y)
ggAcf(y)
ggPacf(y)
## ARモデルやMAモデルをarima.simでシミュレーションすることも可能
z <- arima.sim(list(ar = a), n)　# AR(2)モデル
autoplot(z)
ggAcf(z) # 周期性が観察される
ggPacf(z) # ラグ3以降ほぼゼロ
w <- arima.sim(list(ma = b), n)　# MA(1)モデル
autoplot(w)
ggAcf(w) # 1より大きいラグでの自己相関がほぼ消滅
ggPacf(w) # 徐々に減少
