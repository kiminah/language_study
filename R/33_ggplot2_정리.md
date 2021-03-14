# ggplot2 정리



## 01. 기본 작성법

```R
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))
ggplot(data=mpg,aes(x=displ, y=hwy))
ggplot(mpg, aes(x=displ, y=hwy))
gr <- ggplot(mpg, aes(displ,hwy))
```

## 02. 산점도 추가

```R
gr2 <- gr+geom_point() # gr에 x,y값이 이미 들어있다.

# 고속도로 연비와 도시연비간의 관계 알아보기(산점도)
ggplot(mpg, aes(x=cty, y=hwy)) +
  geom_point()
```

## 03. 축 범위 지정

```R
gr2 + xlim(3,6)

# x 축범위 3~6, y축 범위 10~30
# + 뒤에서 줄바꾸기 실행 : + 연산자가 행 앞으로 오면 에러
ggplot(mpg, aes(displ,hwy)) + 
  geom_point() +
  xlim(3,6) +
  ylim(10,30)
```

## 04. 지표값 지수표현

```R
# x축 지표값이 지수표현 : 1e+05
# 지수 표현을 고정형 숫자 표기법으로 변환
# 전역적으로 영향을 미치는 옵션 함수
# option() 함수 사용

options(scipen=100) # 고정형 숫자 표기(x.y축 모두)
options(scipen=-100) # x,y축 둘다 지수 표현 
options(scipen=0) # x축만 지수로 표현
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311204621475.png" alt="image-20210311204621475" style="zoom: 50%;" />

## 05. 막대그래프

```R
# 구동박식별 고속도로 연비의 평균이 얼마나 차이가 나는지 확인
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy))
df_mpg
```



### geom_col() : 평균 막대 그래프

- 집단 간 차이 표현해주는 그래프

- 데이터의 크기를 막대의 길이로 표현

- 성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용

  

- 그래프의 막대 높이가 데이터의 값을 나타내는 그래프

- 데이터 요약한 <u>평균표 먼저 만든 후</u> 평균표 이용해 그래프 생성

```R
ggplot(data=df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311205034844.png" alt="image-20210311205034844" style="zoom:50%;" />

- 크기 순으로 정렬

  ```R
  ggplot(data=df_mpg, aes(x=reorder(drv, -mean_hwy),
                          y=mean_hwy)) + 
    geom_col()
   # 기준값이 음수면 내림차순
   # 기준값이 양수면 오름차순
  ```

  <img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311205401692.png" alt="image-20210311205401692" style="zoom:50%;" />

### geom_bar()

- 빈도 막대 그래프

- 값의 개수(빈도)로 막대 길이를 표현한 그래프
- 막대 그래프의 x의 위치에 나타나는 각 그룹의 빈도수를 나타내는 막대그래프
- 원자료를 이용해서 바로 그래프 생성(별도로 표를 만들지 않는다.)



- 범주 변수인 경우

  - x 축 : 범주 변수 / y 축 : 빈도

  ```R
  table(mpg$drv) # drv 빈도 확인
  #   4   f   r 
  # 103 106  25 
  ggplot(mpg, aes(x=drv)) + geom_bar()
  # ggplot(mpg, aes(x=drv)) + geom_col() 
  # y 데이터 필요
  # 에러: geom_col requires the following missing aesthetics: y
  ```

  <img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311205750656.png" alt="image-20210311205750656" style="zoom:50%;" />

- 연속 변수인 경우

  - x축 : 연속변수 / y축 : 빈도

  ```R
  ggplot(dat=mpg, aes(x=hwy)) + geom_bar()
  ```

  <img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311205734422.png" alt="image-20210311205734422" style="zoom:50%;" />

#### 1) stat 옵션

- y축 값 사용 방법
- stat='count' 

  - 빈도수 계산 (디폴트: 생략 가능)
  - x축 값만 지정
  - y축 값 : x축 값의 빈도수
- stat='identity'
  - y축 값의 높이를 데이터를 기반으로 정해줄 때 사용

```R
# 같은 표현
ggplot(data=diamonds, aes(cut)) + geom_bar()
ggplot(data=diamonds, aes(cut)) + geom_bar(stat='count')

# stat='identity' : y축 값의 높이를 데이터를 기반으로 정해줄 때 사용
ggplot(data=diamonds, aes(cut)) + geom_bar(stat='identity')
# y 데이터가 없어서 에러 발생
# 에러: geom_bar requires the following missing aesthetics: y
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311210420821.png" alt="image-20210311210420821" style="zoom:50%;" />

#### 2) position 옵션

- position='dodge' : 막대의 위치를 개별적인 막대로 나란히 표현
- position='fill' : 데이터의 종류를 비율로

```R
# position='dodge' : 막대의 위치를 개별적인 막대로 나란히 표현
# beside=T와 같은 모습
ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position = 'dodge')


