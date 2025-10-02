### 正規母集団の平均の区間推定(分散未知)
### 95%信頼区間を多数作成すると, 真の平均が含まれる区間が全体の
### 95%程度となることをモンテカルロ・シミュレーションで確認
set.seed(123) # 乱数の初期値の設定
## パラメータの設定
mu <- 10 # 平均
sigma <- 5 # 標準偏差
## n個の正規標本から標本平均・標準偏差と平均の100(1-alpha)%信頼区間の
## 上端・下端を計算する関数の作成
myest <- function(n, alpha = 0.05){
  
  x <- rnorm(n, mean = mu, sd = sigma) # 正規乱数の生成
  xbar <- mean(x) # 標本平均
  s <- sd(x) # 標準偏差(不偏分散の平方根)
  ui <- xbar + qt(1-alpha/2, df = n - 1) * s/sqrt(n) # 上側信頼限界
  li <- xbar - qt(1-alpha/2, df = n - 1) * s/sqrt(n) # 下側信頼限界
  
  return(c(xbar = xbar, s = s, ui = ui, li = li))
}
## シミュレーションの実行
n <- 5 # データ数
MC <- 10^4 # シミュレーション数
result <- replicate(MC, myest(n)) # MC回実験
## 真の平均muが95%信頼区間に含まれている割合が約95%であることの確認
length(which(mu <= result["ui", ] & mu >= result["li", ]))/MC
## はじめの20個の信頼区間の可視化(geom_errorbarを使用)
library(ggplot2)
ggplot() + 
  geom_errorbar(aes(x = 1:20, # x軸はただの番号
                    ymin = result["li",1:20], # 信頼区間の下端
                    ymax = result["ui",1:20]) # 信頼区間の上端
  ) +
  geom_hline(yintercept = mu, # 真の平均値を水平線で追加
             color = "red", lty = "dashed") +
  labs(x = "")
## sqrt(n)*(xbar-mu)/sが自由度n-1のt分布に従うことの確認
z <- sqrt(n) * (result["xbar", ] - mu)/result["s", ]
ggplot() +
  geom_histogram(aes(z, after_stat(density)), bins = 50) +
  stat_function(fun = \(x) dt(x, df = n - 1), 
                # 自由度n-1のt分布の密度を計算する関数. 
                # \(x)はfunction(x)の略記法  
                color = "red", linewidth = 1,
                n = 1001 # グラフを描くときの折れ線の分割数を増やす
                ) + 
  labs(x = expression(sqrt(n)*(bar(X)-mu)/s),
       title = expression(paste("Histogram of ", sqrt(n)*(bar(X)-mu)/s))) +
  coord_cartesian(xlim = c(-5, 5)) + 
  # 見やすくするためにx軸の範囲をズーム
  stat_function(fun = dnorm, color = "blue", linewidth = 1, 
                lty = "dotted", n = 1001)
  # 標準正規分布との違いを見るため，標準正規分布の密度も上書き
