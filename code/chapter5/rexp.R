set.seed(20) # 乱数の初期値を指定
rexp(10) # レート1の指数分布に従う乱数を10個発生
## ヒストグラムの作成と確率密度関数との比較
library(ggplot2)
lambda <- 0.5
x <- rexp(10^5, rate = lambda) # レート0.5の指数乱数を10^5個発生
f <- function(x) dexp(x, lambda) # 確率密度関数
ggplot() + 
  geom_histogram(aes(x, y = after_stat(density), # y軸を密度スケールにする
                     color = "観測値"), # 凡例をつけるために, color=ラベルの形式で設定しておく
                 breaks = seq(0, max(x), by = max(x)/50), # ビンを手動で設定
                 fill = "darkgray") + # 棒グラフの色
  stat_function(aes(color = "理論値"), linewidth = 1, fun = f) + 
  # 密度の上書き. ここでも凡例をつけるためにcolorを設定しておく
  # また，線の太さを調整するためにsizeを指定している.
  scale_color_manual(name = "", values = c(観測値="black", 理論値="red")) +
  # 密度の色・ヒストグラムの境界線の設定. 凡例にも反映される
  ggtitle(paste0("指数分布(パラメーター", lambda, ")")) # グラフタイトル
