### 渋谷区の中古マンション価格の例
### 最小二乗推定量の計算公式との一致を確認
library(readr)
dat <- read_csv("shibuya21.csv")
X <- model.matrix(price ~ minute + area + age, 
                  data = dat) # デザイン行列
# または X <- cbind(rep(1,nrow(dat)),dat$minute, dat$area, dat$age)
G <- crossprod(X) # グラム行列(t(X) %*% Xと同じ)
solve(G) %*% crossprod(X, dat$price)
