### 人工データによる判別（２群の場合）
## データの準備
require(MASS) # パッケージのロード
set.seed(123)
mu1 <- c(14,11) # Y=0の場合の特徴量の平均ベクトル
mu2 <- c(13,13) # Y=1の場合の特徴量の平均ベクトル
Sigma <- matrix(c(1,0.7,0.7,1),2,2)*2.5 # 特徴量の共分散行列
n <- 30 # サンプルサイズ
x1 <- mvrnorm(n,mu=mu1,Sigma=Sigma) # 特徴量1
x2 <- mvrnorm(n,mu=mu2,Sigma=Sigma) # 特徴量2
X1 <- cbind(data.frame(x1),data.frame(cat=rep("0",n))) # クラスラベルを付与
X2 <- cbind(data.frame(x2),data.frame(cat=rep("1",n))) # クラスラベルを付与
X <- rbind(X1,X2) # 訓練データ
## 線形判別分析
(mylda1 <- lda(cat ~ X1 + X2, data = X)) 
predict(mylda1)$class # 判別結果
X$cat # 実際の分類
## 表による比較(混同行列と呼ばれる)
table(true = X$cat, pred = predict(mylda1)$class) 
## 判別境界を描画してみる
## 線形判別分析の結果から判別境界の切片と傾きを求める関数
myline <- function(z) { 
  mu <- z$means # クラスごとの特徴量の標本平均ベクトル
  S <- z$scaling # 判別境界の法線ベクトル
  a <- sum(colMeans(mu) * S)/S[2] # 切片
  b <- -S[1]/S[2] # 傾き
  return(c(a, b))
}
mycoef <- myline(mylda1)
library(ggplot2) ## ggplotで描画する
ggplot(X, aes(X1, X2, color = cat, shape = cat)) +
  geom_point() + # データのプロット
  geom_abline(intercept = mycoef[1], slope = mycoef[2]) + # 判別境界
  ggtitle("training data") # グラフタイトル
## 新規データの判別
## 新規データの作成
n1 <- 25
n2 <- 18
x1new <- mvrnorm(n1,mu=mu1,Sigma=Sigma)
x2new <- mvrnorm(n2,mu=mu2,Sigma=Sigma)
X1new <- cbind(data.frame(x1new),data.frame(cat=rep("0",n1)))
X2new <- cbind(data.frame(x2new),data.frame(cat=rep("1",n2)))
Xnew <- rbind(X1new,X2new)
## 新規データのクラスラベルの予測
mypredict1 <- predict(mylda1, newdata = Xnew[,1:2]) # Xnewを判別
mypredict1$class # 予測結果
Xnew$cat # 実際の分類
table(true = Xnew$cat, pred = mypredict1$class) # 表による比較
## 判別境界の描画
ggplot(Xnew, aes(X1, X2, color = cat, shape = cat)) +
  geom_point() +
  geom_abline(intercept = mycoef[1], slope = mycoef[2]) +
  ggtitle("new data") # グラフタイトル
