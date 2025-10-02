### 線形重回帰分析
### 渋谷区の中古マンション価格の例
### データセット shibuya21.csv
### 2021年に取引された渋谷区の中古マンションに関するデータ
### minute: 最寄駅から徒歩何分か
### price: 取引価格(万円)
### area: 面積(㎡)
### age: 築年数
### 取引価格を他の変数で説明する
library(readr)
dat <- read_csv("shibuya21.csv") # データの読み込み
(est <- lm(price ~ minute + area + age, data = dat)) # 重回帰分析の実行
coef(est) # 回帰係数の最小二乗推定量のみ抽出