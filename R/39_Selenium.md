# Selenium

- cmd 창에서 구동해줘야 RSelenium 사용 가능

```bash
java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445
```

- 패키지 설치 및 사용

```R
install.packages("RSelenium")
library(RSelenium)
```



## 셀레니움 문법 정리

#### 01. 드라이버 객체 생성

```R
remDr <- remoteDriver(remoteServerAddr='localhost',
                     port=4445L,
                     browserName='chrome') # 사용할 브라우저 종류
```

#### 02. 드라이버 정보 전달 받아서 open()

```R
# 브라우저 열기
remDr$open()

#브라우저(서버) 상태 확인
remDr$getStatus()
```

#### 03. 페이지 요청

```R
# 사이트 이동
remDr$navigate(url)

# 현재 페이지 url
remDr$getCurrentUrl()

# 사이트 히스토리 이용해서 이동
remDr$goBack() # 뒤로가기
remDr$goForward() # 앞으로 가기

# 현재 페이지 새로 고침
remDr$refresh() # 데이터 서버에서 다시 받아오는 함수
```

#### 04. 페이지 내에서 element 찾기 - findElement()

```R
webElem <- remDr$findElement(using="name", value="q") # using : element 찾을 방법 / value : 해당 값
webElem$getElementAttribute("name")
webElem$getElementAttribute("class")
webElem$getElementAttribute("id")

## css selector 사용
webElem <- remDr$findElement(using="css", "input[name='q']")
webElem <- remDr$findElement(using="css", "[name='q']")
webElem <- remDr$findElement(using="css selector", "h3.r")

## xPath 사용
webElem <- remDr$findElement(using="xpath", "/html/body/div[1]/div[3]/form/div[2]/div[1]/div[1]/div/div[2]/input")
```

#### 05. Element로 text 보내기

```R
## sendKeysToElement(list) 사용
webElem <- remDr$findElement(using="name", value="q")
webElem$sendKeysToElement(list("R Cran"))

## keypress to element "\uE007" 엔터 문자를 같이 전달
webElem$sendKeysToElement(list("R Cran", "\uE007"))
webElem$sendKeysToElement(list("R Cran", key="enter"))
```

#### 06. 객체의 text 찾아오기 - getElementText()

```R
resHeaders <- unlist(lapply(webElems, 
                            function(x){
                                x$getElementText()
                            }))
```

#### selector와 부합하는 여러 객체 중 값이 Ava~ 인 객체의 위치를 찾아서 인덱싱

```R
webElem <- webElem[[which(resHeaders=="Available CRAN Packages for")]]
```

#### 07. 해당 하이퍼텍스트를 클릭

```R
webElem$clickElement() # 하이퍼텍스트에 해당하는 url로 이동
```

#### 08. 브라우저 닫기

```R
remDr$close()
```

