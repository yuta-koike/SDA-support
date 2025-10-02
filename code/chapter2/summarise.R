### 関数dplyr::summariseの使い方
## パッケージのロード
library(tidyverse) # tidyverseのパッケージ群をすべてロード 
## データの読み込み
kikou <- read_csv("kikou2021.csv", locale=locale(encoding="sjis"))
## 特定の変数に対する記述統計量の計算
kikou |> summarise(mean=mean(気温), sd=sd(気温))
## 複数の変数に対して同時に記述統計量を計算(関数acrossを利用)
kikou |> 
  summarise(across(everything(), mean)) # 列ごとの平均
colMeans(kikou) # 列ごとの平均はcolMeans()でも計算できる
kikou |> 
  summarise(across(!c(月, 日), median)) # 月日以外の中央値
## 複数の統計量を計算するには関数のリストを渡す
kikou |>
  summarise(across(c(気温, 日射量), # 気温と日射量の列を選択
                   list(max=max, min=min))) # 最大値と最小値
## 変数ごとに五数要約+平均を計算
summary(kikou) 
## 各行をグループ分けしてグループごとに記述統計量を計算
kikou |> # 月ごとの平均
  group_by(月) |> # 月ごとにグルーピング
  summarise(across(!日, mean)) # 日を除く列の平均値
# 関数group_byによってtibble形式のデータフレームが作成される
## 以下の記法も可能
## kikou |> # 月ごとの平均
##  summarise(across(!日, mean), .by=月) 
## 複数の条件でグループ化することもできる
out <- kikou |> 
  group_by(月, 降水の有無=降水量>=1) |> # 月および降水の有無
  summarise(across(!日, mean))
# 注: 気象庁は降水日を「日降水量1mm以上の日」と定義している
print(out,n=Inf) # tibble形式で全体を表示
## 関数group_byを使わずに以下のように書くこともできる
## kikou |> 
##  mutate(降水の有無=降水量>=1) %>% # 降水の有無を加える
##  summarise(across(!日, mean), .by=c(月, 降水の有無))
