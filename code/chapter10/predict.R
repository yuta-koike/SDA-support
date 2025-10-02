### 渋谷区の中古マンション価格の例
### 築年数が5年増えたときのマンション価格を予測する
library(tidyverse)
dat <- read_csv("shibuya21.csv") # データの読み込み
est <- lm(price ~ ., data = dat) # 回帰モデルの推定
## 説明変数の新規データの作成
newx <- mutate(dat, age = age + 5) # 築年数を5年増やす
head(dat$age)
head(newx$age)
## 新規データnewxから予測されるpriceの値
pred <- predict(est, newx) 
## 散布図によって元の値と予測値を比較
ggplot() +
  geom_point(aes(dat$price, pred)) +
  labs(x = "original", y = "predicted") + 
  geom_abline(intercept = 0, slope = 1, color = "red", 
              lty = "dashed", linewidth = 1) # 45度線