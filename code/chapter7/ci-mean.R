### 正規母集団の平均の区間推定(分散既知)
### 95%信頼区間を多数作成すると, 真の平均が含まれる区間が全体の
### 95%程度となることをモンテカルロ・シミュレーションで確認
set.seed(123) # 乱数の初期値の設定
## パラメータの設定
mu <- 10 # 平均
sigma <- 5 # 標準偏差
## n個の正規標本から標本平均と平均の100(1-alpha)%信頼区間の
## 上端・下端を計算する関数の作成
myest <- function(n, alpha = 0.05){
  
  x <- rnorm(n, mean = mu, sd = sigma) # 正規乱数の生成
  xbar <- mean(x) # 標本平均
  ui <- xbar + qnorm(1-alpha/2) * sigma/sqrt(n) # 上側信頼限界
  li <- xbar - qnorm(1-alpha/2) * sigma/sqrt(n) # 下側信頼限界
  
  return(c(xbar = xbar, ui = ui, li = li))
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
## sqrt(n)*(xbar-mu)/sigmaが標準正規分布に従うことの確認
z <- sqrt(n) * (result["xbar", ] - mu)/sigma
ggplot() +
  geom_histogram(aes(z, after_stat(density)), bins = 50) +
  stat_function(fun = dnorm, color = "red", linewidth = 1) +
  labs(x = expression(sqrt(n)*(bar(X)-mu)/sigma),
       title = expression(paste("Histogram of ", sqrt(n)*(bar(X)-mu)/sigma)))
