## 正規分布とカイ二乗分布を利用してt分布を生成
library(ggplot2)
set.seed(11111) # 乱数の初期値の設定
n <- 10^5
k <- 7
y <- rchisq(n, df = k) # 自由度7のカイ2乗分布に従う乱数
z <- rnorm(n) # 標準正規乱数
ggplot() + 
  geom_histogram(mapping = aes(z/sqrt(y/k), y = after_stat(density), 
                               color = "Observed"), 
                 fill = "lightblue", bins = 100, 
  ) +
  stat_function(aes(color = "Theoretical"), linewidth = 1, 
                fun = dt, args = list(df = k)) + 
  stat_function(linewidth = 1, fun = dnorm, linetype = "dotted") +
  # 比較のため標準正規分布の密度も点線で上書き
  scale_color_manual(name = "", 
                     values = c(Observed = "white",
                                Theoretical = "red")) +
  ggtitle(bquote(paste(Z/sqrt(Y/k)," (" , k==.(k), ")"))) + 
  coord_cartesian(xlim = c(-5, 5))
