# 01. Package magrittr

## `%>%`

### 1. 패키지 설치

```R
install.packages('magrittr')
library(magrittr)
```



### 2. 사용법

코드를 한 줄로 작성할 수 있도록 도와준다.

```R
x <- c(1,4,9,4,-1,30)
mean(x)
[1] 7.833333

x %>% mean
[1] 7.833333


x[3] <- NA # [1]  1  4 NA  4 -1 30
x %>% is.na %>% sum # 1
```



# 02. Package doBy

## `summaryBy()`, `orderBy()`

```R
install.packages("doBy")
library(doBy)

summaryBy(Sepal.Width+Sepal.Length~Species, iris)

orderBy(~Species + Sepal.Length, iris) # Species와 Sepal.Length를 기준으로 정렬

quantile(iris$Sepal.Length, seq(0,1,0.2)) # 사분할 함수
  0%  20%  40%  60%  80% 100% 
4.30 5.00 5.60 6.10 6.52 7.90 
```



# attach~detach

> 사용할 데이터 미리 선언하고 그 안에서 데이터의 변수 편하게 사용할 수 있도록 해줌

- 데이터 변수를 선언할 때 데이터 이름을 안써주면 오류가 발생

  ```R
  print(Sepal.Length) # Error in print(Sepal.Length) : 객체 'Sepal.Length'를 찾을 수 없습니다
  Petal.Length[2] # 에러: 객체 'Petal.Length'를 찾을 수 없습니다
  ```

  

- attach~detach 사용

  ```R
  attach(iris) # 사용할 데이터 미리 선언
  
  ## attach~detach 사이에서는 변수만 선언해도 사용가능
  print(Sepal.Length)
  Petal.Length[2]
  
  search() # "iris" 있음
  
  detach(iris) # 선언된 데이터 사용 중지
  ```

  