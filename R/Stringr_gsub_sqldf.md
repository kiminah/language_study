#  Stringr_gsub_sqldf

- stringr : 문자열처리
- gsub() : 불필요한 문자 제거
- sqldf : 데이터를 sql 쿼리로 다루기



## stringr 패키지

> 문자열은 데이터의 70% 정도를 차지한다.
>
> 문자열을 가능한 쉽게 처리하도록 기능을 제공하는 패키지

```R
install.packages('stringr')
library(stringr)
```



### string_detect()

> 특정 문자의 포함 여부 확인
>
> True/False 로 반환

```R
fruits <- c('apple','Apple','banana','pineapple')
```

- 대문자 'A'가 포함된 요소 찾기

  ```R
  str_detect(fruits,'A')
  ```

  ```R
  [1] FALSE  TRUE FALSE FALSE
  ```

- 첫문자가 소문자 a인 단어 찾기

  ^ : 첫문자 표시

  ```R
  str_detect(fruits, '^a')
  ```

  ```R
  [1]  TRUE FALSE FALSE FALSE
  ```

- 찾는 문자가 들어 있는 단어 출력

  ```R
  fruits[str_detect(fruits,'A')]
  # 크롤링에서 자주 사용한 문법
  ```

  ```R
  [1] "Apple"
  ```

- ~로 끝나는 문자 찾기 : $ 사용 => e로 끝나는 단어 e$

  ```R
  fruits[str_detect(fruits, 'e$')]
  ```

  ```R
  [1] "apple"     "Apple"     "pineapple"
  ```

- [aA] : 단어에 소문자 a나 대문자 A가 들어있는 단어포함 여부 확인

  ```R
  str_detect(fruits, '[aA]')
  # []의 문자 하나 하나를 매칭시킴
  ```

  ```R
  [1] TRUE TRUE TRUE TRUE
  ```

- 패턴 설정하고 설정된 패턴에 일치하는 문자열 포함 여부

  ```R
  pattern <- 'a.b' 
  # a가 출연하고 뒤에 한굴자가 나오고 b가 나오는 : .은 한글자
  string <- c('ABB','aaB','aa.b')
  str_detect(string,pattern)
  
  pattern <- 'a..b'
  str <- c('ABB','aab','aa.b')
  str_detect(str,pattern)
  ```

  ```R
  [1] FALSE FALSE  TRUE
  [1] FALSE FALSE  TRUE
  ```



### str_count()

> 특정문자의 출현 횟수를 세는 함수

```R
fruits
# [1] "apple"     "Apple"     "banana"    "pineapple"
str_count(fruits, 'a')
```

```R
[1] 1 0 3 1
```



### str_to_lower(), str_to_upper()

> 대소문자 변환

```R
mystr <- 'hi everybody'

up <- str_to_upper(mystr) # 대문자로 변환
up
str_to_lower(up) # 소문자로 변환
```

```R
[1] "HI EVERYBODY"
[1] "hi everybody"
```



### str_to_title()

> 단어의 첫글자를 대문자로 변환
>
>  원래 모든 글자가 대문자면 첫글자 제외한 나머지 글자는 소문자로 변환

```R
str_to_title(up)
```

```R
[1] "Hi Everybody"
```



### str_c()

> 문자열 합치기 (concat)

```R
str_c('apple','banana')
str_c(fruits,': Fruits')
str_c(fruits, ' name is ', fruits)
```

```R
[1] "applebanana"
[1] "apple: Fruits"     "Apple: Fruits"     "banana: Fruits" "pineapple: Fruits"
[1] "apple name is apple"         "Apple name is Apple"        "banana name is banana"       "pineapple name is pineapple"
```

- 옵션 collapse= 모든 요소들을 하나로 합치기

  ```R
  str_c(fruits)
  str_c(fruits, collapse="")
  ```

  ```R
  [1] "apple"     "Apple"     "banana"    "pineapple"
  [1] "appleApplebananapineapple"
  ```



### str_dup()

> 반복출력
>
> 각 요소마다 반복 반환

```R
str_dup(fruits, 3)
```

```R
[1] "appleappleapple"             "AppleAppleApple"            "bananabananabanana"          "pineapplepineapplepineapple"
```



### length() vs str_length()

```R
length(fruits) # 구조의 요소 개수 반환
str_length(fruits) # 각 요소의 문자열 길이 반환
```

```R
[1] 4
[1] 5 5 6 9
```



### str_locate()

> 특정 문자의 위치 값 반환

```R
str_locate('apple','a')

str_locate(fruits, 'a') # 요소 각각에 대해서 확인
```

```R
     start end
[1,]     1   1

     start end
[1,]     1   1
[2,]    NA  NA
[3,]     2   2
[4,]     5   5
```



### str_replace(), str_replace_all()

> 문자변경(대체) 함수
>
> str_replace(전체문자열, 대상, 교체될 문자열)

```R
str <- 'apple'
str_replace(str, 'p', '*') # 처음 만나는 p만 변경하고 종료
str_replace_all(str_a, 'p','*') # 모든 p를 변경
```

