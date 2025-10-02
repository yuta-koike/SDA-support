### 少数の法則
### 1日にn個の製品を生産する工場を考える
### 確率pで不良品が発生するとする
### この工場における1日の不良品の発生数をM日間記録した時の
### 不良品の発生数がポアソン分布で近似できることをみる
set.seed(123) # 乱数の初期値を指定
## データのシミュレーション
n <- 5000 # 1日の総生産量
p <- 2/n # 不良品の発生確率
M <- 5*50*10 # データを記録する日数(週5日x50週間x10年操業に対応)
x <- rbinom(M,n,p) # M日間の各日で発生する不良品数のシミュレーション
## グラフ化による少数の法則の確認
(a <- table(x)/M) # 出現確率ごとの表(度数分布表)を作成
y <- as.numeric(names(a)) # xに含まれる値
(b <- dpois(y, lambda = n*p)) # 理論上の出現確率
library(tidyverse) # パッケージのロード
## 適切なデータフレームを準備する
ob <- tibble(xval = y, yval = as.numeric(a), 
             type = rep("観測値", length(y))) # 観測値に対応するデータフレーム
th <- tibble(xval = y, yval = as.numeric(b), 
             type = rep("理論値", length(y))) # 理論値に対応するデータフレーム
dat <- bind_rows(ob, th) # 縦に結合して1つのデータフレームを作成
ggplot(data = dat) +
  geom_col(mapping = aes(x = xval, y = yval, fill = type), 
           position = "dodge") + # 棒グラフを横に並べて描く
  labs(x = "x", y = "P(X=x)") + # x軸とy軸のラベル名の変更
  scale_fill_manual(name = "", values = c("red", "blue")) 
