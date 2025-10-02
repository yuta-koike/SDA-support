### 主成分分析と固有値・固有ベクトルの関係
### pca.rの続き
## 固有値分解の計算(xは標準化することに注意)
out <- eigen(crossprod(scale(x)))
out$vectors # 固有ベクトル
mypca$rotation # 符号を除いて上の固有ベクトルと一致
## 各固有値は対応する主成分スコアの分散にサンプル数を
## かけたものに一致しているはずなので, そのことを確認する
lambda <- out$values # 固有値
sqrt(lambda/(nrow(x) - 1)) # 主成分スコアの標準偏差に対応
mypca$sdev
