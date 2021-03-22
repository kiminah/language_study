## 수업과제
# 네이버 영화 사이트 크롤링
# movie.naver.com
# 왼쪽 사이드 메뉴에서 영화랭킹 선택 후 조회수 랭킹 1~50위에 대하여 
# 제목과 세부링크 url을 크롤링

## 최종 데이터를 데이터프레임으로 구성

## url 설정
url <- 'https://movie.naver.com/movie/sdb/rank/rmovie.nhn'
movie_raw <- read_html(url)

selector <- '#old_content > table > tbody > tr > td.title > div > a'
movie_node <- html_nodes(movie_raw,selector)
movie_node

## 제목, 세부링크
# 초기화
title <- c()
link <- c()
base_url <- 'https://movie.naver.com'

# 제목, 세부링크 수집
for (i in 1:length(movie_node)){
  # 제목
  tit <-  html_text(movie_node[i])
  title <- c(title, tit)
  
  # 세부링크
  lk <- html_attr(movie_node[i],'href')
  lk <- paste0(base_url, lk)
  link <- c(link, lk)
  
}
title
link

# 최종데이터 데이터프레임으로 구성
movie <- data.frame(title, link)
# View(movie)

#---------------------------------------------------------------------------
# 각 영화 링크로 접근하여 네티즌 관람객 평점과 기자 평론가 평점을 크롤링하여 
# 1번에서 작업한 내용과 모두 결합하여 csv 파일로 저장
# 영화랭킹.csv

netizen <- c()
special <- c()

for(i in 1:length(movie$link)){
  url <- movie$link[i]
  
  # 청불 영화라 수집이 안되는듯...?
  if(i==40){
    netizen[40] <- 7.18
    special[40] <- 0.00
    next
  }
  
  score_raw <- read_html(url)
  selector1 <- '#content > div.article > div.section_group.section_group_frst > div > div > div.score_area > div.netizen_score > div > div > em'
  selector2 <- '#content > div.article > div.section_group.section_group_frst > div > div > div.score_area > div.special_score > div > div > em'

  score_node <- html_nodes(score_raw, selector1)
  netizen <- c(netizen, html_text(score_node))
  score_node <- html_nodes(score_raw, selector2)
  special <- c(special, html_text(score_node))
}
movie <- cbind(movie, netizen, special)
write.csv(movie, '수집데이터/영화랭킹.csv')

#---------------------------------------------------------------------------
# 리뷰.csv - 평점 / 리뷰 (모든 영화의 리뷰 수집)

review_score <- c()
review_content <- c()

for(i in 1:length(movie$link)){
  url <- movie$link[i]
  
  review_raw <- read_html(url)
  selector1 <- '#content > div.article > div.section_group.section_group_frst > div:nth-child(5) > div:nth-child(2) > div.score_result > ul > li > div.star_score > em'
  selector2  <- '#content > div.article > div.section_group.section_group_frst > div:nth-child(5) > div:nth-child(2) > div.score_result > ul > li > div.score_reple > p'
  
  review_node <- html_nodes(review_raw, selector1)
  review_score_text <- html_text(review_node)
  review_node <- html_nodes(review_raw, selector2)
  review_content_text <- html_text(review_node)
  review_content_text <- review_content_text %>% str_replace_all('\\t|\\r|\\n','')
  review_score <- c(review_score, review_score_text)
  review_content <- c(review_content, review_content_text)
  
}

review_final <- data.frame(평점=review_score, 리뷰=review_content)
# View(review_final)

write.csv(review_final, '수집데이터/리뷰.csv')


#----------------------------------------------------------------------------
# 수업과제3
# 영화 랭킹 10위 안의 영화중 3개를 선택하여 각 영화의 리뷰를 최대한 수집

library(rvest)
library(RSelenium)
library(seleniumPipes)
library(httr)
library(stringr)

## Selenium 으로 크롤링
## 네티즌관람객 평점/ 평론가 평점
# 더보기를 눌렀을때 나오는 리뷰 (3페이지 까지)

## 영화 랭킹 페이지
url <- 'https://movie.naver.com/movie/sdb/rank/rmovie.nhn'

remDr <- remoteDriver(remoteServerAddr='localhost',
                      port=4445L,
                      browserName='chrome')
remDr$open()



## 원하는 영화 상세 페이지로 이동 ##
rank <- c(1,3,6)
result <- c()

for(m_r in 1:length(rank)){
  remDr$navigate(url)
  
  value <- paste0('#old_content > table > tbody > tr:nth-child(',rank[m_r]+1,') > td.title > div > a')
  rank_detail <- remDr$findElement(using='css selector', value=value)
  rank_detail$clickElement()
  
  ## 해당 영화의 리뷰 더보기로 이동
  review_More <- remDr$findElement(using='css selector', value='#movieEndTabMenu > li:nth-child(5) > a')
  review_More$clickElement()
  
  ## 페이지 데이터 가져오기
  
  score <- c()
  review <- c()
  
  # frame 접근
  frames = remDr$findElements(using = "id",
                              value = 'pointAfterListIframe')
  remDr$switchToFrame(frames[[1]])
  
  for(p in 1:10){
    
    # iframe 페이지 로드
    page_parse = remDr$getPageSource()[[1]]
    page_html = page_parse %>% read_html()
    
    
    #@ 평점과 리뷰 수집
    raw_node <- html_nodes(page_html,'body > div > div > div.score_result > ul > li')
    
    # 평점
    s <- html_node(raw_node, 'div.star_score > em') %>% html_text() 
    # 리뷰
    for(line in 0:length(raw_node)-1){
      r <- html_node(raw_node[line+1], paste0('#_filtered_ment_',line)) %>% 
        html_text() %>%
        str_replace_all('\\t|\\n|\\r', '')
      review <- c(review, r)
      cat('\n','page:',p,', line :',line)
    }
    score <- c(score, s)
    
    # 페이지 이동
    if(p != 3){
      page <- remDr$findElement(using='css', paste0('#pagerTagAnchor', p+1))
      page$clickElement()
    }
  }
  df <- cbind(score, review)
  result <- rbind(result,df)

}
write.csv(result, '수집데이터/네이버_영화_리뷰_및_평점.csv')

