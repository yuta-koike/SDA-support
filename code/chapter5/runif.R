### 一様分布のシミュレーション
set.seed(1) # 乱数の初期値を指定
runif(10) # 区間(0,1)上の一様乱数を10個発生
## ヒストグラムの作成と確率密度関数との比較
library(ggplot2) # ggplotでヒストグラムを描画
a <- -1
b <- 2
x <- runif(10^5, min = a, max = b)
f <- function(x) dunif(x, a, b) # 確率密度関数
ggplot() + 
  geom_histogram(aes(x, y = after_stat(density), # y軸を密度スケールにする
                     color = "観測値"), # 凡例をつけるために, color=ラベルの形式で設定しておく
                 breaks = seq(a, b, by = (b - a)/20), # ビンを手動で設定
                 fill = "darkgray") + # 棒グラフの色
  stat_function(aes(color = "理論値"), fun = f) + 
  # 密度の上書き. ここでも凡例をつけるためにcolorを設定しておく
  scale_color_manual(name = "", values = c(観測値="black", 理論値="red")) +
  # ヒストグラムの境界線・密度の色の設定. 凡例にも反映される
  ggtitle(paste0("区間(", a, ",", b, ")上の一様分布")) # グラフタイトル
