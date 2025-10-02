### 渋谷区の中古マンション価格の例
### 最小二乗推定量の理論的性質の確認
library(readr)
dat <- read_csv("shibuya21.csv") 
est <- lm(price ~ ., data = dat)
## あてはめ値と残差が直交することの確認
yhat <- fitted(est) # あてはめ値
epshat <- resid(est) # 残差
yhat %*% epshat
## 回帰式が標本平均を通ることの確認
b <- coef(est) # 回帰係数の最小二乗推定量
colMeans(X) %*% b 
# ここで，Xは切片項を含むことに注意．head(X)