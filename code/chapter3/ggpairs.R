### 散布図行列 (東京都の新型コロナウイルス感染動向のデータによる例)
library(tidyverse)
covid <- read_csv("covid19tokyo.csv")
# install.packages("GGally") # パッケージのインストール(必要な場合)
library(GGally) # パッケージのロード
ggpairs(covid, columns = 4:7) # 4~7列目の変数間の散布図行列
## 年月で色分けする場合
ggpairs(covid, columns = 4:7, 
        aes(color = 年月), # 年月の列に基づき色分け
        upper = "blank", # 上三角成分は表示しない
        diag = "blank", # 対角成分は表示しない
        legend = c(2,1)) # (2,1)成分のグラフの凡例を使用
