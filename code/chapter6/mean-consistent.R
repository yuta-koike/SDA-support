### 標本平均の一致性
set.seed(123) # 乱数シードの指定
N <- 1000 # サンプル数
x <- runif(N) # 区間(0,1)上の一様乱数で試行
## n=1,2,...,Nと変えていった際の標本平均を計算
xbar <- cumsum(x)/(1:N) 
## 可視化
library(tidyverse)
ggplot() + 
  geom_line(aes(x = 1:N, y = xbar, color = "1")) +
  # 凡例の変更の際に参照するために, colorを文字列で指定する 
  geom_hline(aes(yintercept = 0.5, color = "2"), # 真の平均μ=0.5を表す直線を追加
             linetype ="dotted", # 点線で描画
             linewidth = 1) + # 線の幅の指定
  labs(x = "n", y = expression(bar(X)[n]), 
       title = expression(mu == 0.5)) +
  scale_color_manual(name = "", values = c("black", "red"),
                     labels = c(expression(bar(X)[n]), expression(mu)))
# 色と凡例の変更

## 複数回のシミュレーションによる一致性の確認
M <- 100 # シミュレーションの回数
res <- replicate(M, cumsum(runif(N))/(1:N))
# 関数replicate
# 第２引数に与えたコードを第１引数の回数だけ実行し結果を返す
# 今の場合, 結果はM x Nの行列(行数M, 列数Nの長方形状のデータ構造)
# で返却され, j列目にj回目のシミュレーション結果が格納されている
str(res) # 結果の概要の表示
## 可視化
## ggplotの書式に載せるために, 結果を「試行回数」「実験番号」
##「実験結果」の3つの列をもつデータフレームに変換する
dat <- as.data.frame(res) |> # データフレームに変換
  mutate(time = 1:N) |> # 「試行回数」にあたる列を追加
  pivot_longer(-time) # 実験結果の列を結合して3列のデータフレームに変換
str(dat) # 変換後のデータを表示(nameが実験番号, valueが実験結果)
## 試行回数を横軸, 実験結果を縦軸にとってggplotを作成
ggplot(dat) + 
  geom_line(aes(time, y = value, color = "1")) +
  # 凡例の変更の際に参照するために, colorを文字列で指定する 
  geom_hline(aes(yintercept = 0.5, color = "2"), # 真の平均μ=0.5を表す直線を追加
             linetype ="dotted", # 点線で描画
             linewidth = 1) + # 線の幅の指定
  labs(x = "n", y = expression(bar(X)[n]), 
       title = expression(mu == 0.5)) +
  scale_color_manual(name = "", values = c("skyblue", "red"),
                     labels = c(expression(bar(X)[n]), expression(mu)))
