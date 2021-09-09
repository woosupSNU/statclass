1+1
245*190

## 2주차

typeof(10L)


a <- c("ha","kim","park","bae")
a <- factor(a)
b <- c('f','m','f','m')
b <- factor(b)
c <- c(1,2,3,4)
d <- data.frame(a,b,c)
d <- data.frame(name=a, gender=b, number=c)


str(d)

getwd() #현재설정된 working directory 확인
setwd("C:\\") ##워킹디렉토리 설정

install.packages("readxl")
library(readxl)

a <- read_excel("data_excel.xlsx")

View(a) #객체를 실제로 확인하려는 경우
str(a) #자료 구조 파악
summary(a) #해당 객체의 각 변수별 요약 통계량 제시 (최소값, 중위값, 평균, 3분위수, 최대값)
summary(a$score) #특정 변수의 요약 통계량 제시