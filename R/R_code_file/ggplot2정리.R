# ggplot2 패키지
library(ggplot2)
# mpg 데이터
head(mpg)
View(mpg)

# manufacturer : 제조사
# model : 차종 (model name)
# displ : 배기량 (engine displacement)
# year : 연식 (year of manufacture
#            cyl : 엔진 기통 (number of cylinders) (4기통/6기통)
#            trans : 변속기 (type of transmission)
#            drv : 구동방식(the type of drive train)(f = front-wheel drive (전륜구동), 
#                                                r = rear wheel drive(후륜구동), 4 = 4wd(4륜구동)
#                                                cty : 도시 연비 (city miles per gallon)
#                                                hwy : 고속도로 연비 (highway miles per gallon)
#                                                fl : 연료 종류 (fuel type)
#                                                class : 자동차 종류 ("type" of car)

# 배경생성 : displ/hwy 배경 생성
# 배기량에 따른 고속도로 연비 시각화

# 같은결과
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))
ggplot(data=mpg,aes(x=displ, y=hwy))
ggplot(mpg, aes(x=displ, y=hwy))
gr <- ggplot(mpg, aes(displ,hwy))

# 산점도 추가
gr2 <- gr+geom_point() # gr에 x,y값이 이미 들어있다.

# 축범위 지정
gr2 + xlim(3,6)

# x 축범위 3~6, y축 범위 10~30
# + 뒤에서 줄바꾸기 실행 : + 연산자가 행 앞으로 오면 에러
ggplot(mpg, aes(displ,hwy)) + 
  geom_point() +
  xlim(3,6) +
  ylim(10,30)

# 고속도로 연비와 도시연비간의 관계 알아보기(산점도)
ggplot(mpg, aes(x=cty, y=hwy)) +
  geom_point()


# midwest : 미국 지역별 인구통계 정보를 담은 데이터
# 전체인구와 아시아인 인구간에 어떤 관계가 있는지 확인
# 산점도 이용 : 전체인구 50만명 이하
#               아시아인 인구 1만명 이하인 지역만 표시

View(midwest)
ggplot(data=midwest,
       aes(x=poptotal, y=popasian)) +
  geom_point() +
  xlim(0,500000) +
  ylim(0, 10000)

# x축 지표값이 지수표현 : 1e+05
# 지수 표현을 고정형 숫자 표기법으로 변환
# 전역적으로 영향을 미치는 옵션 함수
# option() 함수 사용

options(scipen=100) # 고정형 숫자 표기(x.y축 모두)
options(scipen=-100) # x,y축 둘다 지수 표현 
options(scipen=0) # x축만 지수로 표현

#-------------------------------------------------------
# 막대그래프
# geom_col() : 평균 막대 그래프
# 그래프의 막대 높이가 데이터의 값을 나타내는 그래프
# 데이터 요약한 평균표 먼저 만든 후
# 평균표 이용해 그래프 생성

# 막대 그래프1 - 집단 간 차이 표현하기 
# 막대 그래프(Bar Chart) : 
# 데이터의 크기를 막대의 길이로 표현한 그래프
# 성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용 

# 각 집단의 평균값을 막대 길이로 표현한 그래프 
# 1. 집단별 평균표 만들기
mpg

library(dplyr)
# 구동박식별 고속도로 연비의 평균이 얼마나 차이가 나는지 확인
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy))
df_mpg

