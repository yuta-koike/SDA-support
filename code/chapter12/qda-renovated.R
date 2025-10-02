### 二次判別分析
### 目黒区の中古マンションによる例
## パッケージのロード
library(MASS) 
library(tidyverse) 
## データの読み込み
dat <- read_csv("meguro22.csv")
str(dat)
## 改装済みか否か(renovated)を築年数(age)と取引価格(price)
## を用いて予測してみる
out <- qda(renovated ~ price + age, data = dat)
result <- predict(out) # 予測結果
pred <- result$class # クラス判別の予測結果
## 実際の分類との比較
table(true = dat$renovated, predict = pred) # 表による比較
## 判別境界の可視化(パッケージklaRを利用)
library(klaR) # パッケージのロード
partimat(as_factor(renovated) ~ price + age, 
         data = dat, method = "qda", prec = 300) 
