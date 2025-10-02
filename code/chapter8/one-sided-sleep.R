### 平均に対する片側検定: データセットsleepによる例
### データセットsleep
### 10人の被験者にある睡眠薬を投与した際の睡眠時間の増減のデータ
### extra: 睡眠時間の増減
### group: 投与した睡眠時間の種類(2種類)
### ID: 被験者番号
### 詳細はhelp(sleep)参照
### 2種類の睡眠薬のそれぞれについて睡眠時間が平均的に増加したか否かを検定
library(dplyr)
x <- sleep |> 
  filter(group == 1) |> # group 1の睡眠薬のデータのみ抽出
  dplyr::select(extra) # 睡眠時間の増減のデータのみ抽出
t.test(x, mu = 0, alternative = "greater")
y <- sleep |> 
  filter(group == 2) |> # group 2の睡眠薬のデータのみ抽出
  dplyr::select(extra) # 睡眠時間の増減のデータのみ抽出
t.test(y, mu = 0, alternative = "greater")
