### コブ・ダグラス型生産関数の推定による例
### データセットmanufacturing18.csv
### 都道府県別に集計された2018年の製造業の従業員数, 付加価値額および
### 有形固定資産額(年末現在高)のデータ
### 経済産業省の2019年工業統計表(地域別統計表)より作成
### https://www.meti.go.jp/statistics/tyo/kougyo/result-2.html
### Q: 付加価値額
### L: 従業員数
### K: 有形固定資産額
## データの読み込み
library(readr)
dat <- read_csv("manufacturing18.csv") 
## 対数変換後の変数どうしで線形回帰
(mod <- lm(log(Q) ~ log(L) + log(K), data = dat)) 
summary(mod) # 決定係数は非常に高くよくあてはまっている