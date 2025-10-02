### 関数subsetの使い方
subset(airquality, # データフレームを指定
       subset = Ozone>100) # Ozoneが100を超える行を抽出
subset(airquality,
       subset = Ozone>100, 
       select = Wind:Day)  # WindからDayの列を抽出
subset(airquality, # Dayが1の行についてTemp以外の列を抽出
       Day==1, # "=="は「等しい」
       select = -Temp) # "-"は「以外」
## 引数の順番に注意すれば"subset="や"select="の一部は省略可能
## 以下は全て2番目の例と同じ結果を返す
## subset(airquality, Ozone>100, select = Wind:Day)
## subset(airquality, Ozone>100, Wind:Day)
## subset(airquality, select = Wind:Day, subset = Ozone>100)
## subset(airquality, select = Wind:Day, Ozone>100)
## subset(airquality, Wind:Day, subset = Ozone>100)

## 条件の組み合わせ
subset(airquality, # Ozoneに欠測(NA)がなく, Dayが1か2のデータを抽出
       !is.na(Ozone) & Day %in% c(1, 2)) # "かつ"は &
subset(airquality, # Ozoneが120以上かTempが95以上のデータ
       Ozone>=120 | Temp >= 95) # "または"は |