table(mpg$drv)
# 2. 그래프 그리기
ggplot(data=df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()

# geom_bar() : 빈도 막대 그래프
# 막대 그래프의 x의 위치에 나타나는 각 그룹의 빈도수를 나타내는 막대 그래프
# 원자료를 이용해서 바로 그래프 생성(별도로 표를 만들지 않는다.)

# 크기 순으로 정렬
ggplot(data=df_mpg, aes(x=reorder(drv, -mean_hwy), # 기준값이 음수면 내림차순
                        y=mean_hwy)) + 
  geom_col()

ggplot(data=df_mpg, aes(x=reorder(drv, mean_hwy), # 기준값이 양수면 오름차순 
                        y=mean_hwy)) + 
  geom_col()

# 평균표를 이용하면 geom_bar() 함수는 에러 발생
# ggplot(data=df_mpg, aes(x=reorder(drv, mean_hwy), 
#                         y=mean_hwy)) + 
#   geom_bar()

#-------------------------
# 막대 그래프2 - 빈도 막대 그래프
# 값의 개수(빈도)로 막대 길이 표현한 그래프

# 1. 범주 변수인 경우
# x 축 : 범주 변수 / y 축 : 빈도
table(mpg$drv) # drv 빈도 확인
#   4   f   r 
# 103 106  25 
ggplot(mpg, aes(x=drv)) + geom_bar()
# ggplot(mpg, aes(x=drv)) + geom_col() 
# y 데이터 필요
# 에러: geom_col requires the following missing aesthetics: y
str(mpg$drv)

# 2. 연속 변수인 경우
# x축 : 연속변수 / y축 : 빈도
ggplot(dat=mpg, aes(x=hwy)) + geom_bar()
str(mpg$hwy)
table(mpg$hwy)

# Q1. 어떤 회사에서 생산한 'suv' 차종의 도시 연비가 높은지 알아보려고 함
# 'suv' 차종을 대상으로 평균 cty(도시연비)가 가장 높은 회사 다섯 곳을
# 막대그래프로 표현
# 막대는 연비가 높은 순으로 정렬

# 1. 평균표 생성
df <- mpg %>% 
  filter(class=='suv') %>%
  group_by(manufacturer) %>%
  summarise(mean_cty=mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)
df

# 2. 그래프 생성
ggplot(data=df, aes(x=manufacturer,
                    y=mean_cty)) +
  geom_col()

# x축 값 정렬 : reorder(x축 변수, 정렬할 값) 함수 사용
# 기본 : 오름차순
# 내림차순 : -정렬 할 값
ggplot(data=df, aes(x=reorder(manufacturer, -mean_cty),
                    y=mean_cty)) +
  geom_col()

# Q2. 자동차 중에서 어떤 class(자동차 종류)가
# 가장 많은지 알아보려고 합니다.
# 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
ggplot(mpg, aes(x=class)) + geom_bar()

#--------------------------------------------------------

# geom_bar() 그래프의 stat 옵션과 position 옵션

# stat 옵션 : y축 값 사용 방법

# stat='count' : 빈도수 계산 (디폴트: 생략 가능)
#                - x축 값만 지정
#                - y축 값 : x축 값의 빈도수
#                - ggplot(data = diamonds, aes(x=cut))

# stat='identity' : y축 값의 높이를 데이터를 기반으로 정해줄 때 사용
#                  - ggplot(data = sleep, aes(x=ID, y=extra))

# 데이터세트 : diamonds
diamonds
table(diamonds$cut)

# 같은 표현
ggplot(data=diamonds, aes(cut)) + geom_bar()
ggplot(data=diamonds, aes(cut)) + geom_bar(stat='count')

# stat='identity' : y축 값의 높이를 데이터를 기반으로 정해줄 때 사용
ggplot(data=diamonds, aes(cut)) + geom_bar(stat='identity')
# y 데이터가 없어서 에러 발생
# 에러: geom_bar requires the following missing aesthetics: y

#-------------------------------------------------------
# position='dodge' : 막대의 위치를 개별적인 막대로 나란히 표현
# position='fill' : 데이터의 종류를 비율로

# sleep 데이터 사용

# position='dodge' : 막대의 위치를 개별적인 막대로 나란히 표현
# beside=T와 같은 모습
ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position = 'dodge')


# fill = 변수 : 데이터의 종류를 비율로 표시
ggplot(diamonds, aes(color, fill=cut)) +
  geom_bar(position='fill')

#-------------------------------------------------
# coord_flip() : 가로막대 그래프
ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity') + # position 생략 : 누적 가로 막대 그래프
  coord_flip()

ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position='dodge') + # 묶음 가로 막대 그래프
  coord_flip()

ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position='fill') + # 비율 가로 막대 그래프
  coord_flip()

#--------------------------------------------------
# 선 그래프 -시계열 그래프(Time Series Chart)
# 데이터를 선으로 표현한 그래프
# 시간에 따라 달라지는 데이터 표현# 
# 일정 시간 간격을 두고 나열된 
# 시계열 데이터(Time Series Data)를 선으로 표현한 그래프 
# 환율, 주가지수 등 경제 지표가 시간에 따라 
# 어떻게 변하는지 표현할 때 활용

# economics
# pop : total population
# psavert : personal savings rate
# uempmed : median duration of unemployment
# unemploy : number of unemployed

economics
ggplot(data=economics, aes(date,unemploy)) + geom_line()

