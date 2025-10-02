### 正規母集団の分散の区間推定
### 95%信頼区間を多数作成すると, 真の平均が含まれる区間が全体の
### 95%程度となることをモンテカルロ・シミュレーションで確認
set.seed(1) # 乱数の初期値の設定
## パラメータの設定
mu <- 10 # 平均
sigma <- 5 # 標準偏差
## n個の正規標本から不偏分散と分散の100(1-alpha)%信頼区間の
## 上端・下端を計算する関数の作成
myest <- function(n, alpha = 0.05){
  x <- rnorm(n, mean = mu, sd = sigma) # 正規乱数の生成
  s2 <- var(x) # 不偏分散
  ui <- (n-1) * s2/qchisq(alpha/2, df = n - 1) # 上側信頼限界
  li <- (n-1) * s2/qchisq(1-alpha/2, df = n - 1) # 下側信頼限界
  return(c(s2 = s2, ui = ui, li = li))
}
## シミュレーションの実行
n <- 5 # データ数
MC <- 10^4 # シミュレーション数
result <- replicate(MC, myest(n)) # MC回実験
## 真の分散sigma^2が95%信頼区間に含まれている割合が約95%であることの確認
length(which(sigma^2 <= result["ui", ] & sigma^2 >= result["li", ]))/MC
## はじめの20個の信頼区間の可視化(geom_errorbarを使用)
library(ggplot2)
ggplot() + 
  geom_errorbar(aes(x = 1:20, # x軸はただの番号
                    ymin = result["li",1:20], # 信頼区間の下端
                    ymax = result["ui",1:20]) # 信頼区間の上端
  ) +
  geom_hline(yintercept = sigma^2, # 真の分散を水平線で追加
             color = "red", lty = "dashed") +
  labs(x = "")
## (n-1)*s^2/sigma^2が自由度n-1のカイ二乗分布に従うことの確認
y <- (n - 1) * result["s2", ]/sigma^2
ggplot() +
  geom_histogram(aes(y, after_stat(density)), bins = 50) +
  stat_function(fun = \(x) dchisq(x, df = n - 1), 
                # 自由度n-1のカイ二乗分布の密度を計算する関数. 
                # \(x)はfunction(x)の略記法  
                color = "red", linewidth = 1) + 
  labs(x = expression((n-1)*s^2/sigma^2),
       title = expression(paste("Histogram of ", (n-1)*s^2/sigma^2)))
