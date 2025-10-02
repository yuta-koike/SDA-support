### RのさまざまなデータセットのACF
# install.packages("forecast") # パッケージのインストール(必要な場合)
library(forecast) # グラフィックス用
## LakeHuron (ヒューロン湖の湖面の高さの年次推移)
autoplot(LakeHuron) # tsクラスにautoplotを適用すると折線プロットが得られる
acf(LakeHuron) # 指数的に減少?
ggAcf(LakeHuron) # ggplotによるACFのグラフ化(ラグ1から始まる)
## BJsales (ボックス・ジェンキンスの売上高のデータ)
autoplot(BJsales) 
ggAcf(BJsales) # 過去の値の影響が長期間持続する
## sunspot.year (太陽黒点の数の年次推移)
autoplot(sunspot.year) 
ggAcf(sunspot.year) # 周期変動が観察される
