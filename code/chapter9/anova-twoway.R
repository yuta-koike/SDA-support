### 二元配置の分散分析(sleepデータによる例)
## 2種類の睡眠薬の効能は異なるか? (有意水準5%では棄却できない)
oneway.test(extra ~ group, data = sleep, var.equal = TRUE) 
## 薬の効き目の個人差をコントロールするために, 薬の種類と
## 被験者IDという2つの因子を考慮した分散分析を実行
(result <- aov(extra ~ group + ID, data = sleep)) 
summary(result) # 分散分析表(棄却される)
## いまの場合, 因子groupは2つの水準しか持たないため, 検定統計量
## Fは「対応のあるt検定」の検定統計量の二乗と同一のものとなるので,
## 検定結果はその場合と同じになる
model.tables(result, type = "means") # 水準ごとの効果
model.tables(result, type = "effects") # 水準ごとの相対効果
