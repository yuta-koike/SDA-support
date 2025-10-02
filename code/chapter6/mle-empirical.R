### 実データへの適用
### 風速のデータにガンマ分布をあてはめてみる
library(MASS)
library(tidyverse)
kikou <- read_csv("kikou2021.csv",
                  locale=locale(encoding="sjis"),
                  show_col_types = FALSE)
## まずは風速のヒストグラムを描画する
x <- kikou$風速 # ビンの設定のために風速のデータを取り出しておく
obj <- ggplot(kikou) +
  geom_histogram(aes(風速, after_stat(density)), # 密度スケールにしておく
                 fill = "lightblue",
                 breaks = seq(min(x), max(x), by = (max(x) - min(x))/15)) 
                 # 見映えの調整のためにビンを明示的に設定しておく
obj
## 最尤法によるガンマ分布のあてはめ
(theta <- fitdistr(x, "gamma")$estimate)
## あてはまり具合を確認するために, ヒストグラムにあてはめたガンマ分布の
## 密度を上書きしてみる
f <- \(x) dgamma(x, theta[1], theta[2])
obj +
  stat_function(color = "red", linewidth = 1, fun = f)