# 시간에 따라서 개인 저축률 변화에 대한 그래프 생성
ggplot(data=economics, aes(date,psavert)) + geom_line()

# boxplot
# 데이터 분포(퍼져 있는 형태)를
# 직사각형 상자 모양으로 표현한 그래프
# 집단 간 분포 차이 표현할 때 사용
# 분포를 알 수 있기 때문에 평균만 볼 때보다
# 데이터의 특성을 좀 더 자세히 이해할 수 있음

ggplot(mpg, aes(drv,hwy)) + geom_boxplot()


# 연습문제 4
# Q1. class(자동차 종류)가
# 'compact','subcompact','suv'인 자동차의
# cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다.
# 세 차종의 cty를 나타낸 상자 그림으로 만들어보세요.

# 세 차종만 분류
mpg %>% 
  filter(class %in% c('compact','subcompact','suv')) %>%
  ggplot(aes(x=class,y=cty)) + geom_boxplot()

#---------------------------------------------------------

# 그래프 함수의 주요 옵션은 그래프에 대한 색상/모양/크기/넓이 등에 초점

# colour = "색상"
# shape(pch) = 모양
# size = 크기
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "red",
             shape = 1,
             size = 2)

# -----------------------fill 옵션 확인------------------------------
# Orange 데이터 세트 사용
str(Orange)

# fill : 도형에 색을 채워줄 때 사용
# 오렌지 나무 종류별 둘레의 합을 도식화

Orange %>%
  group_by(Tree) %>% 
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + 
  geom_bar(stat='identity', fill='red') 

Orange %>%
  group_by(Tree) %>% 
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill='red')) + 
  geom_bar(stat='identity') 

Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) + 
  geom_bar(stat='identity')

# Orange %>%
#   group_by(Tree) %>%
#   summarize(Sum.circumference = sum(circumference)) %>%
#   ggplot(aes(Tree, Sum.circumference)) + 
#   geom_bar(stat='identity', fill=Tree) # Tree 변수 값을 찾을 수 없음
# Error in layer(data = data, mapping = mapping, stat = stat, geom = GeomBar,  : 
#                  객체 'Tree'를 찾을 수 없습니다

# fill 위치
# fill=색상 : aes() 안에 있어도 되고,
# geom_bar() 안에 있어도 된다.
# 단, 색상값이 아닌 변수 값을 그래프의 색상으로 결정하고자 한다면
# aes() 함수 안에서 사용되어야 함

#----------범례 순서 변경
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) + 
  geom_bar(stat='identity') +
  scale_fill_discrete(breaks=c('1','2','3','4','5'))

#-----------------color : 선의 색상 지정할 대 사용
Orange %>% 
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference))+
  geom_bar(stat='identity', color='red', fill='white') 

Orange %>% 
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, color=Tree))+
  geom_bar(stat='identity',  fill='white') 

# Orange %>%
#   group_by(Tree) %>%
#   summarize(Sum.circumference = sum(circumference)) %>%
#   ggplot(aes(Tree, Sum.circumference, color=Tree))+
#   geom_bar(stat='identity', color=Tree, fill='white')
# Error in layer(data = data, mapping = mapping, stat = stat, geom = GeomBar,  : 
#                  객체 'Tree'를 찾을 수 없습니다

#---geom_line() 함수 : color 옵션 설정
# 1번 나무의 나이별 성장을 나타낸 그래프
Orange %>%
  filter(Tree==1) %>%
  ggplot(aes(age,circumference)) + geom_line()

# 선색상 지정
Orange %>%
  filter(Tree==1) %>%
  ggplot(aes(age,circumference)) + geom_line(color='red')

# 선 위에 point 추가
Orange %>%
  filter(Tree==1) %>%
  ggplot(aes(age,circumference)) + 
  geom_line(color='red') +
  geom_point(size=2)

# 전체 데이터에 대해 나무의 나이별 성장을 나타내 그래프
Orange %>%
  ggplot(aes(age, circumference, color=Tree)) +
  geom_line(size=2) +
  geom_point(shape=2, size=6, color='red')

#------------------------------------------------------------------------
# 좌표계 설정 : 직교 좌표계(카테시안 좌표계)

# 르네 데카르트 : xy 평면 개발
# 데카르트 좌표계 또는 카테지안 좌표계
# 프랑스식 이름 : 데카르트
# 라틴어식 이름 : 카르테시우스

