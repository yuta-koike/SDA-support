### 渋谷区の中古マンション価格の例
### 交差項の追加
library(tidyverse)
dat <- read_csv("shibuya21.csv") 
est4 <- lm(price ~ area + age + area:age, data = dat)
# area:ageがareaとageの交差項を表す
summary(est4)
# 交差項area:ageは有意. また, 自由度調整済み決定係数が
# 交差項なしのモデルと比べて上昇している
## モデルの別記法
lm(price ~ area*age, data = dat)
# area*ageはarea+age+area:ageと同じ意味となる
## 交差項ありのモデルを用いて築年数が5年増えたときの
## マンション価格を予測してみる
## 説明変数の新規データの作成
newx <- mutate(dat, age = age + 5) # 築年数を5年増やす
## 新規データnewxから予測されるpriceの値
pred <- predict(est4, newx) 
## 散布図によって元の値と予測値を比較
ggplot() +
  geom_point(aes(dat$price, pred)) +
  labs(x = "original", y = "predicted") + 
  geom_abline(intercept = 0, slope = 1, color = "red", 
              lty = "dashed", linewidth = 1) # 45度線
# 前の予測結果と異なり負の価格が予測されている
# 物件はなくなっている
