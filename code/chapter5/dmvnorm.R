### パッケージmvtnormによる2変量正規分布の密度の描画
## パッケージのインストール(必要な場合)
# install.packages("mvtnorm") 
# install.packages("plot3D") # 3Dプロット用
## パッケージのロード
library(mvtnorm)
library(plot3D)
R <- 0.5
Sigma <- matrix(c(1,R,R,1),2,2)
f <- function(x, y) dmvnorm(cbind(x,y), sigma = Sigma)
x <- seq(-3, 3, length=51) # x座標の定義域の分割
y <- seq(-3, 3, length=51) # y座標の定義域の分割
z <- outer(x, y, f) # z座標の計算
## 密度の描画
persp3D(x, y, z, theta = 30, phi = 40, expand = 0.6, 
        border = "black",
        main = paste0("2変量正規分布の密度(相関係数",R,")"))