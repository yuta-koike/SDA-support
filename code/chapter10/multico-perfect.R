### 完全な多重共線性の例
### 実行例dummy-kikou.rの続き
### 月の他に「季節」という変数を新たに作成して
### 説明変数に加えるとどうなるか見てみる
## 「季節」という説明変数の作成
season <- character(nrow(kikou))
season[kikou$月 %in% c(12,1,2)] <- "冬"
season[kikou$月 %in% 3:5] <- "春"
season[kikou$月 %in% 6:8] <- "夏"
season[kikou$月 %in% 9:11] <- "秋"
kikou$季節 <- season
str(kikou) # 確認
## 気温を降水の有無・月・季節で回帰してみる
lm(気温 ~ 降水の有無 + 月 + 季節, data = kikou)
# 季節のダミー変数の回帰係数がすべてNAとなっている
# 季節ダミーが月ダミーの一次結合で表せることが原因
## 説明変数の順序を変えると結果も変わる
lm(気温 ~ 降水の有無 + 季節 + 月, data = kikou)