### 線形重回帰分析(気候データによる例)
library(readr)
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis"))
## 気温を目的変数, それ以外を説明変数とする
mod1 <- lm(気温 ~ ., data = kikou)
summary(mod1)
## 気温を目的変数, 気温, 月, 日以外を説明変数とする
mod2 <- lm(気温 ~. - 月 - 日, data = kikou)
summary(mod2)
