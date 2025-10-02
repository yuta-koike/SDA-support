### データの抽出
## ベクトルの例
x <- c(4, 1, 2, 9, 8, 3, 6)
x[c(5, 2)] # 5番目と2番目の要素をこの順で抽出
x[-c(2, 3, 7)] # 2,3,7番目以外の要素を表示
(idx <- x > 3) # 3より大きい要素はTRUE, 3以下の要素はFALSE
x[idx] # 3より大きい要素をすべて表示
x[x > 3] # 上と同じ
x[c(2, 5)] <- c(0, 1) # 2番目と5番目の要素を文字0と1に置換
x
## データフレームの例
## Rの組込みデータセットairqualityを利用
## 詳細はhelp(airquality)参照
dim(airquality) # 大きさを確認
names(airquality) # 列名を表示
head(airquality) # 最初の6行を表示
str(airquality) # オブジェクトの構造を表示
airquality[which(airquality$Ozone>100), ] # Ozoneが100を超える行を抽出
airquality[which(airquality$Ozone>100), c("Month", "Day")] 
# Ozoneが100を超える行のMonthとDayを表示