```R
[1] "a*ple"
[1] "a**le"
```



### str_split()

> 문자 분리 - 리스트로 반환

```R
fruits2 <- str_c(fruits, collapse='/')
fruits2
# /를 기준으로 분할
str_split(fruits2, '/')
```

```R
[[1]]
[1] "apple"     "Apple"     "banana"    "pineapple"
```

- 리스트를 세부 데이터구조로 변환

  ```R
  # 리스트 접근 방법
  str_split(fruits2,'/')[[1]][2] # [1] "Apple"
  
  # 리스트를 세부 데이터 구조로 변환
  unlist(str_split(fruits2,'/'))
  ```

  ```R
  [1] "apple"     "Apple"     "banana"    "pineapple"
  ```



### paste() vs paste0()

> paste(data, collapse=, sep=) : 나열된 원소 사이에 공백을 두고 결과값 출력
>
> paste0 (data, collapse=) : 나열된 원소 사이에 공백 없이 출력
>
> 문자열 결합함수
>
> stringr 패키지는 아니지만 문자열에서 자주 쓰는 함수

```R
paste(c('a','b','c'), collapse = '/')
paste('가','/','나','/')
```

```R
[1] "a/b/c"
[1] "가 / 나 /"
```

- 비교

  ```R
  paste(1,2,3,4)
  # [1] "1 2 3 4"
  paste(1,2,3,4, sep="")
  # [1] "1234"
  
  paste0(1,2,3,4)
  # [1] "1234"
  ```



### str_sub()

> str_sub(문자열, start=, end=)
>
> 부분 문자열 추출

```R
str_sub('apple',start=1, end=3)

# 여러 요소를 입력으로 전달하면
# 각 요소마다 순환 적용
str_sub(fruits, start = 1, end=3)

# - : 뒤에서부터 시작
str_sub('banana', start=-5)
```

```R
[1] "app"

[1] "app" "App" "ban" "pin"

[1] "anana"
```



### str_trime()

> 공백제거

```R
str_trim('     applebanana     ') # 양쪽 공백 제거
str_trim('     applebanana     ', side='right') # 오른쪽 공백만 제거
str_trim('     applebanana     ', side='left') # 왼쪽 공백만 제거
```



## gsub()

> gsub(변경전문자, 변경후문자, data, 옵션)
>
> 문자 정제하는 함수
>
> 불필요한 문자를 제거할 때 많이 사용(ex. 태그, 특수문자 등)

```R
# ABC를 ***로 변환
gsub('ABC','***', 'ABCabcABC')

# ignore.case= : 대소문자 구문없이 진행
gsub('ABC','***', 'ABCabcABC', ignore.case = T)

# 패턴문자 사용
# b와 n 사이에 1개의 문자가 있는 패턴을 ***로 변경
gsub('b.n','***', 'i love banana')
```

```R
[1] "***abc***"

[1] "*********"

[1] "i love ***ana"
```



## sqldf 패키지

```R
# sqldf 패키지 설치 및 로드
install.packages('sqldf')
library(sqldf)

# Fruits 데이터셋 사용
install.packages('googleVis')
library(googleVis)
```

- sql 쿼리문은 대부분 사용 가능

  ```R
  # 데이터셋에서 모든 데이터 가져오기
  sqldf("select Year, Fruit from Fruits")
  # 와일드문자 사용
  sqldf("select * from Fruits")
  
  # 조건문 사용
  sqldf("select Year, Fruit from Fruits where Fruit='Apples'")
  # 조건에 연산 사용
  sqldf("select * from Fruits
        where Fruit='Apples' and sales >= 100")
  
  # 출력되는 행 수 제어
  sqldf("select Year, Fruit from Fruits limit 5")
  
  # 정렬 출력 : order by
  sqldf("select Year, Fruit from Fruits order by Year")
  sqldf("select Year, Fruit from Fruits order by Year, Fruit")
  sqldf("select Year, Fruit from Fruits order by Year desc")
  
  # 정렬 옵션을 추가하고 기준을 확장
  sqldf("select Year, Fruit from Fruits order by Year desc, Fruit")
  
  # 그룹 함수 사용 가능
  # sum()/avg()/max()/min()
  # select 그룹함수(컬럼) from 데이터프레임
  
  # 총 판매량을 구하시오 
  sqldf("select sum(Sales) from Fruits")
  
  sqldf("select sum(Sales), Profit from Fruits") # 논리적으로 잘못된 출력
  #    sum(Sales) Profit
  # 1        845     20
  
  
  sqldf("select sum(Sales), avg(Profit) from Fruits")
  sqldf("select max(Sales), min(Profit) from Fruits")
  
  # Group By 절 사용
  # select ~ form ~ group by ~
  sqldf("select Fruit, avg(Sales) from Fruits ") # 논리적으로 잘못된 출력
  sqldf("select Fruit, avg(Sales) from Fruits group by Fruit")
  
  # Fruits df의 관측치 개수를 추출하시오(sqldf 함수 사용)
  sqldf("select count(*) from Fruits")
  ```

  

