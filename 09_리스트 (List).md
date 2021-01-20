# 리스트 (List)

## 정의

* 동일한 이름을 갖는 원소들의 연속 저장 영역
* 여러 개의 데이터가 저장되어 있는 장소
* 각 원소는 인덱스로 구분
* 원소(값) 변경 가능
* 대괄호[] 사용
  * 리스트 = [값1, 값2...]

## 특징

* 리스트의 크기는 가변적

* 다양한 종류의 데이터를 하나의 리스트 안에 저장 가능

  * myList = [12, 'dog', 180.14, '홍길동']

  ```python
  # 리스트의 각 원소를 변수에 저장
  nums = [1,2,3]
  a=nums[0]
  b=nums[1]
  c=nums[2]
  print(a,b,c)
  d,e,f = nums
  print(d,e,f)
  ```



## 특정 원소에 접근 : 인덱싱(Indexing)

* 리스트에서 인덱스 연사자를 통하여 요소를 참조(접근) 하는 것

  ```python
  a=[1, 2, 3, 4, 5]
  print(a[0])
  print(a[-1])
  print(a[-2]) # 뒤에서 두 번째 요소
  
  b = [1, 2, 3, [10, 20]]
  print(b[-1][0]) # 10 : 마지막 요소의 첫 번째 요소
  
  c = [1, 2, 3, [10, 20], 4, 5]
  print(c[3][1]) # 20 : 4번째 요소의 두 번째 요소 접근
  
  # 리스트를 리스트로 생성
  all_list = [a, b, c]
  print(all_list)
  print(all_list[0][2]) # 3 : a의 세 번째 요소
  print(all_list[-1][3][0]) # 10 : c의 네 번째 요소의 첫 번째 요소 접근
  ```



## 리스트 연산

* `+` : 리스트 합치기
* `*` : 반복
* `=` : 리스트의 내용 변경(특정 위치의 요소에 값 저장)

```python
a = [1, 2, 3]
b = [4, 5, 6]

c = a + b
print(c) # [1, 2, 3, 4, 5, 6] 두 리스트의 데이터를 합쳐서 하나의 리스트로 반환

d = a * 3
print(d) # a 리스트의 요소 값을 세번 반복해서 하나의 시트르 변환

# 리스트 내용 변경
a[2] = 30 # [1, 2, 3] -> [1, 2, 30]
print(a)

a[0:2] = [10, 20]
print(a)

# 인덱싱을 통해 리스트를 대입하면 하위리스트로 생성
b[0] = [1, 2, 3, 4] # [4,5,6] -> [[1,2,3,4],5,6]
print(b)
```



## 리스트 복사

* 리스트 변수

  * 리스트 객체는 직접 저장하고 있는 것이 아니라, 리스트 자체는 다른 곳에 저장되어 있고 참조값(reference)만 변수에 저장

    참조값 : 메모리에서 리스트 객체의 위치(주소)

* 리스트 복사 방식

  * 얕은 복사(shallow copy)

    * 실제 리스트는 복사되지 않고 참조값(주소)만 복사

    * 복사본 리스트 요소의 값을 변경하면 원본 리스트 요소의 값도 변경

      ```python
      scores = [10, 20, 30, 40]
      values = scores
      
      values[0] = 100 # 복사본 리스트의 요소값 변경
      
      print('scores :', scores)
      print('values :', values)
      
      # 원본값이 변경
      # scores : [100, 20, 30, 40]
      # values : [100, 20, 30, 40]
      ```

  * 깊은 복사(deep copy)

    * 리스트의 복사본을 새로 생성하여 반환(원본 리스트의 데이터를 다른 곳에 한번 더 저장하고 그 주소를 반환)

    * 연산자 `=`로는 불가능

    * `list()` 또는 `deepcopy()` 함수 사용

    * 복사본 리스트의 값을 변경해도 원본 리스트의 값은 변경되지 않는다.

      ```python
      scores = [1, 2, 3, 4, 5]
      values = list(scores)
      
      values[0] = 100
      
      print('scores :', scores)
      print('values :', values)
      
      # scores : [1, 2, 3, 4, 5]
      # values : [100, 2, 3, 4, 5]
      ```

    * `deepcopy()`

      파이썬 내장함수가 아니어서 모듈 copy import 해야 함

      ```python
      import copy
      
      a = ['a', 'b', 'c']
      b = copy.deepcopy(a)
      
      b[0] = 1
      
      print(a)
      print(b)
      
      # ['a', 'b', 'c']
      # [1, 'b', 'c']
      ```



