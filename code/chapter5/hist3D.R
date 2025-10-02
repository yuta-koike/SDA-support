### 2変量正規乱数の3Dヒストグラム
library(mvtnorm)
library(plot3D)
set.seed(123)　# 乱数の初期値の設定
M <- 10^6 # 乱数の個数
w <- 0.2 # ヒストグラムのビンの幅
bins <- c(-Inf, seq(-3, 3, by = w), Inf) # ビンの区切り点
rand <- rmvnorm(M, sigma = Sigma) # 2変量正規乱数の発生
x_c <- cut(rand[,1], bins) # 各ビン内に含まれるx座標の個数を計算
y_c <- cut(rand[,2], bins)　# 各ビン内に含まれるy座標の個数を計算
z_c <- table(x_c,y_c) # 各ビン内に含まれる乱数の個数
z_c <- z_c/(M*w^2) # 密度スケールに変換
## 3Dヒストグラムの描画
hist3D(z = z_c, border="black", theta = 30, phi = 40, expand = 0.6)
