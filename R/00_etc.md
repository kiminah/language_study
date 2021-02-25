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

