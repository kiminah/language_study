# XML 정리

```R
library(xml2)
```



## 1. xml 읽기

```R
xPath01 <- 'data/전통시장상점현황.xml'
xData01 <- read_xml(xPath01)
```



## 2. 구조 확인

```R
class(xData01)
# [1] "xml_document" "xml_node"

mode(xData01)
# list

str(xData01)
# List of 2
#  $ node:<externalptr> 
#  $ doc :<externalptr> 
#  - attr(*, "class")= chr [1:2] "xml_document" "xml_node"
```



## 3. 자식노드 구조 파악

- xml_children(xmlDATA)

```R
child_node <- xml_children(xData01)
mode(child_node) # "list"

child_node[1]
# {xml_nodeset (1)}
# [1] <row>\n  <STORE_NM>점포명</STORE_NM>\n  <CLASS_NM>분류명</CLASS_NM>\n  <RM>주소</RM>\n</row>
```

- xml_find_all(x,y) : x 번째 노드의 y번째 항목을 모두 찾기

  './*' : y항목 모두

  ```R
  xml_find_all(child_node[1], './*')
  # {xml_nodeset (3)}
  # [1] <STORE_NM>점포명</STORE_NM>
  # [2] <CLASS_NM>분류명</CLASS_NM>
  # [3] <RM>주소</RM>
  
  child_node[2] %>% xml_find_all('./*') %>% xml_text()
  # xml_text() : 태그 사이의 문자
  # "일번지청과"            "과일"                  "광명시..."
  
  child_node[2] %>% xml_find_all('./*') %>% xml_name()
  # "STORE_NM" "CLASS_NM" "RM" 
  ```

  

### etc

- tidyverse::spread(key, value) : 키 값을 colnames로 value 값을 내용으로 펼쳐주는 함수

```R
library(tidyverse)

# bind_rows() : table로 묶어주는 함수
data1 <- m_T %>% bind_rows() %>% spread(key, value)
data1

# A tibble: 396 x 4
     idx CLASS_NM RM                    STORE_NM  
   <int> <chr>    <chr>                 <chr>     
 1     1 분류명   주소                  점포명    
 2     2 과일     광명시... 일번지청과
 3     3 과일     광명시... 서광과일  
 4     4 과일     광명시... 영등포청과
```

