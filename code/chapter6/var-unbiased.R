## 不偏分散が不偏推定量となることの確認
set.seed(123) # 乱数の初期値を指定
unbiased.var <- function(n){ # n個の標準正規乱数の不偏分散を計算する関数
  x <- rnorm(n)
  return(var(x))
}
n <- 10 # サンプル数
MC <- 10000 # 実験回数
v <- replicate(MC, unbiased.var(n)) # unbiased.var(n)をMC回実行して結果を記録
mean(v) # 1に近い
mean(sqrt(v)) # 不偏分散の平方根は真の標準偏差1を過小推定している