### 誤判別率の計算
### パッケージISLR2のデータセットDefaultによる例
library(MASS) 
library(ISLR2)
## データをランダムに2分割して, 一方を訓練データ, 
## もう一方をテストデータとする
set.seed(123)
idx <- sample.int(nrow(Default), size = nrow(Default)/2)
train <- Default[idx, ] # 訓練データ
test <- Default[-idx, ] # テストデータ
## 線形判別分析の場合
out <- lda(default ~ balance, data = train)
pred.lda <- predict(out, test) # テストデータでの予測結果
## 誤判別率は混同行列の非対角成分の総和を
## サンプル数で割れば計算できる
cm <- table(test$default, pred.lda$class) # 混同行列
(cm[1,2]+cm[2,1])/nrow(test) # 誤判別率
## 2次判別分析の場合
out <- qda(default ~ balance, data = train)
pred.qda <- predict(out, test) 
cm <- table(test$default, pred.qda$class) 
(cm[1,2]+cm[2,1])/nrow(test) # 誤判別率
