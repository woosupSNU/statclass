print("hello World")

a<-2
a
a<-3
a
#원소를 더 넣고 싶은 경우
a<-c(3,5)
a<-c(1,3,5)

##R에서 쓰이는 변수 유형
#numeric (real or decimal): 2, 2.0, pi
#character : "a", "work"
#complex : 1+4i
#logical : true of false
#integer : special case of numeric dat without decimals 

#scalar, vector, array, list, dataframe의 이해
scalar<-1
scalar
scalar<-"stat"
#vector : 여러개의 원소들이나 하나의 row
vector <-c(1,2,3)
vector
vector<-c("v","rm","suga")

#matrix : 2*2, 2*3의 행렬 (vector를 여러개의 row로 쌓은형태)

matrix <-matrix(c(1,2,3,4,5,6), nrow=3)
matrix
matrix <-matrix(c(1,2,3,4,5,6), nrow=2)
matrix
matrix <-matrix(c(1,2,3,4,5,6), nrow=2, byrow=TRUE)
matrix
matrix <-matrix(c(1:20), nrow=4, ncol=5)
matrix
mat1 <-c(1:3)
mat2 <-c(4:6)
matrix<-c(mat1, mat2)
matrix
matrix <-cbind(mat1, mat2)  #cbind : column을 기준으로 횡으로 붙이기
matrix
matrix <-rbind(mat1, mat2)  #rbind : row을 기준으로 종으로 붙이기
matrix

#특정 위치의 요소 추출 및 치환
matrix[1,2]
matrix[1:2]
matrix[1,] #첫번째 row의 모든 원소를 추출
matrix[,1] #첫번째 col의 모든 원소를 추출
matrix[c(1,2),] #1,2번째 row의 모든 원소를 추출
matrix[1,2]=100
matrix

#array : matrix를 여러층으로 쌓은것
matrix1<- matrix(c(1:9), nrow=3)
matrix1
matrix2<- matrix(c(10:18), nrow=3)
matrix3<- matrix(c(19:27), nrow=3)
matrix2
matrix3
array <-array(c(matrix1, matrix2, matrix3), dim=c(3,3,3))
array

#지금까지 살펴본 vector, matrix, array는 
#모두 같은 특성의 데이터로만 구성되어 있음. 
#즉 character, logic, numeric의 한종류
#일반적으로 쓰는 데이터는 문자변수, 
#숫자변수 등이 하나의 데이터셋에 담겨있음. 
#이 경우 쓰는 것이 dataframe. 
#앞으로 우리가 쓰는 대부분의 데이터는 dataframe일 것임

btsname <-c("RM", "Jin", "suga","jhope", "jimin", "V", "JK")
btsyear <-c(1994, 1992, 1993, 1994, 1995, 1995, 1997)
btsposition <-c("rap", "vocal", "rap", "rap", "vocal", "vocal","vocal")
bts <-data.frame(btsname, btsyear, btsposition)
bts   
str(bts) #structure, 자료의 구조를 보여주는 것

bts <-data.frame(btsname, btsyear, btsposition, stringsAsFactors = TRUE)
str(bts)

#factor의 이해
#factor란 주로 categorical한 변수로서 "값"(일반벡터)에 "level"이라는 정보를 추가한 것

gender=factor(c("male", "female", "female", "male"))
gender
str(gender)

##level의 순서를 바꾸고 싶거나, referece group 설정을 위해서는 leves=c() 사용
gender=factor(gender, 
              levels=c("male", "female"))
gender
str(gender)

#dataframe 활용
#변수 선택 $표시 활용
bts$btsname
bts$btsposition
bts$btsposition=factor(btsposition, levels=c("vocal", "rap"))
bts$btsposition
bts$age <- 2021-bts$btsyear+1
bts
bts$null <-NULL
bts
bts$na <-NA
bts
dim(bts)
#na=not available의 약자. 결측치를 의미함
#NULL=존재하지 않는 값
#na와 null의 차이는 mean 산출시 확인 가능
#null은 자동으로 무시되어 mean 산출
#na는 평균에 영향을 미침. 따라서 na.rm=TRUE 옵션을 통해 
#na를 무시하고 평균을 구할 수 있음

bts
bts[1,5]<-3
bts[2,5]<-5
bts[3,5]<-1
mean(bts$na)

bts[1,4]<-NA    #대괄호는 indexing, [row, column] 순서를 기억하자
mean(bts$age)
mean(bts$na, na.rm=TRUE) #na remove
bts

#작업 디렉토리 설정하기 -> r project를 쓰지않고 script를 개별 저장관리할 경우
getwd()
# setwd("C:\\Users\\Owner\\Documents\\new") ##자료 저장 directory 설정



#02 dplyr 활용법 참조
install.packages("dplyr")
library(dplyr)

### 1.dplyr소개   ##############################################################
##주로 데이터 전처리 과정에서 자주 사용
##데이터 전처리는 연구의 분석 목적에 따라 데이터를 재구조화, 
#필터링(특정 변수값을 가진 데이터만 선택), 특정변수만 선택하거나(select),
#정렬(ordering), 새로운 변수를 만들어(mutate, trasformate)내는 등의 작업임

### 2.chain operator, %>%  #####################################################
##dplyr의 강점은 chain operator를 사용하여 코드를 심플하게 짤수 있다는 점
##chain operatr는 "and then"의 문법과 같이 의미로 사용. 원래는 괄호()가 이 기능수행
##직관적인 코딩을 가능하게 하며, 소괄호 갯수 실수를 줄일 수 있음
##단축어: ctrl+shif+M 

