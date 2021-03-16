# ggmap

## 설치 방법

### 1) 기본 방법

```R
install.packages('ggmap')
library(ggmap)
```

### 2) 깃허브 이용

```R
install.packages('devtools')
library(devtools)
install_github('dkahle/ggmap') # 설치 중간에 update 관련 물음 나오면 그냥 enter 하고 지나감
```



## 구글맵

- Google API 키 등록 : register_google(key='')

### 1) 지도 얻어오기 : 구글 서버에 요청 보냄

- get_googlemap('기준위치', zoom정보(생략가능), 지도종류(생략가능))

```R
ggseoul <- get_googlemap('seoul', maptype='terrain') # 지도정보 가져오기

ggmap(ggseoul) # 지도 표시
```

### 2) 위경도 얻어오기

- getgeocode('주소 or 지역명')

```R
# 대전역 위경도 얻어오기
geo_code <- enc2utf8('대전역') %>% geocode()

geo_code

class(geo_code) # data.frame
typeof(geo_code) # list

# point 하기 위해 위경도를 변경
geo_data <- as.numeric(deo_code) # 필요할 때만 변환

#--------- 대전역 위치를 지도에 표시
get_googlemap('대전역', maptype='roadmap', zoom=13) %>% ggmap() +
  geom_point(data=geo_code,
             aes(x=lon,y=lat),
             size=5)

#------------ 경복궁의 위치를 지도에 표시
geo_code2 <- enc2utf8('경복궁') %>% geocode()
geo_code2

get_googlemap('seoul', maptype='roadmap', zoom=13) %>% ggmap() +
  geom_point(data=geo_code2,
            aes(x=lon, y=lat),
            size=5,
            color='blue')
```

