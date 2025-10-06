### 実データへの適用
### 風速のデータにガンマ分布をあてはめたときのパラメータの信頼区間
library(MASS)
library(tidyverse)
## データの読み込み
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis"))
## 関数fitdistr()によるガンマ分布のあてはめ
x <- kikou$風速 # 風速データの抽出
fit <- fitdistr(x, "gamma")
## 信頼区間の計算
confint(fit) # 95%信頼区間
confint(fit, level = 0.99) # 99%信頼区間
