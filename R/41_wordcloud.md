# wordcloud

## wordcloud 그리기 전 사전설정

1. 데이터 불러오기

   ```R
   data1 <- readLines('data/seoul_new.txt')
   ```

2. 형태소 분할

   ```R
   data2 <- sapply(data1, extractNoun, USE.NAMES = F)
   ```

3. 리스트를 벡터로 변환

   ```R
   data3 <- unlist(data2)
   ```

4. 불용어 제거

   ```R
   data3 <- gsub('\\d+','',data3)
   data3 <- gsub('-','',data3)
   data3 <- gsub('[[:punct:]]','',data3)
   data3 <- gsub(' ','',data3)
   data3 <- gsub('서울시','',data3)
   data3 <- gsub('서울','',data3)
   data3 <- gsub('요청','',data3)
   data3 <- gsub('제안','',data3)
   data3 <- gsub('서울시장','',data3)
   data3 <- gsub('시장','',data3)
   
   write(data3, 'data/seoul_2.txt') # 데이터 저장
   data4 <- read.table('data/seoul_2.txt') # 데이터 불러오기
   ```

5. 단어별 빈도 세기 출력 : table()

   ```R
   wordcount <- table(data4)
   head(wordcount)
   #  B ddp DDP  ic  OO OOO 
   #  2   1   2   1  17   3 
   
   # 빈도기준 내림차순 정렬
   sort(wordcount, decreasing=T)
   ```

6. 빈도표 기준으로 불용어 다시 제거

   ```R
   data3 <- gsub('OO','', data3)
   data3 <- gsub('민원','',data3)
   data3 <- gsub('문제','',data3)
   data3 <- gsub('관련','',data3)
   
   # 한글자 단어 제거
   data3 <- Filter(function(x){nchar(x)>=2}, data3)
   ```

## wordcloud 그리기

### 패키지 설치

```R
install.packages("wordcloud")
library(wordcloud)

install.packages("wordcloud2")
library(wordcloud2)
```

### 색상표현 패키지 

```R
install.packages("RColorBrewer")
library(RColorBrewer)

# 색상 세트를 불러오는 함수 : brewer.pal(n, name)
palete <- brewer.pal(9, 'Set3')
```

### wordcloud

```R
wordcloud(names(wordcount), # 출력할 단어들
           freq=wordcount, # 언급된 빈도수
           scale=c(5,1), # 글자크기
           rot.per=0.25, # 회전 단어 비율
           min.freq=3, # 최소 단어 빈도
           random.order=F, # 출력되는 순서를 임의로 지정 유무
           random.color=T, # 색성 랜덤하게
           colors=palete) # 색상
```

### wordcloud2

```R
# 배경색 등 색상 변경하기
wordcloud2(wordcount, color='random-light',backgroundColor = 'black')

# 모양 변경하기
# 크기, 글골, 모양을 별 모양으로
wordcloud2(wordcount, fontFamily = '맑은 고딕',
           size=1.2,
           # minSize=3,
           color='random-light',
           backgroundColor='black',
           shape='star')

# shape = circle, cardioid, diamond, triangle-forward, triangle, pentagon, star
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210325230531316.png" alt="image-20210325230531316" style="zoom:50%;" />

