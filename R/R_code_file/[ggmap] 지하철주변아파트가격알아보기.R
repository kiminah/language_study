# 지하철역 주변 아파트 가격 알아보기
# 1. 공공데이터 다운로드
# 지하철역 정보 - 전처리
# 아파트 실 거래가

# 2. 지하철역 데이터 가공하기
# 지하철역 좌표정보 구하기

# 3. 아파트 실 거래가 데이터 가공하기
# 전용면적 별 거래 가격 확인 - 거래가 높은 평형을 선택
# 아파트 단지별 평균 거래금액 구하기
# 주소정보 전처리 후 좌표정보 구하기

# 4. 구글지도에 지하철역과 아파트 가격 표시 
# 마포구를 기준으로

# 지하철역 데이터 가공
# 지하철역 정보에서 역명, 주소 추출하고 주소로 위경도 값 추출

library(dplyr)
library(ggmap)

# 원시데이터 가져오기
station_data <- read.csv('data/역별_주소_및_전화번호.csv')

# 변수 속성 확인
str(station_data)

# 지하철역 위경도 얻어오기
# google api 키 등록
register_google(key='AIzaSyDKeW3UPa3g9syHpvXJTdsWheCfH9yDVc4')
# station_data 구 주소 열값을 이용해서 위경도 추출
station_code <- geocode(as.character(station_data$구주소))

# 위경도, station_data 데이터프레임 합치기
station_code_final <- cbind(station_data, station_code)
head(station_code_final)

# station_code_final 저장하기 : line_2_lat_lng.csv
# 서울지도에 지하철 2호선 역을 표시하기
# http://rt.molit.go.kr
write.csv(station_code_final, 'data/apt_2019.csv')
library(readxl)
# low 파일 읽어오기(불필요한 행 제거하기)
apart_data_low <- read_xlsx('data/apt_2019.xlsx', skip=16)
head(apart_data_low)
str(apart_data_low)

# 필요한 열 선택
# 변수명 변경
# 데이터 타입 확인 후 사용가능한 형태로 변환
# 데이터 내용이 코드로 되어 있는 경우 - 성별 남자 1, 여자 2
# 나이데이터 - 코드화되어 있으면 연령대이므로 변경해서 사용해야 함
# 이상치, 결측치 제거나 대체

# 데이터의 범위를 표준화

#-------------------------------
# 1. 필요변수 선택(시군구, 번지, 단지명, 전용면적, 거래금액)
aprt_data <- apart_data_low[,c(1,2,5,6,9)]
head(aprt_data)

# 2. 변수명 변경
names(aprt_data) <- c('시군구','번지','단지명','전용면적','거래금액')
head(aprt_data)

nrow(aprt_data)

# 대표 평형 데이터 추출하는 작업 : 대표평형 (거래량이 높은 평형을 선택)
# 거래량 데이터 문자 -> 숫자
aprt_data$전용면적 <- as.numeric(aprt_data$전용면적)
str(aprt_data$전용면적)

# 전영면적의 값을 반올림하여 정수로 표현
aprt_data$전용면적 = round(aprt_data$전용면적)
head(aprt_data)

# 거래빈도가 높은 평형 확인
# 전용면젹을 기준으로 빈도를 구함 - 빈도에 따라 내림차순 정렬해서 결과 확인
count(aprt_data, 전용면적) %>%
  arrange(desc(n))
# 전용면적 85의 거래량이 가장 많음 - 대표면적으로 사용

# 전용 면적 85인 데이터만 추출
aprt_data_85 <- subset(aprt_data,전용면적 == '85' )
head(aprt_data_85)

library(stringr)
aprt_data_85 <- aprt_data_85 %>% 
  filter(str_detect(시군구, '마포구'))

head(aprt_data_85)
nrow(aprt_data_85)

# 거래금액, 제거후 수치로 변환
aprt_data_85$거래금액 <- gsub(',', '', aprt_data_85$거래금액)
head(aprt_data_85)

# 거래금액을 정수형으로 변환하여 단지별 평균 구학 새 변수에 할당
aprt_data_85_cost <- aggregate(as.integer(거래금액)~단지명,aprt_data_85,mean)
head(aprt_data_85_cost)
nrow(aprt_data_85_cost)

# 열이름 변경 as,interger(거래금액) : rename(data, 변경이름=기존이름)
aprt_data_85_cost <- rename(aprt_data_85_cost,'거래금액'='as.integer(거래금액)') 
head(aprt_data_85_cost)

# aprt_data_85 : 마포구 아파트 기본 정보 (단지명, 실거래금액..., 주소) / 단지명이 중복
# aprt_data_85_cost : 단지명, 평균 거래금액 / 단지명이 유니크

nrow(aprt_data_85)
nrow(aprt_data_85_cost)

# 단지정보 추출 - aprt_data_85 에서 중복된 단지명 행 제외시키고 하나만 추출
# duplicated 함수 사용
aprt_data_85 <- aprt_data_85[!duplicated(aprt_data_85$단지명),]
nrow(aprt_data_85)

# 정보데이터셋(aprt_data_85)과 평균표(aprt_data_85_cost)를 병합(join)
aprt_data_85 <- left_join(aprt_data_85,aprt_data_85_cost,by='단지명')
head(aprt_data_85)

