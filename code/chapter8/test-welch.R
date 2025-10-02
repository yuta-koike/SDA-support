### 正規母集団の平均の差に対する仮説検定(一般の場合)
## 以下パラメータは適宜設定すること
set.seed(123) # 乱数の初期値の設定
mu1 <- 5
mu2 <- 7.5
sigma1 <- 1
sigma2 <- 2
m <- 8
n <- 12
## 帰無仮説が正しい場合
x <- rnorm(m, mean = mu1, sd = sigma1) 
y <- rnorm(n, mean = mu1, sd = sigma2) 
t.test(x, y) # ウェルチのt検定を実行
## 帰無仮説が誤りの場合
x <- rnorm(m, mean = mu1, sd = sigma1) 
y <- rnorm(n, mean = mu2, sd = sigma2) 
t.test(x, y) # ウェルチのt検定を実行
## 実験を繰り返した場合の検定の棄却率の確認
mytest <- function(m, n, mu1, mu2, sigma1, sigma2){ 
  
  x <- rnorm(m, mean = mu1, sd = sigma1) 
  y <- rnorm(n, mean = mu2, sd = sigma2) 
  res <- t.test(x, y) # Welchのt検定を実行
  t.val <- res$statistic # 検定統計量の値
  p.val <- res$p.value # p値
  
  return(c(t.val, p.val))
}
MC <- 10000 # 実験回数
## 帰無仮説が正しい場合にMC回検定を実行
result <- replicate(MC, mytest(m, n, mu1, mu1, sigma1, sigma2)) 
t1 <- result[1, ] # 検定統計量の値
p1 <- result[2, ] # p値
mean(p1 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p1 < 0.01) # 有意水準1%で棄却された実験の割合
## 帰無仮説が誤りの場合にMC回検定を実行
result <- replicate(MC, mytest(m, n, mu1, mu2, sigma1, sigma2)) 
t2 <- result[1, ] # 検定統計量の値
p2 <- result[2, ] # p値
mean(p2 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p2 < 0.01) # 有意水準1%で棄却された実験の割合
## 検定統計量のヒストグラム
library(ggplot2)
dat <- data.frame(t = c(t1, t2), # 検定統計量
                  difference = c(rep(0, MC), 
                                 rep(mu1 - mu2, MC))) # 対応する平均の差
## 帰無分布の自由度の理論値を計算しておく
a <- sigma1^2/m
b <- sigma2^2/n
nu <- (a + b)^2/(a^2/(m-1) + b^2/(n-1)) # 自由度の理論値
## グラフの描画
ggplot(dat) +
  geom_histogram(aes(t, after_stat(density)), bins = 50) +
  # x軸の範囲を-10<=x<=5にズーム
  coord_cartesian(xlim = c(-10, 5)) +
  ## 平均の差ごとに分けて描画  
  facet_wrap(~ difference, nrow = 2,
             labeller = labeller(difference = label_both)) +
  ## 帰無分布の密度関数の上書き
  stat_function(fun = \(x) dt(x, df = nu), color = "red",
                n = 1001) +
  ## 棄却域の可視化(有意水準5%)
  geom_vline(aes(xintercept = qt(0.975, df = nu)),
             color = "green", lty = "dotted") +
  geom_vline(aes(xintercept = -qt(0.975, df = nu)),
             color = "green", lty = "dotted") +
  ## 棄却域の可視化(有意水準1%)
  geom_vline(aes(xintercept = qt(0.995, df = nu)),
             color = "blue", lty = "dotted") +
  geom_vline(aes(xintercept = -qt(0.995, df = nu)),
             color = "blue", lty = "dotted")
