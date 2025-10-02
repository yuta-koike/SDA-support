### 大数の法則
### 歪みのないサイコロを繰り返し振った際に出る目の平均値が, 
### 理論上の期待値3.5に近づくことを実験で確かめる

## 問題設定
omega <- 1:6 # 出る目の集合
p <- rep(1/6, 6) # 各目の出現確率
(mu <- weighted.mean(omega, p)) # 理論上の期待値(=3.5)

## 実験の開始
set.seed(111) # 乱数の初期値の指定
n <- 1000 # 試行の総回数
x <- sample(omega, size = n, replace = TRUE) 
#「1~6からランダムに1つ数字を選ぶ」という試行をn回繰り返す
# サイコロをn回振って出た目を記録することに対応
xbar <- cumsum(x)/(1:n) # 各回までの標本平均の計算  

## 標本平均の推移のプロット
library(ggplot2)
ggplot() + 
  geom_line(aes(x = 1:n, y = xbar, color = "1")) +
  geom_hline(aes(yintercept = mu, color = "2"), 
             linetype ="dotted", linewidth = 1) + # 理論平均に対応する点線
  ylim(c(0,6)) +
  labs(x = "sample size", y = expression(bar(X)[n]), 
       title = "Law of Large Numbers") +
  scale_color_manual(name = "", values = c("black", "red"),
                     labels = c(expression(bar(X)[n]), expression(mu)))
