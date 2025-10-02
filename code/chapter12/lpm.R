### 線形確率モデル
### パッケージISLR2のデータセットDefaultによる例
library(ISLR2) # パッケージのロード
library(ggplot2) # グラフ描画用
## ダミー変数の構築
y <- rep(0, nrow(Default))
y[Default$default == "Yes"] <- 1 
## 線形確率モデルの実行
(out <- lm(y ~ balance, data = Default)) # 線形回帰
yhat <- predict(out) # yの予測値の取得
pred <- ifelse(yhat > 0.5, "Yes", "No") # デフォルト予測
## 実際の分類との比較
table(true = Default$default, predict = pred) # 表による比較(混同行列と呼ばれる)
ggplot(Default, aes(default, yhat)) +
  geom_boxplot(aes(fill = default), show.legend = FALSE) # 箱ひげ図による比較