# coord_cartesian() 함수 :
# ggplot2에서는 coord_cartesian() 함수를 통해 
# X, Y축을 변경할 수 있으며 
# xlim, ylim, expand 세가지 인자를 가지고 있음

# xlim, ylim : x축과 y축의 범위를 제한 할 때 사용

# faithful 데이터 세트 사용 :
# 미국 옐로스톤 국립공원의 올드 페이스 풀 간헐천의 
# 분화와 분화 사이의 대기시간을 기록한 데이터

# faithful
# 자료설명 : 미국 Yellowstone 국립공원내에 있는 여러 간헐천 중에서
# Old Faithful Geyser 에서 수집된 자료로서
# 2개의 변수와 272개의 관측치로 구성
# 변수 : eruptions (분출시간 (단위:분))
# waiting (다음 분출될 때까지의 시간 (단위:분))

View(faithful)
# 절대값(직접 숫자 지정) 범위를 제한
ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(xlim = c(60,80), ylim = c(2,4))

# 상대값(min, max 를 활용하여 지정)
ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(xlim = c(min(faithful$waiting)-5, 
                           max(faithful$waiting)+5))

# expand : 축과 데이터의 겹침을 방지하여 
# 데이터를 플롯에 온전히 표기하기 위해 
# 약간의 여백을 주는 인자
# 디폴트값(초기값)은 TRUE로 설정되어 있으며  
# FALSE로 설정 시 그래프의 여백이 사라지게 됨

ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(expand = TRUE)

ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(expand = FALSE)


#-----------------------------------------------------------
# 기존 색상 위에 다른 색상을 입혀주는 함수
# scale 패키지의 scale_fill_manual()
# fill 변수가 색상을 채우는(fill) 방법을 지정

# -------------- 범례 수정
# values : 색상
# name : 범례 제목
# breaks : 범레에 나타나는 변수값
# labels : 범례 설명 
# limits : 실제 시각화되는 범주


# mpg 데이터 세트에서 class 종류 확인
distinct(mpg, class) # 한 번씩만 출력 (중복 제거)

g <- ggplot(data=mpg, aes(x=class, fill=class)) + geom_bar()
g

# values : 색상
# name : 범례 제목
g + scale_fill_manual(
  values = c("navy", "blue", "royalblue", 
             "skyblue", "orange", "gold", "yellow"),
  name = "자동차 종류")

# breaks : 범례에 나타나는 변수값
g + scale_fill_manual(
  values = c("navy", "blue", "royalblue", 
             "skyblue", "orange", "gold", "yellow"),
  name = "자동차 종류",
  breaks = c("compact", "suv"))

# labels : 범례 설명 
g + scale_fill_manual(
  values = c("navy", "blue", "royalblue", 
             "skyblue", "orange", "gold", "yellow"),
  name = "자동차 종류",
  breaks = c("compact", "suv"),
  labels = c("경차", "SUV"))

# limits : 실제 시각화되는 범주
g + scale_fill_manual(
  values = c("navy", "blue", "royalblue", 
             "skyblue", "orange", "gold", "yellow"),
  name = "자동차 종류",
  breaks = c("compact", "suv"),
  labels = c("경차", "SUV"),
  limits = c("compact", "suv"))

# scales 패키지의 scale_fill_manual() 함수
# 기존의 색상 위에 다른 색상을 입혀주는 함수
# scale_fill_manual을 적용하기 전에 
# fill, 혹은 color함수를 먼저 적용해준 후 사용해야 함
# 그래프의 종류에 따라 fill과 color를 다르게 적용해줌
# line 그래프 : scale_color_manual()
# bar 그래프 : scale_fill_manua()

library(scales)

p <- Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference=sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) +
  geom_bar(stat='identity')

p

# scales 패키지의 scale_fill_manual() 함수를 통해 
# 각각의 그래프에 색상을 지정
p + scale_fill_manual(values = c( "#FFFFFF", 
                                  "#FFCC00", 
                                  "#FF9900", 
                                  "#FF6600", 
                                  "#FF3300"))

# 색상 팔레트 : palette 를 지정하면 색상이 순서대로 지정
# scale_fill_brewer : 팔레트 지정하는 함수
p + scale_fill_brewer(palette = 'Greens')
p + scale_fill_brewer(palette = 'Blues')
p + scale_fill_brewer(palette = 'Reds')
p + scale_fill_brewer(palette = 'Spectral')

