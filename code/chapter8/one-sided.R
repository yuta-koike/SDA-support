### 正規母集団の平均に対する仮説検定(片側検定)
### 両側・片側検定それぞれの検出力の比較
### 以下パラメータは適宜設定すること
set.seed(123) # 乱数の初期値の設定
mu <- 0.5 # 平均
sigma <- 1 # 標準偏差
mytest <- function(n, mu0 = 0){
  x <- rnorm(n, mean = mu, sd = sigma)
  p1 <- t.test(x, mu = mu0)$p.value # 両側検定のp値
  p2 <- t.test(x, mu = mu0, alternative = "greater")$p.value # 右側検定のp値
  p3 <- t.test(x, mu = mu0, alternative = "less")$p.value # 左側検定のp値
  return(c(p1, p2, p3))
}
result <- replicate(1000, mytest(5)) # n=5, mu0=0として1000回実験
alpha <- 0.05 # 有意水準
mean(result[1, ] < alpha) # 両側検定の棄却率
mean(result[2, ] < alpha) # 右側検定の棄却率
mean(result[3, ] < alpha) # 左側検定の棄却率
