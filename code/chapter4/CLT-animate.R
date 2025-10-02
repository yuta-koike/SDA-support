### (CLT.rの続き)
### サンプル数nを動かす範囲・実験回数MCを増やしてアニメーションを作成
set.seed(127) # 乱数の初期値の指定
MC <- 10000 # 各実験の繰り返し回数
nsample <- c(100, 500, 1000, 5000, 10000) # 各実験のサンプル数
## nを動かしながらmysim(n)を実行するには関数sapply()が便利
## sapply(nsample, mysim)を実行すると, nをnsampleの各成分で動かした際の
## mysim(n)のそれぞれの計算結果をベクトルでまとめて出力する
sapply(nsample, mysim)
## ここではこの実験をMC回繰り返したいので, replicate()と併用
out <- replicate(MC, sapply(nsample, mysim))
str(out) # 結果はlength(nsample) x MC行列
## まず, 実験結果をサンプル数nの列とそれに対応する実験結果の列z
## をもつ形式のデータフレームにまとめておく
dat <- tibble(n = rep(nsample, times = MC),
              z = as.vector(out))
## サンプル数ごとにヒストグラムを作成してアニメーションで表示
anim <- ggplot(dat) +
  geom_histogram(aes(x = z, y = after_stat(density)), 
                 # yをafter_stat(density)に指定することで, 
                 # 縦軸を密度スケールにしている
                 breaks = seq(-3, 3, by = 0.2)) +
  xlab(expression(sqrt(n) * (bar(X)[n] - mu)/sigma)) +
  coord_cartesian(xlim = c(-3, 3)) +
  stat_function(linewidth = 1, fun = dnorm, color = "red") + 
  transition_states(n, state_length = 0.1)
anim
## 遷移スピードの調整には関数animate()を使う
animate(anim, duration = 5) # durationで再生時間(秒)を指定
animate(anim, fps = 20) # fpsでフレームレートを指定
