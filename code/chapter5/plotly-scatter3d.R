### rmvnorm.rの続き
### plotlyパッケージによるインタラクティブな3次元散布図の作成
# install.packages("plotly") # パッケージのインストール(必要な場合)
library(plotly) # パッケージのロード
fig <- plot_ly(as.data.frame(x), # データフレームとして渡す
        x = ~X1, y = ~X2, z = ~X3 # x,y,z軸の指定
        )
fig
fig %>% add_markers(size = I(100)) # 点のサイズを調整する
fig %>% add_markers(size = I(50),
                    color = ~ X3 # X3の値に応じてグラデーションをつける
                    )
## 色を手動で設定する場合
fig %>% add_markers(size = I(100),
                    marker = list(color = ~X3, 
                                  colorscale = c("red", "blue"),
                                  showscale = TRUE # 色スケールの凡例をつける
                                  ) 
                    )