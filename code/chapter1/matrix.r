## 関数matrixの使い方
x <- c(2, 3, 5, 7, 11, 13)
matrix(x, 2, 3) # 2x3行列
(X <- matrix(x, ncol = 3)) # 列数指定(行数はそれに合わせて決まる)
(Y <- matrix(x, ncol = 3, byrow = TRUE)) # 横に並べる
## その他の操作
nrow(X) # 行数
ncol(X) # 列数
X[1, 2] # (1,2)成分
X[2, ] # 2行目
X[, 3] # 3列目
as.vector(X) # ベクトルxに戻る
dim(x) <- c(2, 3) # ベクトルに次元属性を与えて行列化
x # 行列Xになる