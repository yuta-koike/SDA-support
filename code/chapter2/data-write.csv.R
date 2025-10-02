### パッケージreadrの関数write_csvの使い方
## install.packages("readr") # パッケージのインストール(必要な場合)
library(readr) # パッケージのロード
(mydata <- subset(airquality, Ozone>90, select=-Temp)) # データフレームの作成
dim(mydata) # 大きさを確認
write_csv(mydata, file="mydata.csv") # csvファイルとして書き出し
## データフレームの行名は書き出されないので注意

### 関数write.csvを用いる場合(追加パッケージのインストールは不要)
write.csv(mydata, file="mydata2.csv") # csvファイルとして書き出し
## こちらはデータフレームの行名を書き出す
## 書き出したくない場合はrow.names=FALSEを指定
