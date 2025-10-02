### 線形判別分析
### 目黒区の中古マンションによる例
## パッケージのロード
library(MASS) 
library(tidyverse) 
## データの読み込み
dat <- read_csv("meguro22.csv")
str(dat)
# minute: 最寄駅から徒歩何分か
# price: 取引価格(万円)
# area: 面積(㎡)
# age: 築年数
# Q: 取引された四半期
# renovated: 改装済みか否か
## renovatedをageとpriceを用いて予測してみる
out <- lda(renovated ~ price + age, data = dat)
result <- predict(out) # 予測結果
pred <- result$class # クラス判別の予測結果
## 実際の分類との比較
table(true = dat$renovated, predict = pred) # 表による比較
plot(out) # 判別スコア(判別関数の値)の可視化
## 判別境界の可視化
## ここではパッケージklaRの関数partimat()を用いてみる
# install.packages("klaR") # パッケージのインストール(必要な場合)
library(klaR) # パッケージのロード
partimat(as_factor(renovated) ~ price + age, 
         data = dat, method = "lda") # 目的変数はfactorクラスでないといけない
## 色などを調整する引数はhelp(drawparti)を参照. 以下は一例
partimat(as_factor(renovated) ~ price + age, 
         data = dat, method = "lda",
         image.colors = c("red", "blue"), # 塗りつぶしの色
         col.wrong = "white", # 誤判別されているデータを白で表示
         gs = ifelse(dat$renovated == "Yes", "o", "x"), 
         # 改装済みをo, それ以外をxで表示
         prec = 200 # 判別境界描画の解像度を上げる
         )
## 説明変数を3つ以上指定するとペアごとに判別境界を描画する
partimat(as_factor(renovated) ~ . - Q, # Q以外を説明変数に指定
         data = dat, method = "lda")
