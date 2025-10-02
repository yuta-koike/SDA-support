### 最尤法によるガンマ分布のパラメータの区間推定
### 関数fitdistr()およびconfint()を利用
library(MASS) # パッケージのロード
set.seed(123) # 乱数の初期化
nu0 <- 5 # nuの真のパラメータ値
alpha0 <- 2 # alphaの真のパラメータ値
x <- rgamma(1000, shape = nu0, rate = alpha0)
## 関数fitdistr()によるガンマ分布のあてはめ
(fit <- fitdistr(x, "gamma"))  
## 信頼区間の計算
confint(fit) # 95%信頼区間
confint(fit, level = 0.99) # 99%信頼区間
## モンテカルロ・シミュレーションによる検証
## n個のガンマ乱数から標本平均・標準偏差と平均の100p%信頼区間の
## 上端・下端を計算する関数の作成
myest <- function(n, shape, rate, p = 0.95){
  
  x <- rgamma(n, shape, rate) # ガンマ乱数の生成
  fit <- fitdistr(x, "gamma") # 最尤推定
  est <- fit$estimate # 最尤推定量
  se <- fit$sd # 標準誤差
  ci <- confint(fit, level = p) # 信頼区間
  ## 出力に余計な情報が残らないようにベクトルの名前を消しておく
  names(est) <- NULL
  names(se) <- NULL
  
  return(c(nu = est[1], alpha = est[2], se1 = se[1], se2 = se[2],
           li1 = ci[1,1], ui1 = ci[1,2], li2 = ci[2,1], ui2 = ci[2,2]))
}
## シミュレーションの実行
n <- 500 # サンプル数
MC <- 5000 # シミュレーション回数
set.seed(123) # 乱数の初期化
result <- replicate(MC, myest(n, nu0, alpha0)) # MC回実験
## 真のパラメーターが95%信頼区間に含まれている割合が約95%であることの確認
length(which(nu0 <= result["ui1", ] & nu0 >= result["li1", ]))/MC
length(which(alpha0 <= result["ui2", ] & alpha0 >= result["li2", ]))/MC
## はじめの20個の信頼区間の可視化(geom_errorbarを使用)
library(ggplot2)
## νの最尤推定量
ggplot() + 
  geom_errorbar(aes(x = 1:20, # x軸はただの番号
                    ymin = result["li1",1:20], # 信頼区間の下端
                    ymax = result["ui1",1:20]) # 信頼区間の上端
  ) +
  geom_hline(yintercept = nu0, # 真のパラメータを水平線で追加
             color = "red", lty = "dashed") +
  labs(x = "")
## αの最尤推定量
ggplot() + 
  geom_errorbar(aes(x = 1:20, # x軸はただの番号
                    ymin = result["li2",1:20], # 信頼区間の下端
                    ymax = result["ui2",1:20]) # 信頼区間の上端
  ) +
  geom_hline(yintercept = alpha0, # 真のパラメータを水平線で追加
             color = "red", lty = "dashed") +
  labs(x = "")
## 漸近正規性の確認
## νの最尤推定量
z.nu <- (result["nu", ] - nu0)/result["se1", ]
ggplot() +
  geom_histogram(aes(z.nu, after_stat(density)), bins = 25,
                 fill = "lightblue") +
  stat_function(fun = dnorm, color = "red", linewidth = 1) +
  labs(x = expression(sqrt(n)*(hat(nu)-nu)/sqrt(v[1])),
       title = expression(paste("Histogram of ", sqrt(n)*(hat(nu)-nu)/sqrt(v[1]))))
## αの最尤推定量
z.alpha <- (result["alpha", ] - alpha0)/result["se2", ]
ggplot() +
  geom_histogram(aes(z.alpha, after_stat(density)), bins = 25,
                 fill = "lightgreen") +
  stat_function(fun = dnorm, color = "red", linewidth = 1) +
  labs(x = expression(sqrt(n)*(hat(alpha)-alpha)/sqrt(v[2])),
       title = expression(paste("Histogram of ", sqrt(n)*(hat(alpha)-alpha)/sqrt(v[2]))))
