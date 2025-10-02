### 箱ひげ図の描画
## 気候データによる例
library(tidyverse)
## データの読み込み
kikou <- read_csv(file="kikou2021.csv",
                  locale=locale(encoding="sjis"),
                  show_col_types = FALSE)
cols <- rainbow(12)[c(8:1,12:9)] # 月ごとの色の設定(赤系を夏，青系を冬)
kikou <- kikou |> mutate(月=as_factor(月)) # 月はfactorに変換しておく
ggplot(kikou) +
  geom_boxplot(aes(月, 気温),
               fill=cols, # 箱の色の設定
               alpha=0.4) + # 透明度を上げる
  labs(x="月", title="月ごとの気温の分布") # x軸のラベル名とタイトルの(再)設定

## 以下でも同様(色の設定についてはいろいろな方法がある)
palecols <- adjustcolor(cols,
                        alpha.f=0.4) # 透明度(アルファ値)を設定
kikou |> # パイプ演算子を使って書く場合
  ggplot(aes(as_factor(月), 気温)) + # 関数ggplotでx,y軸を指定しても良い
  geom_boxplot(fill=palecols) + # alphaを指定しないので外れ値の透明度はそのまま
  labs(x="月", title="月ごとの気温の分布") # x軸のラベル名とタイトルの(再)設定

## 分布を見るその他の方法 (以下を重ねることも可能)
kikou |>
  ggplot(aes(月, 気温, colour=月)) + 
  geom_point(show.legend=FALSE) + # 月毎にデータ点を描画
  scale_colour_manual(values=adjustcolor(cols, 0.8)) + # colour の色
  labs(x="月", title="月ごとの気温の分布") 
 
kikou |>
  ggplot(aes(月, 気温, colour=月)) + 
  geom_jitter(show.legend=FALSE) + # x座標をランダムにずらす
  scale_colour_manual(values=adjustcolor(cols, 0.8)) + # colour の色
  labs(x="月", title="月ごとの気温の分布")   

kikou |>
  ggplot(aes(月, 気温, fill=月, colour=月)) + 
  geom_violin(show.legend=FALSE) + # バイオリンプロット. 幅でデータの多寡を表現
  scale_colour_manual(values=adjustcolor(cols, 0.8)) + # colour の色
  scale_fill_manual(values=adjustcolor(cols, 0.2)) + # fill の色
  labs(x="月", title="月ごとの気温の分布")  
  
## 関数 ggbeeswarm::geom_beeswarm を用いたデータ点の重ね描きの例
## install.packages("ggbeeswarm") # パッケージのインストール(必要な場合)
library(ggbeeswarm)
kikou |> # jitterより規則的に点を配置してくれる
  ggplot(aes(月, 気温)) + 
  geom_beeswarm(aes(colour=月), show.legend=FALSE) + # 月ごとに colour を変更
  geom_boxplot(aes(fill=月), show.legend=FALSE) + # 月ごとにfillだけ変更
  scale_colour_manual(values=adjustcolor(cols, 0.8)) + # colour の色
  scale_fill_manual(values=adjustcolor(cols, 0.2)) + # fill の色
  labs(x="月", title="月ごとの気温の分布") 
