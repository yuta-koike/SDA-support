### 分散の比に対する仮説検定(気候データによる例)
### 異なる月どうしの気温に有意差があるか調べてみる
library(readr)
kikou <- read_csv(file="kikou2021.csv", locale=locale(encoding="sjis")) 
## 1, 8, 10月の気温のばらつきを比較してみる
## 1月と8月はそれぞれ真冬と真夏なので気温のばらつきが小さく,
## 10月は季節の変わり目なので気温のばらつきが大きいと予想される
## 以下のコードにおける関数subset()のdrop = TRUEという指定は
## 結果をベクトルで返すために必要(デフォルトではデータフレームとなるが, 
## 関数var.test()はデータフレームを引数として受け付けないため)
x <- kikou |> subset(月 == 1, 気温, drop = TRUE) 
y <- kikou |> subset(月 == 8, 気温, drop = TRUE) 
z <- kikou |> subset(月 == 10, 気温, drop = TRUE) 
var.test(x, y) # 1月と8月の気温のばらつき具合は異なるか?
var.test(y, z, alternative = "less") # 8月より10月の方が気温のばらつきは大きいか?
