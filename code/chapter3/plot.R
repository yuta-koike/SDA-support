### 基本的な描画
theta <- seq(0, 2*pi, length = 101)
x <- sin(theta)
plot(x) # 横軸に成分番号, 縦軸にxの各成分をプロット
plot(theta, # 横軸をthetaにしてみる
     x, 
     xlab = expression(theta), # x軸のラベル
     ylab = expression(sin(theta)), # y軸のラベル
     main = "Graph of the sine function", # グラフタイトル
     type = "l", # 折線プロット
     col = "red" # 色を赤にする
)
grid(col = "darkgray") # 格子線を追加
plot(sin, 0, 2*pi, lty = "dotted") # 関数を定義域を定めて描画