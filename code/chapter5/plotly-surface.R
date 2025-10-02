### dmvnorm.rの続き
### plotlyパッケージによるインタラクティブなグラフの作成
plot_ly(x = x, y = y, z = z) %>% add_surface()
plot_ly(x = x, y = y, z = z) %>% 
  add_surface(colorscale = list(seq(0,1,length=10), 
                                topo.colors(10)) # マニュアルで色指定
              )
