### 対応のあるデータに対する平均の検定
### データセットsleepによる例
### group 1とgroup 2の睡眠薬で効能に差があるか検定する
## 対応を考慮しないt検定(ウェルチのt検定)
t.test(extra ~ group, data = sleep) 
## 対応を考慮するt検定
## 対応はデータの並び順でつけられる. 今の場合, データの並び順は
## 被験者番号となっているので, 同じ被験者に投与したデータどうし
## で対応をつけることになる
(x <- subset(sleep, group == 1, extra, drop = TRUE)) # gropu 1の睡眠薬による睡眠時間の伸び
(y <- subset(sleep, group == 2, extra, drop = TRUE)) # gropu 2の睡眠薬による睡眠時間の伸び
t.test(x, y, paired = TRUE) # 対応を考慮するt検定
t.test(x - y) # 上と同じ 