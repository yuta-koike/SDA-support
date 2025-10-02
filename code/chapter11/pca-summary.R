## 寄与率
## pca-plot.rの続き
summary(mypca) # 第三主成分までの累積寄与率が80%を超えている
plot(mypca) # スクリープロット(各主成分の分散を棒グラフで表示)
## 上の結果を踏まえて, 第三主成分の解釈を考える
## 第二・第三主成分スコアに対するバイプロット
autoplot(mypca, data = kikou, colour = "季節",
         x = 2, # x座標に第二主成分をとる
         y = 3, # y座標に第三主成分をとる
         loadings = TRUE, loadings.colour = "black",
         loadings.label = TRUE, loadings.label.colour = "black",
         loadings.label.family = "Osaka") +
  scale_color_manual(values = c(春 = "green", 夏 = "red", 
                                秋 = "orange", 冬 = "lightblue"))
# 第三主成分は負の向きに風速と降水量を多く含み, その他の変数は
# あまり含まない. 
# そのため, 「風雨が強い日か否か」を表す成分ではないか
# と推察される(負の方向に風雨が強い日が来る)
# 第三主成分が著しく低い日がいくつかあるので, 
# 特に最小の日の気象状況を確認してみる
## 第三主成分が最も低いデータの番号を抽出
idx <- which.min(mypca$x[ ,3])
## 日付の確認
kikou[idx, c("月","日")]
## 2021/10/1は, 関東に台風16号が接近して非常に風雨が強かった