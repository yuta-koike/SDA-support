### 正規母集団の分散の比に対する仮説検定
## 以下パラメータは適宜設定すること
set.seed(123) # 乱数の初期値の設定
mu1 <- 5
mu2 <- 8
sigma1 <- 4
sigma2 <- 2
m <- 15
n <- 20
## 帰無仮説が正しい場合
x <- rnorm(m, mean = mu1, sd = sigma1) 
y <- rnorm(n, mean = mu2, sd = sigma1) 
var.test(x, y)
## 帰無仮説が誤りの場合
x <- rnorm(m, mean = mu1, sd = sigma1) 
y <- rnorm(n, mean = mu2, sd = sigma2) 
var.test(x, y) 
## 実験を繰り返した場合の検定の棄却率の確認
mytest <- function(m, n, mu1, mu2, sigma1, sigma2){ 
  
  x <- rnorm(m, mean = mu1, sd = sigma1) 
  y <- rnorm(n, mean = mu2, sd = sigma2) 
  res <- var.test(x, y) 
  f.val <- res$statistic # 検定統計量の値
  p.val <- res$p.value # p値
  
  return(c(f.val, p.val))
}
MC <- 10000 # 実験回数
## 帰無仮説が正しい場合にMC回検定を実行
result <- replicate(MC, mytest(m, n, mu1, mu2, sigma1, sigma1)) 
f1 <- result[1, ] # 検定統計量の値
p1 <- result[2, ] # p値
mean(p1 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p1 < 0.01) # 有意水準1%で棄却された実験の割合
## 帰無仮説が誤りの場合にMC回検定を実行
result <- replicate(MC, mytest(m, n, mu1, mu2, sigma1, sigma2)) 
f2 <- result[1, ] # 検定統計量の値
p2 <- result[2, ] # p値
mean(p2 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p2 < 0.01) # 有意水準1%で棄却された実験の割合
## 検定統計量のヒストグラム
library(ggplot2)
dat <- data.frame(F = c(f1, f2), # 検定統計量
                  ratio = c(rep(1, MC), 
                            rep(sigma1^2/sigma2^2, MC))) # 対応する分散の比
ggplot(dat) +
  geom_histogram(aes(F, after_stat(density)), bins = 50) +
  # x軸の範囲を0<=x<=15にズーム
  coord_cartesian(xlim = c(0, 15)) +
  ## 分散の比ごとに分けて描画
  facet_wrap(~ ratio, nrow = 2,
             labeller = labeller(ratio = label_both)) +
  ## 帰無分布の密度関数の上書き
  stat_function(fun = \(x) df(x, m - 1, n - 1), color = "red",
                n = 1001) +
  ## 棄却域の可視化(有意水準5%)
  geom_vline(aes(xintercept = qf(0.975, m - 1, n - 1)),
             color = "green", lty = "dotted") +
  geom_vline(aes(xintercept = qf(0.025, m - 1, n - 1)),
             color = "green", lty = "dotted") +
  ## 棄却域の可視化(有意水準1%)
  geom_vline(aes(xintercept = qf(0.995, m - 1, n - 1)),
             color = "blue", lty = "dotted") +
  geom_vline(aes(xintercept = qf(0.005, m - 1, n - 1)),
             color = "blue", lty = "dotted")
