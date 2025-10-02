par(family = "Osaka") # plot()の場合
theme_set(theme_gray(base_family = "Osaka")) # ggplot()の場合
## 利用可能なフォントを調べるためには
## パッケージsystemfontsの関数system_fonts()などを使うとよい
## 例: 名前に "hira" が付くフォント(ヒラギノフォント)を調べる 
## library(systemfonts)
## grep("hira", system_fonts()[["name"]], ignore.case=TRUE, value=TRUE)
