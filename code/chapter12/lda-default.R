### 線形判別分析
### パッケージISLR2のデータセットDefaultによる例
## パッケージのロード
library(MASS) # lda用
library(ISLR2) # データセット用
library(ggplot2) # プロット用
## 線形判別分析の実行
(out <- lda(default ~ balance, data = Default)) # 線形判別分析
result <- predict(out) # 予測結果
pred <- result$class # クラス判別の予測結果
## 実際の分類との比較
## 表による比較(混同行列と呼ばれる)
table(true = Default$default, predict = pred) 
## 箱ひげ図によるデフォルト確率の予測値の可視化
phat <- result$posterior[ ,"Yes"] # デフォルト確率の予測値
ggplot(Default, aes(default, phat)) +
  geom_boxplot(aes(fill = default), show.legend = FALSE) 
## 判別スコア(判別関数の値)の可視化
plot(out) 
### default以外のすべての変数を用いる場合, lmと同様に
### lda(default ~ ., data = Default)を実行すればよい