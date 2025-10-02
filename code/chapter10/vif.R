### 実行例multico.rの続き
### パッケージcarの関数vifによるVIFの確認
# install.packages("car") # パッケージcarのインストール(必要な場合)
library(car) # パッケージのロード
vif(out) # incomeとdepositのVIFが著しく高い
vif(out2) # どの変数のVIFも正常な範囲
