### 線形判別分析における変数選択(目黒区の中古マンションによる例)
## パッケージのロード
library(MASS) 
library(tidyverse) 
dat <- read_csv("meguro22.csv")
## renovated以外のすべての変数を用いたモデルにおいて
## 不要な変数が含まれているか検定する
out <- lda(renovated ~ ., data = dat) 
mu <- out$means # 各変数のクラスごとの平均
p <- ncol(mu) # 変数の総数
d <- mu[1,] - mu[2,] # dの計算
V <- out$scaling
a <- V * sum(V*d) # aの計算
n1 <- sum(dat$renovated == out$lev[1]) # クラス1のデータ数
n2 <- sum(dat$renovated == out$lev[2]) # クラス2のデータ数
n <- n1 + n2 # 総データ数
total <- model.matrix(renovated ~ . - 1, data = dat) |>
  cov() * (n - 1) # 行列Tの計算
tinv <- solve(total) |> diag() # Tの逆行列の対角成分
denom <- (n-2) * tinv * 
  (n * (n-2) + n1 * n2 * sum(d * a)) # F統計量の分母
fstat <- (n - p - 1)*n1*n2*a^2/denom # F統計量
pf(fstat, 1, n - p - 1, lower.tail = FALSE) # p値
# price, ageは0.1%水準, areaは1%水準で有意
# minute, Qのp値は非常に大きく有意でない
## パッケージklaRの関数greedy.wilks()による変数選択
library(klaR) # パッケージのロード
(res <- greedy.wilks(renovated ~ ., data = dat))
# age, price, priceが選択される
lda(res$formula, data = dat) # 選択されたモデルでldaを実行
