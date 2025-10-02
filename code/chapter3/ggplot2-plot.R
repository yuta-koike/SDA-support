### plot.rのggplotによる再現
#install.packages("ggplot2") # パッケージのインストール (必要な場合)
library(ggplot2) # パッケージのロード
theta <- seq(0, 2*pi, length = 101)
x <- sin(theta)
out <- ggplot(mapping = aes(theta, x)) # x軸にtheta, y軸にxを設定
out + geom_point() # 点プロット
out + geom_line(color = "red") + # 赤色で折線プロット
  labs(x = expression(theta), # x軸のラベル
       y = expression(sin(theta)), # y軸のラベル
       title = "Graph of the sine function") # グラフタイトル
## 関数を定義域を定めて描画
ggplot() + xlim(range(theta)) + # x軸の範囲を指定
  geom_function(fun=sin, linetype="dotted") # 関数名を指定
## データフレームを用いる例
df <- data.frame(theta=theta, sin=sin(theta), cos=cos(theta))
ggplot(df, aes(theta, sin)) +
  geom_point(colour="blue") + # 青色でsinを点プロット 
  geom_line(aes(y=cos), colour="red") + # 赤色でcosを折線プロット
  labs(x=expression(theta), # x軸のラベル
       y=expression(sin(theta)/cos(theta)), # y軸のラベル
       title="Graph of the sine/cosine functions") # タイトル
