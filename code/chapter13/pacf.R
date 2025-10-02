### RのさまざまなデータセットのPACF
library(forecast) # グラフィックス用
ggPacf(LakeHuron) # ラグ3以降はほぼゼロ
ggPacf(BJsales) # ラグ2以降はほぼゼロ. ACFとかなり異なる
ggPacf(sunspot.year) # ACFと異なりラグ2の値が負
