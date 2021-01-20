# 집합(set)

* 수학의 집합
* 중복되지 않은 항목들이 모인 것
* 집합 = {항목1, 항목2...}

## 집합의 특징

* 순서가 없다

* 동일한 요소(값) **중복 불가**

* 인덱스 사용 불가

* 요소 추가/삭제는 가능

* 집합 안에 **변경 가능한 항목 포함할 수 없음**

  * 리스트 포함 불가
  * 튜플 포함 가능

  ```python
  # 집합에 요소 추가(add, update 함수)
  s = {1, 2, 3}
  s.add(4) # 1개 추가시
  print(s)
  
  s.update([5, 6]) # 여러개 추가시
  print(s)
  ```

  ```python
  # 집합에서 요소 삭제
  s.remove(3)
  s.discard(5)
  print(s)
  
  # 없는 요소 삭제시
  # s.remove(10) # KeyError: 10
  s.discard(10)
  ```

## 집합 연산

* 합집합
  * A|B
  * A.union(B)
* 교집합
  * A&B
  * A.intersection(B)
* 차집합
  * A-B
  * A.difference(B)