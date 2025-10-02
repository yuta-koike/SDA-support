### 正規母集団の分散に対する仮説検定
### 以下パラメータは適宜設定すること
set.seed(123) # 乱数の初期値の設定
n <- 10 # サンプル数
mu <- 5 # 真の平均
sigma <- 3 # 真の分散
x <- rnorm(10, mean = mu, sd = sigma) # 正規乱数の生成
## 帰無仮説が正しい場合(両側検定)
sigma0 <- sigma
chi2 <- (n - 1) * var(x)/sigma0^2 # 検定統計量
p0 <- pchisq(chi2, df = n - 1)
2 * min(p0, 1 - p0) # p値
## 帰無仮説が誤っている場合(両側検定)
sigma0 <- 2
chi2 <- (n - 1) * var(x)/sigma0^2 # 検定統計量
p0 <- pchisq(chi2, df = n - 1)
2 * min(p0, 1 - p0) # p値
## 実験を繰り返した場合の検定の棄却率の確認
mytest <- function(n, sigma0){ # n個の正規標本から検定統計量の値とp値を計算する関数
  
  x <- rnorm(n, mean = mu, sd = sigma) # 正規乱数の生成
  chi2.val <- (n - 1) * var(x)/sigma0^2 # 検定統計量
  p0 <- pchisq(chi2.val, df = n - 1)
  p.val <- 2 * min(p0, 1 - p0) # p値
  
  return(c(chi2.val, p.val))
}
MC <- 10000 # 実験回数
result <- replicate(MC, mytest(10, sigma0 = sigma)) # n=10, sigma0=sigmaとしてMC回実験
chi21 <- result[1, ] # 検定統計量の値
p1 <- result[2, ] # p値
mean(p1 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p1 < 0.01) # 有意水準1%で棄却された実験の割合
result <- replicate(MC, mytest(10, sigma0 = 2)) # n=10, sigma0=2としてMC回実験
chi22 <- result[1, ] # 検定統計量の値
p2 <- result[2, ] # p値
mean(p2 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p2 < 0.01) # 有意水準1%で棄却された実験の割合
## 検定統計量のヒストグラム
library(ggplot2)
dat <- data.frame(chi2 = c(chi21, chi22), # 検定統計量
                  sigma0 = c(rep(sigma, MC), rep(2, MC))) # 対応するsigma0の値
ggplot(dat) +
  geom_histogram(aes(chi2, after_stat(density)), bins = 50) +
  # x軸のラベルの設定
  xlab(expression(chi^2)) +
  ## sigma0の値ごとに分けて描画
  facet_wrap(~ sigma0, nrow = 2,
             labeller = labeller(sigma0 = label_both)) +
  ## 帰無分布の密度関数の上書き
  stat_function(fun = \(x) dchisq(x, df = n - 1), color = "red",
                n = 1001) +
  ## 棄却域の可視化(有意水準5%)
  geom_vline(aes(xintercept = qchisq(0.975, df = n - 1)),
             color = "green", lty = "dotted") +
  geom_vline(aes(xintercept = qchisq(0.025, df = n - 1)),
             color = "green", lty = "dotted") +
  ## 棄却域の可視化(有意水準1%)
  geom_vline(aes(xintercept = qchisq(0.995, df = n - 1)),
             color = "blue", lty = "dotted") +
  geom_vline(aes(xintercept = qchisq(0.005, df = n - 1)),
             color = "blue", lty = "dotted")
