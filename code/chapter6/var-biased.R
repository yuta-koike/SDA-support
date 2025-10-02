## 標本分散が平均的には過小推定となることの確認
set.seed(123) # 乱数の初期値を指定
sample.var <- function(n){ # n個の標準正規乱数の標本分散を計算する関数
  x <- rnorm(n)
  return(mean((x - mean(x))^2))
}
n <- 10 # サンプル数
MC <- 10000 # 実験回数
v <- replicate(MC, sample.var(n)) # sample.var(n)をMC回実行して結果を記録
mean(v) # 1-1/n=0.9に近い(真の分散1を過小推定している)