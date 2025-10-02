## バイプロット
## pca-plot.rの続き
autoplot(mypca, data = kikou, colour = "季節",
         loadings = TRUE, # 各変数の主成分負荷量を上書きする
         loadings.colour = "black", # 主成分負荷量の色
         loadings.label = TRUE, 
         # 各主成分負荷量に対応する変数名を上書きする
         loadings.label.colour = "black", # 変数名の色
         loadings.label.family = "Osaka" # 変数名の文字化けを防ぐ
         ) +
  scale_color_manual(values = c(春 = "green", 夏 = "red", 
                                秋 = "orange", 冬 = "lightblue"))
