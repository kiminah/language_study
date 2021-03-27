# KoLNP

> 현재 버전에서는 carn 에 올라가 있지 않음

```R
install.packages("multilinguer")
library(multilinguer)

install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")

# github 버전 설치
install.packages("remotes")
# 64bit 에서만 동작
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library(KoNLP)
library(stringr)
```

## 기본 사용법

- 텍스트 마이닝 : 문자 데이터에서 가치있는 정보 추출해내는 분석기법
- 주로 사용되는 함수
  - readLines()
  - extractNoun() : 명사를 추출하는 함수(list 반환)
  - sapply() : 반복적으로 함수를 적용시켜줌
  - unlist()
  - Filter() : 조건에 맞는 단어 추출
  - gsub() : 불용어 제거 (값이 없는걸로 변환)
  - table() : 빈도수를 출력

## 기초 사용

### 1. 파일 읽어오기 : readLines

```R
test_data <- readLines(text file)
```



### 2. 형태소 분할 

#### 2-1 extractNoun(data)

```R
extract_result <- extractNoun(test_data)

v1 <- '봄이 지나면 여름이고 여름이 지나면 가을입니다. 그리고 겨울이지요'
extractNoun(v1)
# "여름" "여름" "가을" "겨울"
```

#### 2-2. sapply() 함수 사용

```R
s_result <- sapply(test_data, extractNoun, USE.NAMES=T)
```



### 3. 불용어제거 : gsub() 함수 사용

#### 3-1. 불용어 제거

```R
word_list <- c('창업','학생','운영','회사','친구','학교')

word_list <- gsub('운영','', word_list)
word_list
# "창업" "학생" ""     "회사" "친구" "학교"
```

#### 3-2. 제거한 열 완전히 제거

```R
write(word_list,'word_list.txt')

# 읽어오기
word_list2 <- read.table('word_list.txt')
word_list2 # 빈 라인은 제거하고 가져옴
```

#### 3-3. grep(패턴, 문자열) : 특정 텍스트를 검색한 결과 반환

```R
st <- c('word list', 123, 'my list', 567,'word')
grep('my',st)
grep('abc',st) # 못찾으면 0
grep('\\d',st,value=T) # value=T 찾은 값 '\\d' : 숫자
grep('\\D',st,value=T) # '\\D' : 숫자가 아닌 것

# 3
# integer(0)
# "123" "567"
# "word list" "my list"   "word"
```



---



## 텍스트마이닝

- 분석은/ 분석이/ 분석을 → 세 단어를 다르게 인식

- 독립변수가 적으면 좋고 같은 의미의 단어는 줄여줘야 함

  

### extractNoun() : 명사만 추출

```R
extractNoun('롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다')
# "롯데마트" "판매"     "흑마늘"   "양념"     "치킨"     "논란"     "있" 
```



### SimplePos09() : 다양한 품사로 나누어줌

```R
SimplePos09('롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다')
# $판매하고
# [1] "판매/N+하고/J" : 명사 + 관계언
# $있는
# [1] "있/P+는/E" : 용언 + 어미 ....
```



### MorphAnalyzer() : 품사를 다양한 경우의 수로 나누어줌

```R
MorphAnalyzer('롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다')
$롯데마트가
[1] "롯데마트/ncn+가/jcc"            "롯데마트/ncn+가/jcs"           
[3] "롯데마트/ncn+가/ncn"            "롯데마트/ncn+이/jp+가/ecc"     
[5] "롯데/ncn+마트/ncn+가/jcc"       "롯데/ncn+마트/ncn+가/jcs"      
[7] "롯데/ncn+마트/ncn+가/ncn"       "롯데/ncn+마트/ncn+이/jp+가/ecc"

$판매하고
 [1] "판매/ncpa+하고/jcj"             "판매/ncpa+하고/jct"            
 [3] "판매/ncpa+하고/ncn"             "판매/ncpa+하고/jcs"            
 [5] "판매/ncpa+하/xsva+고/ecc"       "판매/ncpa+하/xsva+고/ecs" ....
```



---



## SimplePos09

> 사용 데이터셋 → 리뷰가 담긴 데이터(comments)

- 형태소 분리

  ```R
  # 빈 list를 하나 만들고 각 방에 결과 하나씩 저장
  com_list <- list()
  
  # SimplePos09(comments)
  # java 메모리 에러 날 수 있음
  
  ## 문장 덩어리가 너무 크거나, 기호문자가 들어가 있거나 하는 여러 이유로 형태소 분석 진행 안될 수 있다 (에러처리 해 줘야 함)
  for(i in 1:length(sample_com)){
    s_token <- SimplePos09(sample_com[i])
    com_list[[i]] <- s_token
    cat('\n', i) # 진행률을 보기 위함
  }
  ```

- 예외 처리 : 에러 발생하면 NA 값으로 치환

  ``` R
  for(i in 1:length(sample_com)){
    if(class(try(s_token <- SimplePos09(sample_com[i])))=='try-error'){
      com_list[[i]] <- NA
    }else{
      com_list[[i]] <- s_token
    }
    cat('\n', i)
  }
  ```

- 형태소 분리한 자료가 들은 data(com_list)의 unlist() 작업

  ```R
  com_list2 <- unlist(com_list)
  ```

- 형태소 분석

  ```R
  #------ 형태소 분석
  # "오늘/N" : '오늘' 만 추출해야함
  # "오니기리/N+와/J" : '오니기리'만 추출해야 함
  ## sapply 사용
  words <- sapply(str_split(com_list2,'/'), function(x){x[1]})
  head(words)
  ```

- 형태소 빈도수 계산 : table()

  ```R
  cnt <- table(words)
  cnt <- cnt[nchar(names(cnt))>1] # 한글자 단어 지움
  
  # 빈도수 큰 순서대로 정렬후 100개만 추출
  sam_test <- sort(cnt, decreasing = T)[1:100]
  sam_test
  ```



- 나눠진 형태소에서 명사만 추출하고 싶을 때 : N

  ```R
  test <- str_split(com_list2[1:10],'/')
  
  ## 명사 추출 함수
  ## 아래 코드는 x[2]의 값이 N 인 것만 추출
  sel_N <- function(x){
    x[2]=='N'
  }
  sapply(test,sel_N)
  
  ## 실제 데이터는 "오니기리" "N+와" 이 형태일 수 있으므로 N+인 경우에도 추출 해야 함
  ## str_detect() 사용
  sel_N <- function(x){
    if(str_detect(x[2],'N')){
      x[1]
    }else{}
  }
  words <- sapply(spl_data, sel_N)
  words <- unlist(words)
  ```

  

