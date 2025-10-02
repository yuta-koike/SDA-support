### 厳密でない多重共線性の例
### データセット expenditure.csv
### 都道府県ごとに集約された二人以上世帯の家計収支のデータ
### 総務省統計局の2019年全国家計構造調査データより作成
### http://www.stat.go.jp/data/zenkokukakei/2019/index.html
library(tidyverse)
dat <- read_csv("expenditure.csv") # データの読み込み
## 食費(food)を他の収支項目で説明するモデルを作成する
out <- lm(food ~ education + recreation + income + deposit, data = dat)
# educationは教育費, recreationは教養娯楽費, 
# incomeは可処分所得, depositは預貯金にまわった額
summary(out)
# 決定係数は70%以上あり高いが, incomeやdepositが
# 標準的な有意水準では有意でない
## depositを説明変数から外してみる
out2 <- lm(food ~ education + recreation + income, data = dat)
summary(out2)
# 今度はすべての説明変数が1%水準で有意
dat |> summarise(cor(income, deposit))
# incomeとdepositの相関係数は1に非常に近く, このせいで
# 多重共線性の問題が起きていたのだと考えられる
