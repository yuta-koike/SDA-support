### (bernoulli-LLN.rの続き)
### 「上の実験を何度も繰り返して結果をプロットする」という
### シミュレーションをアニメーションで作成
## パッケージgganimateとtransformrが必要なので, 
## 必要に応じてインストールする
# install.packages(c("gganimate", "transformr")) 
library(tidyverse)
library(gganimate) 
# transformrは必要に応じてバックグラウンドで呼び出されるので
# ロードしなくてもよい
set.seed(123) # 乱数の初期値の指定
p <- 0.5 # 事象が起きる確率
N <- 1000 # 1回のシミュレーション内での試行の繰り返し回数
MC <- 10 # シミュレーション回数
## mysim(N)をMC回繰り返し実行して, 結果を記録する
out <- replicate(MC, mysim(N)) 
# 関数replicate()
# 第2引数に与えたコードを第1引数の回数だけ実行し結果を返す
# 今の場合, 結果はN x MCの行列で返却され, j列目にj回目の
# シミュレーション結果が格納されている
str(out) # 結果の概要の表示
## gganimateパッケージの書式に載せるために, 結果を「試行回数」
## 「実験番号」「実験結果」の3つの列をもつデータフレームに変換する
dat <- as.data.frame(out) |> # データフレームに変換
  mutate(time = 1:N) |> # 「試行回数」にあたる列を追加
  pivot_longer(-time) # 実験結果の列を結合して3列のデータフレームに変換
str(dat) # 変換後のデータを表示(nameが実験番号, valueが実験結果)
## gganimateパッケージを使ってアニメーションを作成する
## まず試行回数を横軸, 実験結果を縦軸にとって通常通りggplotを作成
obj <- ggplot(dat) + 
  geom_line(aes(time, y = value, color = "1")) +
  geom_hline(aes(yintercept = p, color = "2"), linetype ="dotted",
             linewidth = 1) +
  ylim(c(0,1)) +
  labs(x = "N", y = expression(R[N]/N), 
       title = "Bernoulli's Law of Large Numbers") +
  scale_color_manual(name = "", values = c("black", "red"),
                     labels = c(expression(R[N]/N), expression(p)))
## gganimate::transition_states()を使って，実験番号ごとに結果を
## 表示するアニメーションを作成する
obj + 
  transition_states(name, # 結果を表示する順番を指定する変数
                    transition_length = 0
                    # 結果を表示する相対的な時間間隔. 0の場合は表示が不連続になる
                    ) 
## 結果をgifファイルで保存したい場合は関数anim_save()を使う
# anim_save("bernoulli.gif") # "bernoulli.gif"という名前で結果を保存
