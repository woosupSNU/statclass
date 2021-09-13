install.packages("ggplot2")
library(ggplot2)
data("mpg")
View(mpg)

##객체를 지정하는 방식
a <- ggplot(data=mpg, aes(x=displ, y=hwy))

a+geom_point() #산포도 그리기
a+geom_point()+facet_grid(.~fl)

b<-ggplot(data=mpg, aes(x=displ))
b+geom_histogram() #히스토그램 (변수가 하나일때만 작동)

c<-ggplot(data=mpg, aes(x=manufacturer, y=displ))
c+geom_boxplot() #boxplot

#bar chart
a <- ggplot(data=mpg, aes(x=displ, y=hwy))
a + stat_summary(fun.y=mean, geom="bar") #x값에 해당되는 y값의 평균을 나타냄

a + stat_summary(fun.y=mean, geom="line")