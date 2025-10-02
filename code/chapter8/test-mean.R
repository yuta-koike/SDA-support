### 正規母集団の平均に対する仮説検定
### 以下パラメータは適宜設定すること
set.seed(123) # 乱数の初期値の設定
n <- 10 # サンプル数
mu <- 10 # 平均
sigma <- 5 # 標準偏差
x <- rnorm(n, mean = mu, sd = sigma) # 正規乱数の生成
t.test(x, mu = mu) # mu0 = muとして検定を実行(帰無仮説は正しい)
t.test(x) # mu0 = 0として検定を実行(帰無仮説は誤り)
## 実験を繰り返した場合の検定の棄却率の確認
mytest <- function(n, mu0 = 0){ # n個の正規標本から検定統計量の値とp値を計算する関数
  
  x <- rnorm(n, mean = mu, sd = sigma) # 正規乱数の生成
  res <- t.test(x, mu = mu0) # t検定の実行
  t.val <- res$statistic # 検定統計量の値
  p.val <- res$p.value # p値
  
  return(c(t.val, p.val))
}
MC <- 10000 # 実験回数
result <- replicate(MC, mytest(n, mu0 = mu)) # n=10, mu0=muとしてMC回実験
t1 <- result[1, ] # 検定統計量の値
p1 <- result[2, ] # p値
mean(p1 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p1 < 0.01) # 有意水準1%で棄却された実験の割合
result <- replicate(MC, mytest(10)) # n=10, mu0=0としてMC回実験
t2 <- result[1, ] # 検定統計量の値
p2 <- result[2, ] # p値
mean(p2 < 0.05) # 有意水準5%で棄却された実験の割合
mean(p2 < 0.01) # 有意水準1%で棄却された実験の割合
## 検定統計量のヒストグラム
library(ggplot2)
dat <- data.frame(t = c(t1, t2), # 検定統計量
                  mu0 = c(rep(mu, MC), rep(0, MC))) # 対応するmu0の値
ggplot(dat) +
  geom_histogram(aes(t, after_stat(density)), bins = 50) +
  # x軸の範囲を-5<=x<=15にズーム
  coord_cartesian(xlim = c(-5, 15)) +
  ## mu0の値ごとに分けて描画  
  facet_wrap(~ mu0, nrow = 2,
             labeller = labeller(mu0 = label_both)) +
  ## 帰無分布の密度関数の上書き
  stat_function(fun = \(x) dt(x, df = n - 1), color = "red",
                n = 1001) +
  ## 棄却域の可視化(有意水準5%)
  geom_vline(aes(xintercept = qt(0.975, df = n - 1)),
             color = "green", lty = "dotted") +
  geom_vline(aes(xintercept = -qt(0.975, df = n - 1)),
             color = "green", lty = "dotted") +
  ## 棄却域の可視化(有意水準1%)
  geom_vline(aes(xintercept = qt(0.995, df = n - 1)),
             color = "blue", lty = "dotted") +
  geom_vline(aes(xintercept = -qt(0.995, df = n - 1)),
             color = "blue", lty = "dotted")
