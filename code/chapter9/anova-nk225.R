### 一元配置の分散分析
### 日経平均の収益率に曜日ごとの差があるか検定
### データは東京大学数理・情報教育研究センターのウェブサイト
### においてあるデータセットから取得(日付の情報は著者が付与)
## データの読み込み
library(tidyverse)
x <- read_csv("nikkei225_sda.csv")
## 収益率からなるデータに変換する
## 関数reframe()
## データフレームの変数を加工して別の新しいデータフレームを
## 作成する関数. 作成後のデータフレームの行数はは元のものと
## 異なってよい
## diff(): 階差をとる関数
## n(): dplyrパッケージの関数群内でデータ数を取得するための関数
y <- x |>
  reframe(return = diff(price)/price[-n()],
          date = date[-1]) |>
  mutate(youbi = weekdays(date, 
                          abbreviate = TRUE)) # 曜日の情報をデータに追加
## 曜日ごとの収益率に関する分散分析
(result <- aov(return ~ youbi, data = y)) 
summary(result) # 分散分析表の表示(5%水準で棄却される)
model.tables(result, type = "means") # 水準ごとの平均値(今の場合曜日ごと)
model.tables(result, type = "effects") # 水準ごとの効果(今の場合曜日ごと)
## 箱ひげ図による可視化
ggplot(y) +
  geom_boxplot(aes(youbi, return)) +
  labs(x = "曜日", y = "収益率") 
## 等分散性を仮定せずに検定を実行するには, 関数oneway.test()を
## 用いる(ウェルチの近似法によって帰無分布が近似される)
oneway.test(return ~ youbi, data = y)