# direction = -1 : 팔레트에서 적용되는 색상의 순서를 반대로 변경
p + scale_fill_brewer(palette = 'Greens', direction=-1)

#------------------------------------------------------------------
# 그래프에서 범주형 변수

# mtcars 데이터 세트의 cyl 변수
# cyl 변수 : numeric 타입 / 4, 6, 8의 값을 가짐
# geom_bar()에서 x 축의 값을 cyl로 지정하면
# y축 값은 4, 6, 8 각각의 빈도수로 설정됨

str(mtcars$cyl)

# factor() 함수를 사용하지 않고 그래프를 그린 경우
ggplot(mtcars, aes(x = cyl)) + geom_bar()

# 막대 굵기 지정 : width = 0.5
ggplot(mtcars, aes(x = cyl)) + geom_bar(width = 0.5)
# 굵기를 줄이니까 x값 4, 6, 8에만 막대 표시 (종류별 빈도 수)
# 문제 : 빈 범주가 표시됨


# factor() 함수 사용
# 값이 있는 범주만 인식되고 나머지는 생략
ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = 0.5)

# factor()에서 level을 지정하여 순서 변경 가능
ggplot(mtcars, aes(x = factor(cyl, level=c('8','6','4')))) +
  geom_bar(width = 0.5)

# 'fill = 범주값'인 경우
# (1) position = "dodge"인 경우
# position='dodge' : 막대의 위치를 개별적인 막대로 나란히 표현
# fill에서 am을 factor()으로 한 경우
ggplot(data=mtcars, aes(x=cyl, fill=as.factor(am))) +
  geom_bar(position = "dodge") 

# (2) position = "fill"인 경우
ggplot(data=mtcars, aes(x=cyl, fill=as.factor(am))) +
  geom_bar(position = "fill")

# 범례 제목 변경
ggplot(data=mtcars, aes(x=cyl, fill=as.factor(am))) +
  geom_bar(position = "dodge") +
  labs(fill ="am")

#---------------------------------------
# 범례 표시 - 위치 변경
# 범례 위치 변경 : teme(legend.position = '위치')
# top / bottom/ right / left / none
# 디폴트 : right

d1 <- ggplot(iris, aes(Petal.Length, Petal.Width)) +
  geom_point(aes(color=Species))
d1

d1 + theme(legend.position = 'top')
d1 + theme(legend.position = 'left')
d1 + theme(legend.position = 'right')
d1 + theme(legend.position = 'bottom')
d1 + theme(legend.position = 'none') # 범례 표시 안함

d1 + theme(legend.position = 'bottom',
           legend.direction = 'vertical')

d1 + theme(legend.direction = 'horizontal')

# legend.title = element_text(face=, color=, size=)
# title : 범례 제목 설정
# face=4 : 굵게 기울이기
# face	Font face ("plain", "italic", "bold", "bold.italic")
d1 + theme(legend.title = element_text(face = 4,
                                       color = 'red',
                                       size = 15))


#------------------ 그래프 제목 설정
ggplot(data=mtcars, aes(x=cyl, fill=as.factor(am))) +
  geom_bar(position = "dodge") + 
  labs(x = "cyl (실린더)",
       y = "am count (빈도)",
       title = "cyl vs am count 분석",
       subtitle = "막대그래프 이용하기",
       caption = "출처 = 본인작성",
       fill ="AM") + # 범례 제목 변경
  theme(plot.title = element_text(face="bold",
                                  size=20,
                                  hjust=0.5),
        legend.position = "bottom")

#------------- 막대그래프에 레이블 추가
# 빈도 막대 그래프
# geom_text(stat="count") 변수 ..count..를 사용해서 레이블 출력
ggplot(mtcars, aes(x=factor(cyl), y=..count.., fill=as.factor(am))) +
  geom_bar(position='stack') +
  geom_text(stat="count",
            aes(label=..count..),
            position=position_stack(),
            vjust=5)

ggplot(mtcars, aes(x=factor(cyl),y=..count.., fill=as.factor(am))) +
  geom_bar(position='dodge', width=0.5) +
  geom_text(stat="count",
            aes(label=..count..),
            position=position_dodge(width = 0.5), # geom_bar() position 인수와 같은 함수 사용
            vjust=-0.5)

ggsave("a.jpg", dpi=300) # 이미지로 저장
