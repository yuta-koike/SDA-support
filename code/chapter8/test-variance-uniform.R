### 一様母集団の分散に対する仮説検定
### 正規母集団の場合の方法と平均の検定の問題に帰着させる方法の
### それぞれについてパフォーマンスを比較する
## シミュレーターの作成
mytest <- function(n, sigma0){ # n個の一様乱数から検定統計量の値とp値を計算する関数
  
  x <- runif(n) # 一様乱数の生成
  ## 正規母集団の場合の方法の検定統計量とp値の計算
  chi2.val <- (n - 1) * var(x)/sigma0^2 # 検定統計量
  p0 <- pchisq(chi2.val, df = n - 1)
  p.val1 <- 2 * min(p0, 1 - p0) # p値
  ## 平均の検定の問題に帰着させる方法の検定統計量とp値の計算
  y <- (x - mean(x))^2 # 平均からの偏差を二乗したデータの作成
  res <- t.test(y, mu = sigma0^2) # t検定の実行
  t.val <- res$statistic # 検定統計量の値
  p.val2 <- res$p.value # p値
  
  return(c(chi2.val, p.val1, t.val, p.val2))
}
## シミュレーションの設定
set.seed(123) # 乱数の初期値の設定
n <- 500 # サンプル数
MC <- 10000 # 実験回数
sigma0 <- sqrt(1/12) # 区間(0,1)上の一様分布の標準偏差
## シミュレーションの実行
result <- replicate(MC, mytest(n, sigma0 = sqrt(1/12)))
## 正規母集団の場合の方法の検定統計量とp値
t1 <- result[1, ] # 検定統計量の値
p1 <- result[2, ] # p値
## 平均の検定の問題に帰着させる方法の検定統計量とp値
t2 <- result[3, ] # 検定統計量の値
p2 <- result[4, ] # p値
## いまの設定では帰無仮説は正しいため, 帰無仮説が棄却される割合は
## 有意水準程度でなければいけないため, それを確認する
## 正規母集団の場合の方法
mean(p1 < 0.05) # 5%よりかなり小さい
mean(p1 < 0.01) # 1%よりかなり小さい
## 平均の検定の問題に帰着させる方法の場合
mean(p2 < 0.05) # 5%に近い
mean(p2 < 0.01) # 1%に近い
## 検定統計量のヒストグラム
library(ggplot2)
## 正規母集団の場合の方法
ggplot() +
  geom_histogram(aes(t1, after_stat(density)), bins = 50) +
  # x軸のラベルの設定
  xlab(expression(chi^2)) +
  ## 帰無分布の密度関数の上書き
  stat_function(fun = \(x) dchisq(x, df = n - 1), color = "red",
                n = 1001) 
## 平均の検定の問題に帰着させる方法
ggplot() +
  geom_histogram(aes(t2, after_stat(density)), bins = 50) +
  # x軸のラベルの設定
  xlab(expression(t)) +
  ## 帰無分布の密度関数の上書き
  stat_function(fun = \(x) dt(x, df = n - 1), color = "red",
                n = 1001) 
