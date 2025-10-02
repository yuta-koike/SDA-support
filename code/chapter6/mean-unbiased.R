### 標本平均の不偏性
## 確率変数Xの期待値E[X]をモンテカルロ・シミュレーション
## によって計算するには, 大数の法則を利用する：
## Xと同じ確率分布に従う乱数をM個発生させて、それらの
## 標本平均を考えると, Mが十分大きければ, その値はE[X]に近い
set.seed(123) # 乱数シードの指定
n <- 3 # サンプル数(この値は大きい必要はない)
M <- 10^4 # モンテカルロ・シミュレーションの回数(大きくなければならない)
res <- replicate(M, mean(runif(n))) 
# 「n個の一様乱数の標本平均」をM回シミュレーションして生成
head(res) # 始めの6個の値(バラバラ)
mean(res) 
# モンテカルロ・シミュレーションによる
# 標本平均の期待値の近似値(0.5に近い)
## グラフ化
library(ggplot2)
ggplot() +
  geom_point(aes(x = 1:M, y = res, color = "1"), 
             pch = 4) + # pch = 4で点の形をxにしている(?points参照)
  labs(x = "", y = expression(bar(X)[n])) +
  geom_hline(aes(yintercept = 0.5, color = "2"), # 真の平均μ=0.5を表す直線を追加
             linetype ="dotted", # 点線で描画
             linewidth = 1) + # 線の幅の指定
  scale_color_manual(name = "", values = c("black", "red"),
                     labels = c(expression(bar(X)[n]), expression(mu)))
## 真の平均0.5の周りをランダムに変動している様子が見て取れる
