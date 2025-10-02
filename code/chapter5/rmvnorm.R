### 3変量正規乱数のシミュレーション
set.seed(123) # 乱数の初期値の設定
n <- 500 # 生成する乱数の個数
mu <- c(1, 0, -1) # 平均ベクトル
(Sigma <- matrix(c(1, -0.4, -2.1, 
                   -0.4, 4, 3.6, 
                   -2.1, 3.6, 9), nrow = 3)) # 共分散行列
## コレスキー分解による方法
z <- rnorm(3 * n) # 標準正規乱数の生成
z <- matrix(z, 3, n) # 計算しやすくするために行列に変換
A <- t(chol(Sigma)) # Aの計算(転置が必要なことに注意)
x <- mu + A %*% z
x <- t(x) # 標準的なデータ形式に変換
colMeans(x) # muに近い
cov(x) # Sigmaに近い
cov2cor(Sigma) # 理論上の相関行列
cor(x) # 理論上のものに近い
## 可視化: scatterplot3dパッケージを利用
# install.packages("scatterplot3d") パッケージのインストール(必要な場合)
library(scatterplot3d) # パッケージのロード
colnames(x) <- paste0("X", 1:3) # 列名をつけておく
scatterplot3d(x, pch = "x", color = "blue") # 3次元散布図
## 散布図行列による可視化: GGallyパッケージを利用
# install.packages("GGally") # パッケージのインストール(必要な場合)
library(GGally) # パッケージのロード
x |> as.data.frame() |> ggpairs() 
# データフレームに変換してからggpairsに渡して散布図行列を描画
## パッケージMASSの利用
library(MASS)
x <- mvrnorm(n, mu = mu, Sigma = Sigma)
colMeans(x) # muに近い
cov(x) # Sigmaに近い
colnames(x) <- paste0("X", 1:3) # 列名をつけておく
scatterplot3d(x, pch = "x", highlight.3d = TRUE)