library(dplyr)
data<- read.table("HCCP_Work_7th.txt", header=T, sep="\t")
manu<- data[data$W7_posit==4,]
select_data<-
  manu %>%
  select(W729_01,W725_01,W725_03,W712_01,W712_02)
summary(select_data)
sd(select_data$W729_01)
sd(select_data$W725_01)
sd(select_data$W725_03)
sd(select_data$W712_01)
sd(select_data$W712_02)

a1<-lm(W729_01~W725_01+W725_03, data=select_data)
a2<-lm(W729_01~W712_01+W712_02, data=select_data)
summary(a1)
summary(a2)


#=============================
install.packages("funModeling")
library(funModeling)
funModeling::df_status(select_data)
funModeling::plot_num(select_data)
funModeling::profiling_num(select_data)
funModeling::freq(select_data$W729_01)
funModeling::status(select_data)
