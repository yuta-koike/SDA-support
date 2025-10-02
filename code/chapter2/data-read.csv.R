### パッケージreadrの関数read_csvの使い方
library(readr)
(newdata <- read_csv(file="mydata.csv")) 
## data.frameの拡張版であるtibble形式として読み込まれる
class(newdata) # データのクラスの確認
str(newdata) # データの構造の確認　
View(newdata) # 表形式で表示
## 外部CSVデータの読み込み
## 東京都の2021年の気候データによる例
## 東京都の2021年の各日の平均気温(℃)・降水量(mm)・全天日射量(MJ/u)・
## 平均風速(m/s)・平均湿度(%)を記録したデータセット
guess_encoding("kikou2021.csv") 
## 関数readr::guess_encoding はファイルの文字コードを推測する
## "Shift_JIS" であると 0.88 の信頼度で認識される
kikou <- read_csv(file="kikou2021.csv",
                  locale=locale(encoding="sjis"))
## 文字コードとしては "sjis", "shift-jis", "shift_jis", 
## "cp932"(拡張文字を含む)などを大文字小文字は区別せず指定できる
print(kikou, n=6) # データの最初の6行を表示; headでもよい
str(kikou) # データの構造の確認
View(kikou) # 表形式で表示

### 関数read.csvを用いる場合(追加パッケージのインストールは不要)
(newdata2 <- read.csv(file="mydata.csv")) 
class(newdata2) # データのクラスの確認
str(newdata2) # データの構造の確認　
View(newdata2) # 表形式で表示
## 気候データの例
kikou <- read.csv("kikou2021.csv",
                  fileEncoding="sjis") # ファイルの文字コードがShift-JIS
head(kikou) # データの最初の6行を表示
str(kikou) # データの構造の確認
View(kikou) # 表形式で表示