## 리스트의 주요 메소드(함수)

* 내장함수

  * 함수 : 특정 기능을 수행하는 코드 집합

  * 내장함수 : 파이썬에 이미 만들어져 있는 함수들

    ex) `print()` / `len()`

* 메소드

  함수와 같은 코드 집합이지만 클래스의 멤버로 객체를 통해서만 사용 가능

  

* `len()` :  리스트 전체 데이터의 개수 반환

* `count()` : 리스트 내에서 특정 요소(값)의 개수 반환

  ```python
  a = [1, 2, 3, 3, 5]
  
  print(len(a)) # 5
  print(a.count(3)) # 2
  ```

  

* `append(값) ` : 리스트의 끝에 새로운 요소 추가

  ```python
  a.append(6)
  print(a) # [1, 2, 3, 3, 5, 6]
  
  a.append([6,7]) # 리스트 끝에 하위 리스트로 추가 [1, 2, 3, 3, 5, 6, [6, 7]]
  print(a)
  ```

  ```python
  a.append(8,9)
  
  TypeError: append() takes exactly one argument (2 given)
  # append() 함수는 옵션(argument)가 1개여야 함
  ```

  * 요소 추가

  ```python
  # 빈 리스트 생성하고 요소 나중에 추가
  values = []
  values.append(10)
  values.append(20)
  values.append(30)
  print(values) # [10, 20, 30]
  
  # for 문을 사용해서 요소 추가
  scores = []
  for i in range(5): # 0-4
      scores.append(i) # [0, 1, 2, 3, 4]
  ```

* `insert(위치, 값)` : 특정 위치에 요소를 삽입

  * 삽입된 위치의 데이터부터는 한개씩 위치값이 증가

  ```python
  a = [1, 2, 3, 4, 5]
  a.insert(2, 300)
  print(a) # [1, 2, 300, 3, 4, 5]
  
  a.insert(-1, '홍길동') # 마지막 원소 앞에 삽입
  print(a)
  
  # 끝에서 넣고 싶은 경우 마지막 인덱스를 지정
  # 리스트 크기를 아는 경우만 사용 가능
  a.insert(7, 12.3)
  print(a)
  
  a.insert(len(a), 12.4) # 맨 뒤 삽입
  print(a)
  
  a.insert(20, '마지막') # 기존 인덱스에 +1 까지의 위치가 아니면 마지막에 삽입
  print(a)
  ```

  

* `remove()`

  * 리스트에서 값이 해당되는 요소 **제거**
  * 리스트.remover(값)
  * 동일한 값이 여러 개 있는 경우 **첫 번째 값만** 제거
  * 다 제거하려면 for 문 사용

  ```python
  n = [1, 2, 3, 3, 4, 5, 4, 3]
  n.remove(4) # 원본 n에서 첫 번째 만나는 4를 제거(원본 변화)
  print(n) # [1, 2, 3, 3, 5, 4, 3]
  
  # 동일한 원소 한꺼번에 제거
  # 제거하고자 하는 원소가 몇 개 있는지 확인
  cnt = n.count(3) # 3개
  # 그 수 만큼 제거를 반복
  for i in range(cnt): # 3번 반복
      n.remove(3)
      print('3 삭제:', n)
  
  print(n)
  ```

  * 반복문 주의!! : 제거하려는 원소가 모두 제거된 후 , 제거명령시?

    ```python
    n.remove(3)
    
    ValueError: list.remove(x): x not in list
    
    # !! remove 함수는 제거 요소가 없으면 에러 발생
    ```

    

* `pop()`

  * 리스트.pop() : 리스트의 **마지막 요소** 반환하고 삭제
  * 리스트.pop(인덱스) : 인덱스 위치에 있는 요소 **반환**하고 **삭제**

  ```python
  # pop() : 리스트의 마지막 요소 반환하고 삭제
  x = ['a', 'b', 'c', 'd']
  y = x.pop() # 마지막 요소를 반환하기 때문에 그 값을 변수에 저장
  print(y)
  print(x)
  
  x.pop()
  x.pop()
  x.pop()
  print(x)
  ```

  * 비어 있는 리스트를 pop() 시킬 시?

    ```python
    x.pop() 
    #에러발생
    IndexError: pop from empty list
    ```

    

