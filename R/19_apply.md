# apply

## apply

- 행 또는 열 단위의 연산을 쉽게 할 수 있도록 지원하는 함수

- '1' 이 행단위 연산, '2' 가 열단위 연산

  ```R
  apply(KosteckiDillon[,c('time','age','airq')], 2, mean) # 해당 열의 평균 계산
  # NA 값이 있다면 na.rm=T 추가
  ```

  

## lapply

- 실행결과가 list 형태로 출력

  ```R
  lapply(KosteckiDillon[,c('time','age','airq')], mean)
  $time
  [1] 15.45568
  
  $age
  [1] 42.36392
  
  $airq
  [1] 24.82601
  
  
  m <- list(a=c(1,2,3), b=c(5,6,7))
  m
  apply(m, 2, mean) # Error in apply
  lapply(m, mean)
  
  lapply(m, function(x){x>5})
  $a
  [1] FALSE FALSE FALSE
  
  $b
  [1] FALSE  TRUE  TRUE
  ```

- list를 벡터 구조로 변환

  ```R
  unlist(m)
  
  unlist(lapply(iris[,c(1:4)], mean))
  ```

  

## sapply

- lapply()와 유사

- 반환 값이 벡터 또는 행렬

  ```R
  r3 <- sapply(KosteckiDillon[,c('time','age','airq')], mean)
  
  sapply(KosteckiDillon[,c('time','age','airq')], range)
  sapply(m, mean) # 리스트 형태인 m도 벡터로 출력 가능
  
  m
  $a
  [1] 1 2 3
  
  $b
  [1] 5 6 7
  
  sapply(m, function(x){x>5})
           a     b
  [1,] FALSE FALSE
  [2,] FALSE  TRUE
  [3,] FALSE  TRUE
  ```

  

## tapply(벡터, 인덱스, function, ...)

- array로 출력

- 그룹별로 함수를 적용

  ```R
  class(tapply(1:10, 1:10 %% 2 == 1, sum)) # array
  
  tapply(iris$Sepal.Length, iris$Species, mean)
      setosa versicolor  virginica 
       5.006      5.936      6.588 
  
  x <- matrix(1:8, ncol=2, dimnames = list(c('봄','여름','가을','겨울'),c('남','여')))
  gidx <- list(c(1,1,2,2,1,1,2,2),c(1,1,1,1,2,2,2,2))
  tapply(x, gidx, sum)
    1  2
  1 3 11
  2 7 15
  ```

  

## mapply

- sapply()와 유사

- rnorm : 정규분포

  ```R
  mapply(mean, iris[,1:4])
  Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
      5.843333     3.057333     3.758000     1.199333 
  
  mapply(rnorm, c(10,20,30), c(10,0,100), c(2,1,10)) # list
  
  rnorm(10,10,4)
  ```

  