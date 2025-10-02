## 標準正規確率変数の二乗和の確率分布
set.seed(123) # 乱数の初期値を指定
n <- 10^5
k <- 4
y <- colSums(matrix(rnorm(n*k, 0,1)^2,k,n))
# 標準正規分布に従う乱数をnk個発生し，k個の二乗和をn個作る．
## ヒストグラムの作成と確率密度関数との比較
library(ggplot2) # ggplotを使う
ggplot() + 
  geom_histogram(mapping = aes(y, y = after_stat(density), # y軸を密度表示にする
                               color = "Observed"), 
                 # 凡例をつけるために, color=ラベルの形式で設定しておく
                 fill = "lightblue", # 棒グラフの色
                 bins = 50, # ビンの数
                 ) +
  stat_function(aes(color = "Theoretical"), linewidth = 1, 
                fun = dchisq, args = list(df = k)) + 
  # 密度の上書き. ここでも凡例をつけるためにcolorを設定しておく
  # また，線の太さを調整するためにlinewidthを指定している.
  # argsでfunに与えた関数の追加の引数を指定できる
  scale_color_manual(name = "", 
                     values = c(Observed = "white",
                                Theoretical = "red")) +
  # ヒストグラムの境界線・密度の色の設定. 凡例にも反映される
  coord_cartesian(xlim = c(0, 20)) + # x軸の範囲を0<=x<=20にズーム
  ggtitle(bquote(paste(X[1]^2+cdots+X[k]^2," (" , k==.(k), ")")))
