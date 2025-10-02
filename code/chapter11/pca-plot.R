## pca.rの続き
## 季節ごとに色分けして主成分スコアを可視化してみる
## パッケージggfortifyの関数autoplotを使用
# install.packages("ggfortify") # パッケージのインストール(必要な場合)
library(ggfortify) # パッケージのロード
## 「季節」の定義
season <- character(nrow(kikou))
season[kikou$月 %in% c(12,1,2)] <- "冬" 
season[kikou$月 %in% 3:5] <- "春" 
season[kikou$月 %in% 6:8] <- "夏" 
season[kikou$月 %in% 9:11] <- "秋" 
kikou$季節 <- season
## 主成分スコアの可視化
autoplot(mypca, data = kikou, colour = "季節") 
## 色を手動で設定
autoplot(mypca, data = kikou, colour = "季節") + 
  scale_color_manual(values = c(春 = "green", 夏 = "red", 
                                秋 = "orange", 冬 = "lightblue"))
## 天気(晴か雨)で色分けしてみる
## 「天気」の定義
kikou <- kikou |> 
  mutate(天気 = ifelse(kikou$降水量 >= 1, "雨", "晴")) 
# 関数ifelse()
# 第1引数がTRUEの場合は第2引数を返し, 
# FALSEの場合は第3引数を返す
## 主成分スコアの可視化
autoplot(mypca, data = kikou, colour = "天気") +
  scale_color_manual(values = c(晴 = "green", 雨 = "blue"))
