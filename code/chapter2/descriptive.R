### 気候データの例による代表的な記述統計量の計算
library(readr)
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis"),
                  show_col_types = FALSE) # 列名に関するメッセージを非表示にする 
x <- kikou$気温
mean(x) # 平均
sum(x)/length(x) # mean(x)に一致
var(x) # 分散
sd(x) # 標準偏差
sqrt(var(x)) # sd(x)に一致
max(x) # 最大値
min(x) # 最小値
median(x) # 中央値
quantile(x, 0.5) # 上と同じ; 中央値は50%分位点
quantile(x, c(0.25, 0.75)) # 第1四分位点および第3四分位点
quantile(x) # 最大・最小および四分位点(五数要約)を表示
quantile(x, seq(0, 1, by=0.1)) # 10%刻みの分位点を表示
y <- c(x, 1000) # データに外れ値を加えてみる
mean(y) # 外れ値の影響を強く受ける
median(y) # 外れ値の影響をあまり受けない
