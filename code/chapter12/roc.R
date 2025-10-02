### ROC曲線の描画とAUCの計算
### パッケージISLR2のデータセットDefaultによる例
library(MASS) 
library(ISLR2)
# install.packages("pROC") # パッケージのインストール(必要な場合)
library(pROC) # パッケージのロード
## データをランダムに2分割して, 一方を訓練データ, 
## もう一方をテストデータとする
set.seed(123)
idx <- sample.int(nrow(Default), size = nrow(Default)/2)
train <- Default[idx, ] # 訓練データ
test <- Default[-idx, ] # テストデータ
## 線形判別分析の場合
out <- lda(default ~ balance, data = train)
pred.lda <- predict(out, test) 
## AUCの計算
p <- pred.lda$posterior[ ,"Yes"] # デフォルト確率
(roc.lda <- roc(test$default, p, direction = "<"))
# directionは, pがどちらのクラスに属する確率の予測値を
# 表しているのか指定している. クラスラベルをRの順序で
# 並べたときに先に来るクラスに属する確率の予測値であれば
# ">"を, あとに来る方であれば"<"を指定する. 
# いまの場合, クラスラベル"No"と"Yes"はアルファベット順に
# 並べ替えられるので"No"が先に来る. pは"Yes"となる確率の
# 予測値だからdirectionには"<"を指定している
## plot=TRUEと指定するとROC曲線を描画する
roc(test$default, p, direction = "<", plot = TRUE)
## ggplotを使ってROC曲線を描画するには関数ggroc()を使う
## デフォルトではx軸を1-FPRにとって1から0の向きにラベル付け
## するので, legacy.axesをTRUE指定してx軸をFPRにとる
roc.lda |> ggroc(legacy.axes = TRUE) +
  geom_abline(color = "red", lty = "dashed") # 45度線の追加
## 2次判別分析の場合
out <- qda(default ~ balance, data = train)
pred.qda <- predict(out, test) 
p <- pred.qda$posterior[ ,"Yes"]
(roc.qda <- roc(test$default, p, direction = "<"))
# AUCはLDAと同じ
## LDAとQDAのROC曲線を重ね書きしてみる
ggroc(list(LDA = roc.lda, QDA = roc.qda)) # 完全に重なっている
## 特徴量をincomeにした場合の結果と比べてみる
out <- lda(default ~ income, data = train)
p <- predict(out, test)$posterior[ ,"Yes"]
(roc.lda2 <- roc(test$default, p, direction = "<"))
ggroc(list(balance = roc.lda, income = roc.lda2),
      legacy.axes = TRUE) +
  geom_abline(lty = "dashed")
