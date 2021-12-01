library(dplyr)
data<- read.table("HCCP_Work_7th.txt", header=T, sep="\t")
manu<- data[data$W7_posit==4,]
select_data<-
  manu %>%
  select(W729_01,W725_01,W725_03,W712_01,W712_02,W728_01,W728_02)
select_data<- select_data %>%
  mutate(W729_01_r= 6-W729_01, W725=(W725_01+W725_03)/2, W712=(W712_01+W712_02)/2)
summary(select_data)
sd(select_data$W729_01_r)
sd(select_data$W725_01)
sd(select_data$W725_03)
sd(select_data$W712_01)
sd(select_data$W712_02)
sd(select_data$W728_01)
sd(select_data$W728_02)

a1<-lm(W729_01~W725_01+W725_03, data=select_data)
a2<-lm(W729_01~W712_01+W712_02, data=select_data)
a3<-lm(W729_01~W728_01, data=select_data)
a4<-lm(W729_01~W728_02, data=select_data)
summary(a1)
summary(a2)
summary(a3)
summary(a4)
a5<-lm(W729_01_r~W725_01+W725_03+W712_01+W712_02+W728_01+W728_02, data=select_data)
summary(a5)
a6 <-lm(W729_01_r~W725+W712+W728_01+W728_02, data=select_data)
summary(a6)

cor(select_data$W725_01, select_data$W725_03, select_data$W712_01, select_data$W712_02, select_data$W728_01, select_data$W728_02)

cor(select_data[,(2:7)])
#=============================
install.packages("funModeling")
library(funModeling)
funModeling::df_status(select_data)
funModeling::plot_num(select_data)
funModeling::profiling_num(select_data)
funModeling::freq(select_data$W729_01_r)
funModeling::status(select_data)
