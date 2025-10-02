## 関数cholの使い方
(A <- matrix(c(5,1,1,3),2,2)) 
(R <- chol(A)) # コレスキー分解
t(R) %*% R # Aに戻ることを確認
crossprod(R) # 上式と同義
# chol(matrix(c(0,1,1,0),2,2)) # 正定値でないとエラー