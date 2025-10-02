### 誤判別率の計算
### 目黒区の中古マンションによる例
### 第3四半期までのデータを用いて構築した判別器によって
### 第4四半期のデータを予測した際の判別性能を評価する
## パッケージのロードとデータの準備
library(MASS) 
library(tidyverse) 
dat <- read_csv("meguro22.csv")
train <- filter(dat, Q < 4)　# 訓練データ
test <- filter(dat, Q == 4) # テストデータ
## 訓練データを用いた判別器の構築
mylda <- lda(renovated ~ price + age, data = train) # LDA
myqda <- qda(renovated ~ price + age, data = train) # QDA
## 訓練データを用いた判別性能の評価
## LDAの場合
res.lda <- predict(mylda, newdata = train) # 予測結果
cm <- table(train$renovated, res.lda$class) # 混同行列
(cm[1,2]+cm[2,1])/nrow(train) # 誤判別率
## QDAの場合
res.qda <- predict(myqda, newdata = train) # 予測結果
cm <- table(train$renovated, res.qda$class) # 混同行列
(cm[1,2]+cm[2,1])/nrow(train) # 誤判別率
## テストデータを用いた判別性能の評価
## LDAの場合
res.lda <- predict(mylda, newdata = test) # 予測結果
cm <- table(test$renovated, res.lda$class) # 混同行列
(cm[1,2]+cm[2,1])/nrow(test) # 誤判別率
## QDAの場合
res.qda <- predict(myqda, newdata = test) # 予測結果
cm <- table(test$renovated, res.qda$class) # 混同行列
(cm[1,2]+cm[2,1])/nrow(test) # 誤判別率
