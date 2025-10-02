### 二項分布のシミュレーション
set.seed(123) # 乱数の初期値を指定
rbinom(10, size = 1, prob = 0.5) # ベルヌーイ分布のシミュレーション
rbinom(10, size = 1, prob = 0.2) # 成功確率を小さくしてみる
rbinom(20, size = 5, prob = 0.6) # 20個の二項分布のシミュレーション
## 統計的性質の確認
n <- 9
p <- 0.6
M <- 10^5 # 乱数を生成する個数
x <- rbinom(M, size = n, prob = p)
(a <- table(x)/M) # # 出現確率ごとの表(度数分布表)を作成
y <- as.numeric(names(a)) # xに出現した値の取得
(b <- dbinom(y, size = n, prob = p)) # 理論上の出現確率
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