* `extend()`

  * 리스트 확장시키는 함수
  * `리스트.extend()`
  * 이전 리스트에 원소 추가하여 확장된 리스트로 됨
  * 원래 리스트 변경됨

  ```python
  a = [1, 2, 3]
  a.extend([4, 5])
  print(a) # [1, 2, 3, 4, 5]
  
  # append()와 insert()에서는 하위 리스트로 추가됨
  a = [1, 2, 3]
  a.append([4, 5])
  print(a) # [1, 2, 3, [4, 5]]
  ```

  

* `sort()` : 원본 리스트 변경

  * 리스트의 원소들 정렬(기본 : 오름차순)

  * 리스트.sort() 

  * sort(reverse=True) : 내림차순

  ```python
  # 기본 오름차순 정렬
  scores = [90, 78, 81, 64, 89]
  scores.sort()
  print(scores) # [64, 78, 81, 89, 90]
  
  # 내림차순 정렬
  scores = [90, 78, 81, 64, 89]
  scores.sort(reverse=True) 
  print(scores) # [90, 89, 81, 78, 64]
  ```

  * 영문자 정렬

    ```python
    char = ['b', 'A', 'd', 'C']
    char.sort()
    print(char) # ['A', 'C', 'b', 'd']
    
    # 영문 대소문자 구별없이
    # key = str.lower
    char = ['b', 'A', 'd', 'C']
    char.sort(key=str.lower)
    print(char) # ['A', 'b', 'C', 'd']
    
    # 대소문자 구별없이 내림차순으로 정렬
    char = ['b', 'A', 'd', 'C']
    char.sort(key=str.lower, reverse=True)
    print(char) # ['d', 'C', 'b', 'A']
    ```

  * 문자열 정렬 : 첫 문자를 기준으로 정렬

    ```python
    ids = ['SKY', 'Blue', 'Green', 'eBook', 'red']
    ids.sort()
    print(ids) # ['Blue', 'Green', 'SKY', 'eBook', 'red']
    
    # 대소문자 구분엾이 정렬
    ids = ['SKY', 'Blue', 'Green', 'eBook', 'red']
    ids.sort(key=str.lower)
    print(ids) # ['Blue', 'eBook', 'Green', 'red', 'SKY']
    ```

* `reverse()` : 원본 리스트 변경

  * 역순으로 원본 리스트 변경 (정렬이 아닌 역순으로 순서를 변경)
  * 리스트.reverse()

  ```python
  scores = [90, 78, 81, 64, 89]
  scores.reverse()
  print(scores) # [89, 64, 81, 78, 90]
  ```

* `sorted()` : 원본 유지하면서 정렬된 새로운 리스트 반환(내장 함수)

  ```python
  a = [3, 5, 2, 1, 4]
  b = sorted(a)
  
  print(a) # [3, 5, 2, 1, 4]
  print(b) # [1, 2, 3, 4, 5]
  ```



* `max()` / `min()` : 리스트내에서 최대 최소값 반환

  ```python
  n = [100, 7, -2, 99, 30]
  print('최대 :', max(n)) # 100
  print('최소 :', min(n)) # -2
  ```

  * 문자는 **아스키 코드** 값으로 비교

  ```python
  n = ['c', 'a', 'D', 'A', 'b']
  
  # A(65) a(97)
  # B(66) b(98)
  # C(67) c(99)
  # D(68)
  
  print('최대 :', max(n)) # c
  print('최소 :', min(n)) # A
  ```



## 리스트 일치 검사

* 비교 연산자를 사용하여 2개의 리스트 비교

* ==, !=, >, < 등

* 첫 번째 요소부터 비교 시작

* 첫 번째 요소의 비교에서 결과가 False 이면 더이상 비교하지 않고 종료

* 첫 번째 요소가 동일하면 두 번째 요소 비교...

* 리스트 안의 모든 요소 비교 결과가 True 이면 모두 True

  ```python
  l1 = [1, 2, 3]
  l2 = [1, 2,3]
  print(l1 == l2) # True
  ```

  