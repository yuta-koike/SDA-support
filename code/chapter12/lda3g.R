### データセットirisによる例（3群の判別分析にldaを使ってみる）
### あやめの3品種(setosa, versicolor, virginica)について,
### その萼片(Sepal)および花弁(Petal)の幅と長さを記録したデータセット
### 後者の情報から品種を判別することが目的
## 散布図行列(Speciesごとに色分け)
library(GGally)
ggpairs(iris, aes(color = Species), columns = 1:4)
# 品種ごとに花弁・萼片の幅と長さの分布が異なるように見える
# 花弁の方が萼片より品種ごとの違いがある
## データをランダムに2分割して, 一方を訓練データ, 
## もう一方をテストデータとする
set.seed(123)
idx <- sample.int(nrow(iris), size = nrow(iris)/2)
iris.train <- iris[idx, ] # 訓練データ
iris.test <- iris[-idx, ] # テストデータ
library(MASS) # パッケージのロード
## 萼片の長さ・幅を特徴量とする線形判別分析
(mod1 <- lda(Species ~ Sepal.Length + Sepal.Width, data = iris.train))
res1 <- predict(mod1) # 訓練データに対する予測結果
head(res1$class) # 予測されたクラス(最初の6個)
head(iris.train$Species) # 実際のクラス(最初の6個)
table(true = iris.train$Species, pred = res1$class) # 真のクラスと予測されたクラスの比較
# setosaは完全に判別できているが, versicolorとvirginicaの判別に少し誤りがある
pred1 <- predict(mod1, newdata = iris.test) # テストデータに対する予測結果
head(pred1$class) # 予測されたクラス(最初の6個)
head(iris.test$Species) # 実際のクラス(最初の6個)
table(true = iris.test$Species, pred = pred1$class) # 真のクラスと予測されたクラスの比較
# setosaはほぼ判別できているが, versicolorとvirginicaの判別に少し誤りがある
## 花弁の長さ・幅を特徴量とする線形判別分析
(mod2 <- lda(Species ~ Petal.Length + Petal.Width, data = iris.train))
res2 <- predict(mod2) # 訓練データに対する予測結果
head(res2$class) # 予測されたクラス(最初の6個)
head(iris.train$Species) # 実際のクラス(最初の6個)
table(true = iris.train$Species, pred = res2$class) # 真のクラスと予測されたクラスの比較
# ほぼ完全に判別できている(萼片による分類よりよい)
pred2 <- predict(mod2, newdata = iris.test) # テストデータに対する予測結果
head(pred2$class) # 予測されたクラス(最初の6個)
head(iris.test$Species) # 実際のクラス(最初の6個)
table(true = iris.test$Species, pred = pred2$class) # 真のクラスと予測されたクラスの比較
# ほぼ完全に判別できている(萼片による分類よりよい)