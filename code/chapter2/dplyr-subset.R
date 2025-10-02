### 関数dplyr::filter/selectの使い方
## install.packages("dplyr") # パッケージのインストール(必要な場合)
library(dplyr) # パッケージのロード
## dplyrを含むパッケージ集tidyverseを読み込んでもよい
## install.packages("tidyverse") # パッケージのインストール(必要な場合)
## library(tidyverse)

## 関数filterは行の条件，関数selectは列を指定する
filter(airquality, Ozone>100) # Ozoneが100を超える行を抽出
filter(airquality, Ozone>100) |> # "|>" はパイプ演算子
  select(Wind:Day) # 更にWindからDayの列を抽出
filter(airquality, Day == 1) |> # Dayが1の行を抽出
  select(-Temp) # Temp以外の列を抽出
## "|>" はR標準のパイプ演算子(バージョン4.1.0以降で利用可能)
## 前の関数の処理結果を次の関数の第一引数として渡す 
## 上の処理は以下のように書くこともできる
## airquality |> filter(Ozone>100) 
## airquality %>% filter(Ozone>100) %>% select(Wind:Day)
## airquality %>% filter(Day==1) %>% select(-Temp)
## tidyverse パッケージ集のパイプ演算子 "%>%" 
## を用いても同じ処理が記述できる
## 条件の組み合わせ
airquality |> # Ozoneに欠測(NA)がなく, Dayが1か2のデータを抽出
  filter(!is.na(Ozone) , Day %in% c(1, 2)) # 条件を書き並べると「かつ」
airquality |> # 上と同じ
  filter(!is.na(Ozone) & Day %in% c(1, 2)) # "&"で明示しても良い
airquality |> # Ozoneが120以上かTempが95以上のデータ
  filter(Ozone >= 120 | Temp >= 95) # "|"は「または」 