### ガンマ分布に対するモーメント法
## 観測データからモーメント法による推定量を計算する関数の作成
mom.gamma <- function(x){
  xbar <- mean(x) # 標本平均
  s2 <- var(x) # 不偏分散
  return(c(nu = xbar^2/s2, alpha = xbar/s2))
}
## シミュレーションによる一致性の検証
set.seed(123) # 乱数の初期化
nu0 <- 5
alpha0 <- 2
x <- rgamma(1000, shape = nu0, rate = alpha0)
mom.gamma(x)
## 最尤推定量との推定精度のモンテカルロ法による比較(mle.Rの続き)
## シミュレータの作成
mysim <- function(n, nu, alpha){
  
  x <- rgamma(n, nu, alpha) # 観測データの生成
  res.mle <- mle.gamma(x) # 最尤法
  res.mom <- mom.gamma(x) # モーメント法
  
  return(c(res.mle, res.mom))
}
## シミュレーションの実行
n <- 500 # サンプル数
MC <- 1000 # シミュレーション回数
res <- replicate(MC, mysim(n, nu0, alpha0))
str(res) # はじめの2行が最尤法の結果, 残りの2行がモーメント法の結果
## 推定精度の評価
theta <- c(nu0, alpha0) # 真のパラメータ
## 推定バイアス
rowMeans(res[1:2, ] - theta) # 最尤法
rowMeans(res[-(1:2), ] - theta) # モーメント法
## ルート平均二乗誤差
sqrt(rowMeans((res[1:2, ] - theta)^2)) # 最尤法
sqrt(rowMeans((res[-(1:2), ] - theta)^2)) # モーメント法
