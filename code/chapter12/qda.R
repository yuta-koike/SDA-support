library(MASS) # パッケージのロード
## 人工データによる例(2群の場合)
set.seed(123)
mu1 <- c(14,11)
mu2 <- c(13,13)
Sigma1 <- matrix(c(1,0.7,0.7,1),2,2)*2.5
Sigma2 <- matrix(c(1,-0.3,-0.3,1),2,2)*0.5
n <- 30
x1 <- mvrnorm(n,mu=mu1,Sigma=Sigma1)
x2 <- mvrnorm(n,mu=mu2,Sigma=Sigma2)
X1 <- cbind(data.frame(x1),data.frame(cat=rep("0",n)))
X2 <- cbind(data.frame(x2),data.frame(cat=rep("1",n)))
X <- rbind(X1,X2)
## データのプロット
library(ggplot2) 
ggplot(X, aes(X1, X2, color = cat, shape = cat)) +
  geom_point() 
## 分析の開始：
(myqda1 <- qda(cat~X1+X2,X)) # トレーニングデータで判別関数を作る
## 新しいデータを判別する：
n1 <- 25
n2 <- 18
x1new <- mvrnorm(n1,mu=mu1,Sigma=Sigma1)
x2new <- mvrnorm(n2,mu=mu2,Sigma=Sigma2)
X1new <- cbind(data.frame(x1new),data.frame(cat=rep("0",n1)))
X2new <- cbind(data.frame(x2new),data.frame(cat=rep("1",n2)))
Xnew <- rbind(X1new,X2new)
mypredict1<-predict(myqda1, newdata = Xnew[,1:2]) # Xnewを判別
table(true = Xnew$cat, pred = mypredict1$class) # 真のクラスと予測されたクラスの比較
mypredict1$class # 予測を真の分類と比較：
Xnew$cat 
ggplot(Xnew, aes(X1, X2, color = cat, shape = cat)) +
  geom_point() # データのプロット
## 比較のためldaも実行
(mylda1 <- lda(cat~X1+X2,X))
mypredict1<-predict(mylda1, newdata = Xnew[,1:2]) # Xnewを判別
table(true = Xnew$cat, pred = mypredict1$class) # 真のクラスと予測されたクラスの比較
mypredict1$class # 予測を真の分類と比較：
Xnew$cat 