# fill = 변수 : 데이터의 종류를 비율로 표시
ggplot(diamonds, aes(color, fill=cut)) +
  geom_bar(position='fill')
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311210530137.png" alt="image-20210311210530137" style="zoom:50%;" />

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210311210559152.png" alt="image-20210311210559152" style="zoom:50%;" />

#### 3) coor_flip() : 가로막대그래프

```R
ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity') + # position 생략 : 누적 가로 막대 그래프
  coord_flip()

ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position='dodge') + # 묶음 가로 막대 그래프
  coord_flip()

ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position='fill') + # 비율 가로 막대 그래프
  coord_flip()
```



### geom_line()

- 선 그래프 -  시계열 그래프(Time Series Chart)
- 데이터를 선으로 표현한 그래프
- 시간에 따라 달라지는 데이터 표현
- 일정 시간 간격을 두고 나열된 시계열 데이터를 선으로 표현한 그래프
- 환율, 주가지수 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용

```R
# 시간에 따라서 개인 저축률 변화에 대한 그래프
ggplot(data=economixs, aes(data,psavert)) + geom_line()
```

<img src="md-images/image-20210314205238877.png" alt="image-20210314205238877" style="zoom:50%;" />

### geom_baxplot()

- 데이터 분포(퍼져 있는 형태)를 직사각형 상자 모양으로 표현한 그래프
- 집단 간 부높 차이 표현할 때 사용
- 분포를 알 수 있기 때문에 평균만 볼 때보다 데이터의 특서을 좀 더 자세히 이해할 수 있음

```R
ggplot(mpt, aes(drv, hwy)) + geom_boxplot()
```

<img src="md-images/image-20210314205425562.png" alt="image-20210314205425562" style="zoom:50%;" />



## 그래프 함수 주요 옵션

### 색상/ 모양/ 크기 / 넓이

- colour = "색상"

- shape(pch) = 모양

- size = 크기

  ```R
  ggplot(data=mpg, aes(x=displ, y=hwy)) +
  	geom_point(color='red',
                 shape=1,
                 size=2)
  ```

  <img src="md-images/image-20210314205628747.png" alt="image-20210314205628747" style="zoom:50%;" />

### fill

- 도형에 색을 채워 줄 때 사용
- fill 위치
  - fill = 색상 : aes(), geom_bar() 안에 있어도 된다.
  - 단, 색상 값이 아닌 변수 값을 그래프의 색상으로 결정하고자 한다면 aes() 함수 안에서 사용되어야 함

```R
# 전체 같은 색
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

# Tree 종류별로 색상 분류
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference, fill=Tree)) + 
  geom_bar(stat='identity')
```

<img src="md-images/image-20210314210041295.png" alt="image-20210314210041295" style="zoom:50%;" />

```R
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference = sum(circumference)) %>%
  ggplot(aes(Tree, Sum.circumference)) + 
  geom_bar(stat='identity', fill=Tree) # Tree 변수 값을 찾을 수 없음
# Error in layer(data = data, mapping = mapping, stat = stat, geom = GeomBar,  : 
#                  객체 'Tree'를 찾을 수 없습니다
```



더 많은 옵션 사항은 [ggplot2정리.R](./R/R_code_file/ggplot2정리.R) 파일 참고

