# dplyr

- 패키지 설치

```R
install.packages("dplyr")
library(dplyr)
```



## 1. select()

```R
select(diamonds, carat)
diamonds %>% select(carat)
diamonds %>% select(c(carat, color))
diamonds %>% select(1,7) # 1열, 7열
diamonds %>% select(starts_with('c')) # 열 이름이 c 로 시작하는 열의 데이터들
diamonds %>% select(ends_with('e'))
diamonds %>% select(contains('l'))
   color clarity table
   <ord> <ord>   <dbl>
 1 E     SI2        55
 2 E     SI1        61
 3 E     VS1        65

diamonds %>% select(matches('r.+t')) # r~t로 이루어진 열
   carat clarity
   <dbl> <ord>  
 1 0.23  SI2    
 2 0.21  SI1    
 3 0.23  VS1    
diamonds %>% select(-carat, -price) # 해당 열 제외
```



## 2. filter()

```R
diamonds[diamonds$cut == 'Good',]
subset(diamonds, cut == 'Good')
diamonds %>% filter(cut == "Good") # subset과 비슷한 기능의 함수
diamonds %>% filter(cut %in% c('Good','Ideal')) # cut이 good과 ideal 만 
diamonds %>% filter(price>=1000)
```



## 3. mutate()

- 새로운 속성 추가

```R
diamonds %>% mutate(newPrice=price/carat)   
	carat cut       color clarity depth table price     x     y     z newPrice
   <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>    <dbl>
 1 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43    1417.
 2 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31    1552.

diamonds2 <- diamonds2
diamonds2 %<>% select(carat, price) %>% mutate(Ratio=price/carat) # diamonds에 변경된 내용 다시 넣는 연산 %<>%
```



## 4. slice(data, from, to)

```R
diamonds %>% slice(1000:1500)
diamonds %>% slice(c(1:5, 10, 50:55))
```



## 5. summarize

```R
diamonds %>% summarize(mean(price), mean(carat))
# A tibble: 1 x 2
  `mean(price)` `mean(carat)`
          <dbl>         <dbl>
1         3933.         0.798
```



## 6. group_by

```R
diamonds %>% group_by(cut) %>% summarize(mean(price), mean(carat))
# A tibble: 5 x 3
  cut       `mean(price)` `mean(carat)`
* <ord>             <dbl>         <dbl>
1 Fair              4359.         1.05 
2 Good              3929.         0.849
3 Very Good         3982.         0.806
4 Premium           4584.         0.892
5 Ideal             3458.         0.703
```



## 7. arrange

> 데이터 프레임 정렬

```R
topN <- function(x, N=5){
  x %>% arrange(desc(price)) %>% head(N) # 내림차순 정렬
}

diamonds %>% group_by(cut) %>% do(topN(.,3))
# cut 그룹별 price 내림차순
```