##chain oeprator 미사용시
x<-c(30, 20, 10, 0)
sqrt(mean(abs(x)))
##chain oeprator 사용시 (X를 가져오고 and then, absolute value산출 and then~~~)
x %>% 
  abs() %>%
  mean() %>%
  sqrt

#특정함수에 대한 도움말 참조
help(abs)

## 숫자형 벡터 처리 함수
# abs(x) : 절대값
# sqrt(x) : 제곱근
# ceiling(x) : x보다 크거나 같은 정수
# floor(x) : x보다 작서나 같은 정수
# truc(x) : 소숫점 이하 절삭
# round(x, digits=n) : 소수점 n자리로 반올림
# log(s, base=n) :밑이 n인 log 
# exp(x) : 지수 변환
# factorial(x) : factorial(3! = 3*2*1)


### 3.dplyr의 주요 기능  #######################################################
### 3.1.filter           #######################################################
##filter는 특정 변수가 특정값을 가지는(예: 성별=여자) 행(row)을 선택하는 기능
##즉 dataset을 횡으로 절단하는 기능

#select = 변수를 선택



##분석에 앞서서 R 내장 데이터를 불러오자
install.packages("nycflights13")
library(nycflights13)
head(flights) # head 자료 수개를 보여줌
flight_df <-data.frame(flights) #data frame으로 변환
#시작하기 전에 데이터구조 파악 필수! : 데이터가 336776개, 19개의 변수가 있는 비행기 출도착 관련
str(flight_df)
##month=2인 자료만 subset
flight_df %>% 
  filter(month==2) %>%
  count(month)##데이터가 너무 기니까 앞에 5개만 print

table(flight_df$month) #filter 전의 값을 보기위한 함수

flight_df %>% 
  filter(month==2) %>%
  count(month)##month 자료만 봄으로서 filtering 여부를 확인

##month=2 or day=1  자료만 subset
flight_df %>% 
  filter(month==2 | day==1) %>% #shift+\
  head(5)

##month=2 and day=1  자료만 subset
flight_df %>% 
  filter(month==2, day==1)  #쉼표나 & 모두 사용 가능
##month=2가 아닌 자료만 subset
flight_df %>% 
  filter(month!=2)  #느낌표는 not의 의미(!+=), 등호는 한번만 쓰는것을 주의
##month가 5이상인 자료만 subset
flight_df %>% 
  filter(month >=5)  #  >+=
##month가 5, 7, 10인 자료만(복수의 조건) subset
flight_df %>% 
  filter(month %in% c(5,7,10))
##na 값 표시 또는 제거 해서 subset
flight_df %>% 
  filter(is.na(month)) #na인 row만 표시

flight_df %>% 
  filter(!is.na(month)) #na가 아닌 row만 표시

### 3.2.select #######################################################
##select는 특정 변수를 선택하는 기능(열(colomn) 선택)
##즉 dataset을 종으로 절단하는 기능

##month, day 변수만 선택해서 저장
select_flight_df<-
  flight_df %>%
  select(month, day)

str(select_flight_df)
##year에서 day까지의 변수만 선택해서 저장 (연속변수 선택)
select_flight_df<-
  flight_df %>%
  select(year:day) 
str(select_flight_df)

##year에서 day까지의 변수만 제외해서 선택해서 저장 
select_flight_df<-
  flight_df %>%
  select(! year:day) #year~day 까지 변수 제외하고 선택

select_flight_df<-
  flight_df %>%
  select(-c(year, month)) #year, month 변수 제외하고 선택

### 3.3.arrange #######################################################
##arrange는 정렬 기능(특정변수(들) 기준으로 오름차순 또는 내림차순으로 정렬)

##month, day 순으로 오름차순
arrange_flight_df<-
  flight_df %>%
  arrange(month, day) 

##month는 오름차순, day는 내림차순
arrange_flight_df<-
  flight_df %>%
  arrange(month, -day) 
#또는
arrange_flight_df<-
  flight_df %>%
  arrange(month, desc(day))

##month, day 순으로 내림차순
arrange_flight_df<-
  flight_df %>%
  arrange(-month, -day) 
#또는
arrange_flight_df<-
  flight_df %>%
  arrange(desc(month), desc(day))


### 3.4.mutate ######################################################
##mutate는 새로운 변수를 만들어줌(파생변수(derived variables)생성)

#연산을 통해 새로운 변수 생성
flight_df %>%
  mutate(mean_distance=distance/hour, 
         ratio_delay=arr_delay/(hour*60+minute))

#ifelse를 활용하여 category변수 생성
flight_df %>%
  mutate(arr_delay_group=ifelse(arr_delay>0, "delay", "no delay"))


#별도 저장을 하지 않으면 명령어 실행시에만 변수가 생성됨
#별도 저장을 하는 명령어를 추가해야 함
mutate_flight_df<-
  flight_df %>%
  mutate(arr_delay_group=ifelse(arr_delay>0, "delay", "no delay"))


#별도 저장은 마지막에 써도 가능(화살표는 반대, logic을 생각하면 직관적 이해 가능)
flight_df %>%
  mutate(arr_delay_group=ifelse(arr_delay>0, "delay", "no delay"))->mutate1_flight_df
