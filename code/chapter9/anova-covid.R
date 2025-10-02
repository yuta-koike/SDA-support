### 一元配置の分散分析(東京都の新型コロナウイルス感染者の属性データによる例)
### 月ごとの感染者の年代に差があるか否かを分散分析
## データの読み込み
library(tidyverse) 
covid <- read_csv("covid19attr.csv")
## 因子扱いするために月をfactorに変換
covid <- mutate(covid, 月 = as_factor(月))
## 月ごとの年代差に関する分散分析
(result <- aov(年代 ~ 月, data = covid)) 
summary(result) # 分散分析表の表示(棄却される)
model.tables(result, type = "means") # 水準ごとの平均値(今の場合月ごと)
model.tables(result, type = "effects") # 水準ごとの効果(今の場合月ごと)
## 箱ひげ図による可視化
ggplot(covid) +
  geom_boxplot(aes(月, 年代)) +
  ggtitle("月ごとの年代")