# 거래금액.y가 평균 - 사용
aprt_data_85 <- aprt_data_85 %>% select('단지명','시군구','번지','전용면적','거래금액.y')
aprt_data_85 <- rename(aprt_data_85,'거래금액','거래금액.y')

head(aprt_data_85)

#--------------------------------데이터 가공 완료

# 지도 시각화 - 아파트 단지 위경도 수집
# 실습 : 단지 위경도 수집

# 단지별 주소 생성 - 시군구와 번지를 결합
apt_addr <- paste(aprt_data_85$시군구, aprt_data_85$번지) %>% data.frame()
head(apt_addr) # 열 제목이 . 으로 만들어짐
# .을 주소로 변경하여 저장
apt_addr <- rename(apt_addr, '주소'='.')
head(apt_addr)

# 위경도 수집
apt_addr_code <- as.character(apt_addr$주소) %>% geocode()
head(apt_addr_code)

# write.csv(apt_addr_code, '마포구아파트위경도.csv')
# 가공 데이터 및 수집 데이터 병합
mapoapt_code_final <- cbind(aprt_data_85, apt_addr, apt_addr_code) %>%
  select('단지명','전용면적','거래금액','주소',lon,lat)
head(mapoapt_code_final)

#거래금액 정수형으로 변환
mapoapt_code_final$거래금액<-round(mapoapt_code_final$거래금액)

View(mapoapt_code_final)

write.csv(mapoapt_code_final,'마포아파트2019거래금액_위경도.csv')
  
  

# 지도 표식 ----------------------------------------
# 마포를 중심으로 지하철 역 표시

# 홍대입구역을 중심으로 지하철역과 아파트 위치, 거래금액을 표식
# 지도 저장 후 이미지 제출

head(station_code_final)
head(mapoapt_code_final)
g_m <- get_googlemap('홍대입구역', maptype='roadmap', zoom=14)

ggmap(g_m) +
  geom_point(data=station_code_final,
             aes(x=lon, y=lat),
             size=1) +
  geom_point(data=mapoapt_code_final,
             aes(x=lon, y=lat, colour=단지명),
             size=10,
             alpha=0.5)+
  geom_text(data=mapoapt_code_final,               
            aes(x=lon,y=lat),             
            size=2,            
            label=round(mapoapt_code_final$거래금액)) +
  theme(legend.position = 'none')
#----------------------------------------------------------

# 지도 정보를 가져와 map 변수에 저장
seoul_map <- get_googlemap('서울', maptype='roadmap', zoom=12)

# 산점도를 이용한 지하철역 위치 
ggmap(seoul_map) +
  geom_point(data=station_code_final, aes(x=lon, y=lat), colour='red', size=3) +
  geom_text(data=station_code_final, aes(label=역명, vjust=-1))

#----------------------------------------------------
# 마포 지도 정도를 가져워 map 변수에 저장
mapo_map <- get_googlemap('마포', maptype='roadmap', zoom=12)

ggmap(mapo_map) +
  geom_point(data=station_code_final, aes(x=lon, y=lat), colour='red', size=3) +
  geom_text(data=station_code_final, aes(label=역명, vjust=-1))

# 홍대입구역 중심으로 지하철정보 아파트정보
hong_map <- get_googlemap('홍대입구역', maptype='roadmap', zoom=14)
ggmap(hong_map) +
  geom_point(data=station_code_final, aes(x=lon, y=lat), colour='red', size=3) +
  geom_point(data=mapoapt_code_final, aes(x=lon, y=lat), colour='blue') +
  geom_text(data=mapoapt_code_final, aes(label=단지명),vjust=-1, size=3) +
  geom_text(data=mapoapt_code_final, aes(label=거래금액),vjust=-1, size=3)


#------------------------ 거래가격 상위 5개 하위 5개
apt_final_h <- head(arrange(mapoapt_code_final, desc(거래금액)), 5)[c(2,4,6,7)]
apt_final_r <- tail(arrange(mapoapt_code_final, desc(거래금액)), 5)[c(2,4,6,7)]
apt_final_h
apt_final_r

# 마포구 지도 정보를 가져와서 저장(중심위치는 적당한 위치를 찾아야 함)
mapo_map <- get_googlemap('서강대역', maptype='roadmap', zoom=13)
ggmap(mapo_map) +
  geom_point(data=station_code_final, aes(x=lon, y=lat), colour='red',size=3) +
  geom_point(data=mapoapt_code_final, aes(x=lon, y=lat, colour=거래금액),size=3, alpha=6) +
  scale_color_gradient(low='yellow',high='blue')

# top 5  & low 5
ggmap(mapo_map) +
  geom_point(data=station_code_final, aes(x=lon, y=lat), colour='red',size=3) +
  geom_point(data=mapoapt_code_final, aes(x=lon, y=lat, colour=거래금액),size=3, alpha=6) +
  geom_text(data=apt_final_h, aes(label= 단지명), vjust=-1, size=4, color='black') +
  geom_text(data=apt_final_h, aes(label=거래금액), vjust=1, size=4, color='black') +
  geom_text(data=apt_final_r, aes(label= 단지명), vjust=-1, size=4, color='black') +
  geom_text(data=apt_final_r, aes(label=거래금액), vjust=1, size=4, color='black') +
  scale_color_gradient(low='yellow',high='blue')
