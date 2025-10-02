### ガンマ分布の最尤推定
### パッケージMASSの関数fitdistr()を利用
library(MASS) # パッケージのロード
## シミュレーションによる一致性の検証
set.seed(123) # 乱数の初期化
nu0 <- 5 # nuの真のパラメータ値
alpha0 <- 2 # alphaの真のパラメータ値
x <- rgamma(1000, shape = nu0, rate = alpha0)
## 最尤推定の実行
fitdistr(x, # 観測データ
         densfun = dgamma, # 確率関数/密度関数
         start = list(shape = 1, rate = 1) # 最適化の初期値
         )
## 代表的な確率分布の場合は分布名を指定して実行できる
## ガンマ分布の場合, 最適化の初期値も自動的に計算される
fitdistr(x, "gamma") 
## 複数回行なった場合のヒストグラムの描画
mle.gamma <- function(x) 
  fitdistr(x, "gamma")$estimate # データからMLEを計算する関数
MC <- 1000 # 各実験の繰り返し回数
## nがそれぞれ100, 1000, 10000の場合にそれぞれ実験を
## MC回実行して, 結果を記録
out1 <- replicate(MC, mle.gamma(rgamma(10, nu0, alpha0)))
out2 <- replicate(MC, mle.gamma(rgamma(100, nu0, alpha0)))
out3 <- replicate(MC, mle.gamma(rgamma(1000, nu0, alpha0)))
## 実験結果をヒストグラムで可視化
## まず, 実験結果をサンプル数nの列とそれに対応する推定値の列nu,alpha
## をもつ形式のデータフレームにまとめておく
dat <- cbind(out1, out2, out3) |> # 実験結果を横に繋げて2x3000行列を作成
  t() |> # 3000 x 2 行列に変換
  as_tibble() |> # tibble形式に変換
  mutate(n = rep(c(100,1000,10000), each = MC)) # nの列を追加
dat
## サンプル数ごとにヒストグラムを作成して結果を比較
## νの推定値
ggplot(dat) +
  geom_histogram(aes(shape), bins = 50, fill = "lightblue") +
  xlab(expression(nu)) +
  coord_cartesian(xlim = c(0, 20)) + # x軸を0から20の範囲に固定
  geom_vline(aes(xintercept = nu0), linetype ="dotted",
             linewidth = 1, color = "red") + # 理論値に対応する垂線 
  facet_wrap(~ n, # サンプル数ごとに別々にヒストグラムを描く
             ncol = 3, # 横に3つ並べる
             labeller = labeller(n = label_both))
## αの推定値
ggplot(dat) +
  geom_histogram(aes(rate), bins = 50, fill = "lightgreen") +
  xlab(expression(alpha)) +
  coord_cartesian(xlim = c(0, 10)) + # x軸を0から20の範囲に固定
  geom_vline(aes(xintercept = alpha0), linetype ="dotted",
             linewidth = 1, color = "red") + # 理論値に対応する垂線 
  facet_wrap(~ n, # サンプル数ごとに別々にヒストグラムを描く
             ncol = 3, # 横に3つ並べる
             labeller = labeller(n = label_both))
