# reshape2 패키지

```R
install.packages('reshape2')
library(reshape2)
```

## melt()

- 옵션
  - id.vars : 기준열 - 생략하면 모든 열을 행방향으로 변환
  - measure.vars : 변환열 - 생략하면 기준열을 제외한 모든 열 행방향으로 변환
  - variable.name = 'variable' : 저장할 값과 변수명
  - na.rm=[T|F] : 결측치를 포함할 것인지 아닌지
  - value.name = 'value' : 저장할 값과 변수명

```R
# vector 생성
name <- c('민철','지수','지영')
kor <- c(100,70,50)
eng <- c(80, 70,100)
computer <- c(85,100,80)

eval_df <- data.frame(name, kor, eng, computer)
eval_df

# melt() 함수 사용하여 데이터 구조 변경
# wide -> long
# 열 이름도 같이 변경
melt(eval_df,
     id.var='name',
     measure.vars = c('kor','computer'),
     variable.name = 'subject',
     value.name = 'score')
```

```R
> eval_df
  name kor eng computer
1 민철 100  80       85
2 지수  70  70      100
3 지영  50 100       80

> melt(...)
  name  subject score
1 민철      kor   100
2 지수      kor    70
3 지영      kor    50
4 민철 computer    85
5 지수 computer   100
6 지영 computer    80

```



## dcast(data,  기준열 ~ 변환열)

- melt() 된 데이터를 dcast() 수행하는 것이 원칙

-  cast()함수 사용시 기준열의 조합은 유니크해야 한다.

  기존 데이터 셋 -> 모든데이터 melt() -> cast로 원 데이터셋 복원가능

  기존 데이터셋 -> 일부데이터 이용 melt() -> cast로 원데이터셋 복원이 불가능 할 수도 있음

  이유 : 기준열을 설정할 수 없으면 (데이터의 조합이 유니크하지 않으면 복원 불가능)

  ```R
  aq_melt <- melt(airquality,
                  id.vars = c('month','day'),
                  na.rm=F)
  head(aq_melt)
  
  # melt() 된 데이터를 dcast로 변환
  ad_cast <- dcast(aq_melt, month+day~variable) # month, day 기준으로 variable 변환
  head(ad_cast)
  ```

  ```R
  > head(aq_melt)
    month day variable value
  1     5   1    ozone    41
  2     5   2    ozone    36
  3     5   3    ozone    12
  4     5   4    ozone    18
  5     5   5    ozone    NA
  6     5   6    ozone    28
  
  > head(ad_cast)
      month day ozone solar.r wind temp
  1       5   1    41     190  7.4   67
  2       5   2    36     118  8.0   72
  3       5   3    12     149 12.6   74
  4       5   4    18     313 11.5   62
  5       5   5    NA      NA 14.3   56
  6       5   6    28      NA 14.9   66
  ```

- cast() 함수 사용시 기준열의 조합은 유니크해야 한다.

  ```R
  head(melt_test2)
  cast_test <- dcast(melt_test2, month+wind~variable)
  # Aggregation function missing: defaulting to length
  ```

  

## acast()

- 행렬, 배열로 변환

  ```R
  # 5~9월, 1~31일 까지의
  # 오존, 태양복사, 바람, 온도의 측정값 출력
  # 결과로 배열로 출력
  acast_air <- acast(aq_melt, day~variable~month) 
  # day 1~31까지 보여주고, variable을 열로, 분리기준은 month
  class(acast_air) # array
  
  class(acast(aq_melt, month+day~variable))
  #      ozone solar.r wind temp
  # 5_1     41     190  7.4   67
  # 5_2     36     118  8.0   72
  # 5_3     12     149 12.6   74
  # 5_4     18     313 11.5   62
  ```

- 함수 인수 옵션 생략시

  ```R
  acast(aq_melt, day~variable)
  #Aggregation function missing: defaulting to length
  # 분리기준 생략하면 오류 발생
  # 에러 발생 : 기준열인 day에 중복된 값이 들어 있음
  ```

- 요약함수 사용 가능

  ```R
  # 각 날짜별 관측요소의 평균을 배열형태로 반환
  acast(aq_melt, day~variable, mean)
  # 데이터에 NA 값이 있으면 연산 불가능
  
  aq_melt <- melt(airquality,
                  id.vars = c('month','day'),
                  na.rm = T)
  
  > acast(aq_melt, day~variable, mean)
  # day인 기준열이 유니크하지 못하다면 오류 발생
        ozone  solar.r      wind     temp
  1  77.75000 199.0000  6.780000 80.20000
  2  43.00000 174.8000  9.160000 80.80000
  3  33.25000 177.4000  9.620000 79.40000
  4  62.33333 197.2500  8.620000 81.80000
  5  48.66667 163.3333  8.460000 79.20000
  6  41.50000 223.3333 12.040000 79.80000 ...
  
  # 모든 관측치의 월별 평균데이터를 와이드형태로 반환
  > acast(aq_melt, month~variable, mean)
       ozone  solar.r      wind     temp
  5 23.61538 181.2963 11.622581 65.54839
  6 29.44444 190.1667 10.266667 79.10000
  7 59.11538 216.4839  8.941935 83.90323
  8 59.96154 171.8571  8.793548 83.96774
  9 31.44828 167.4333 10.180000 76.90000
  
  # dcast() 함수에서의 요약
  > melt_test3
      month wind variable value
  1       5  7.4    ozone    41
  2       5  8.0    ozone    36
  3       5 12.6    ozone    12
  4       5 11.5    ozone    18
  6       5 14.9    ozone    28 ...
  
  > dcast(melt_test3, month~variable, mean)
    month    ozone
  1     5 23.61538
  2     6 29.44444
  3     7 59.11538
  4     8 59.96154
  5     9 31.44828
  ```

  

  

