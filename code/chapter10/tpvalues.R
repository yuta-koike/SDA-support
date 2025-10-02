### 渋谷区の中古マンション価格の例
### t値とp値の確認
library(readr)
dat <- read_csv("shibuya21.csv") 
est <- lm(price ~ ., data = dat) 
summary(est)
# area, ageのp値は非常に小さいため, (一般的な有意水準で)
# 有意となる. 一方で, minuteのp値は大きく, (一般的な
# 有意水準で)有意でない. 従って, 渋谷区の中古マンションに
# ついては, 面積と築年数は取引価格と関係があるが, 最寄駅から
# の距離は取引価格に影響しないことが示唆される
## minuteのみで回帰してみる
est2 <- lm(price ~ minute, data = dat)
summary(est2)
# 今度はminuteのp値は0.001より小さく, 0.1%水準で有意となる
# これは一見すると矛盾しているように見えるが, 回帰係数の
# 解釈の方法を考慮すると理解できる(次節で説明)