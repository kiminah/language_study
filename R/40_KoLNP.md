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