### ベルヌーイの大数の法則
### 確率pで起きる事象Aを多数回独立に繰り返すと, 事象Aが
### 起きる回数の占める割合がpに近づいていくことを確認 
## シミュレーターの作成
mysim <- function(n){ # nは実験の総回数
  x <- rbinom(n, 1, p) 
  # n回試行を繰り返し, 事象Aが起きたら1, 起きなかったら0を記録
  R <- cumsum(x) # 各回までに事象Aが起きた総数を計算
  out <- R/(1:n) # 各回までに事象Aが起きた割合を計算
  return(out)
}
## 実験の開始
set.seed(123) # 乱数の初期値の指定
p <- 0.5 # 事象が起きる確率
result <- mysim(1000) # 実験
## 可視化
library(ggplot2) # ggplotを使って描画する
ggplot() + 
  geom_line(aes(x = 1:1000, y = result, color = "1")) +
  geom_hline(aes(yintercept = p, color = "2"), linetype ="dotted",
             linewidth = 1) +
  ylim(c(0,1)) +
  labs(x = "N", y = expression(R[N]/N), 
       title = "Bernoulli's Law of Large Numbers") +
  scale_color_manual(name = "", values = c("black", "red"),
                     labels = c(expression(R[N]/N), expression(p)))
