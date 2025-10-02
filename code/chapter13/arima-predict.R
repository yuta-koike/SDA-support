### 日経225株価データによる例
### 東京大学 数理・情報教育研究センターの
### 時系列データの教材ページ
### http://www.mi.u-tokyo.ac.jp/consortium2/time_series_data.html
### より取得
### 日付の情報は著者が付与
library(forecast) # パッケージのロード
library(ggfortify) # パッケージのロード
# 注意：
# forecast, ggfortifyはそれぞれ独自のautoplotの追加機能を定義しており,
# あとからロードした方の追加機能が優先される．そのため，今の場合は
# ggfortifyの定義する追加機能に基づく描画が行われる
dat <- read.csv("nikkei225_sda.csv") # データの読み込み
str(dat) # データの構造
x <- ts(dat$price) # 価格系列を時系列データとして取得
autoplot(x, ylab = "Price") # プロット
## 株価データは対数値をモデル化することが多いので対数変換しておく
y <- log(x) 
autoplot(y, ylab = "Log price") # プロット
## 末尾252日以前のデータを用いてモデルを構築し, 
## 末尾252日分のデータを予測する
## 252日というのは, だいたい1年間の取引日数に相当
y.in <- window(y, start = 1, end = length(y) - 252) # 学習用データ
y.out <- window(y, start = length(y) - 252 + 1) # テストデータ
## モデル構築
ggAcf(y.in) # 自己相関の減衰は遅い
ggPacf(y.in) # 偏自己相関はラグ2以降大きく減衰
ggAcf(diff(y.in))  
ggPacf(diff(y.in)) 
## ACF・PACFの形状から差分系列は定常だと思われるので，
## 差分系列にARMAモデルをあてはめてみる
## AIC最小化で次数を選択する(AR(2)が選ばれる)
(fit <- auto.arima(y.in, d = 1, D = 0))
ggtsdiag(fit) # 診断プロット
## 予測
p <- forecast(fit, h = 252, level = 95) 
# 252期先まで予測．レベルは予測区間の有意水準
## 可視化
autoplot(p, ylab = "Log price") +
  autolayer(y, series = "Actual") + # 原系列を上書き
  autolayer(p$mean, series = "Predicted", lwd = 1) # 予測値を上書き
# 塗りつぶされた領域は95%予測区間を表す
# おおよそ95%の確率で実績値が含まれることが予測される範囲に対応
## 次に, シミュレーションによって予測してみる
set.seed(127)
path <- simulate(fit, nsim = 252) # 252日分のパスのシミュレーション
## 可視化
ggplot() + labs(y = "Log price") +
  autolayer(y.out, series = "Actual") +
  autolayer(path, series = "Predicted", lty = "dashed")
## １本のパスでは傾向がわからないので, 100本のパスを
## モデルから生成して重ねてプロットする
## 100本のパスをシミュレートして結果を保存
path <- replicate(100, simulate(fit, nsim = 252))
path <- ts(path, start = length(y) - 252 + 1) # tsクラスに変換
## 可視化
autoplot(path, ylab = "Log price", show.legend = FALSE) + 
  # シミュレートしたパスをプロット
  autolayer(y.out, show.legend = FALSE) + # 実際のパスを上書き
  scale_color_manual(values = c(rep("skyblue", 100), "red")) # 色の調整
