### 独立性の検定(気候データによる例)
library(readr)
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis")) 
## 降水日数と月が独立か否かの検定(5%水準で棄却される)
(out <- with(kikou, chisq.test(降水量 >= 1, 月))) 
out$observed # 分割表
## モザイクプロットによる可視化
mosaicplot(out$observed, shade = TRUE)
# 特に2月の降水日が少ない
# なお, 分割表を経由しなくても,
# mosaicplot( ~ (降水量 >= 1) + 月, data = kikou, shade = TRUE)
# でもモザイクプロットを描画できる
