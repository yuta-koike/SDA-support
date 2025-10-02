### ポアソン分布のシミュレーション
set.seed(12345) # 乱数の初期値を指定
rpois(10, lambda = 1) # 強度1のポアソン分布に従う乱数を10個発生
rpois(20, lambda = 10) # 強度10のポアソン分布に従う乱数を20個発生
## 統計的性質の確認
lambda <- 10
M <- 10^5 # 乱数を発生させる個数
x <- rpois(M, lambda = lambda)
a <- table(x)/M # 出現確率ごとの表(度数分布表)を作成
y <- as.numeric(names(a)) # xに出現した値の取得
b <- dpois(y, lambda = lambda) # 理論上の出現確率
## 可視化
library(tidyverse) # パッケージのロード
## 適切なデータフレームを準備する
ob <- tibble(xval = y, yval = as.numeric(a), 
             type = rep("観測値", length(y))) # 観測値に対応するデータフレーム
th <- tibble(xval = y, yval = as.numeric(b), 
             type = rep("理論値", length(y))) # 理論値に対応するデータフレーム
dat <- bind_rows(ob, th) # 縦に結合して1つのデータフレームを作成
ggplot(data = dat) +
  geom_col(mapping = aes(x = xval, y = yval, fill = type), 
           # fillをtypeに指定することで, 観測値と理論値のそれぞれで棒グラフを作成できる
           position = "dodge") + # 棒グラフを横に並べて描く
  labs(x = "x", y = "P(X=x)") + # x軸とy軸のラベル名の変更
  scale_fill_manual(name = "", values = c("red", "blue")) 
# 色の変更. nameは凡例の名前で, ここではなしに変更している
