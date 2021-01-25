# 반복문_for 문

* 반목 횟수가 결정되어 있을 때 사용

* 정해진 횟수만큼 반복

  ```python
  for 변수 in 리스트 또는 범위:
      반복해야할 문장
  ```

  ```python
  for name in ['홍길동','이몽룡']:
      print(name)
      
  for i in range(0, 10):	# 0~9
      print(i)
  ```

## 1. 리스트

* 여러 개의 data 가 하나의 공간에 저장되는 구조

  [데이터1, 데이터2, 데이터3...]

  ```python
  for name in ['홍길동','이몽룡', '성춘향', '변학도']:
      print(name)
      
      홍길동
      이몽룡
      성춘향
      변학도
  ```

  

## 2.  `range()` 함수

* 반복(for) 범위 사용

* 특정 범위의 정수 생성

  * `range(n)` : 0 ~ n 까지의 정수 생성(초기 값을 생략하면 0부터 시작)

  * `range(start, stop)` : start 에서 stop-1 까지의 정수 생성

  * `range(start, stop, step)` : start 에서 stop-1 까지 step 간격으로 정수 생성

  ```python
  for i in range(10): # 0~9
      print(i)
      
  for i in range(11, 21): # 11~20
      print(i)
      
  for i in range(1, 11, 2): # 1 3 5 7 9
      print(i)
  
  for i in range(10, 0, -1): # 10 9 8 7...
  ```

  * `range()` 함수의 초기값이 stop 값보다 클 경우에는 반드시 -step을 사용해야함

* 누적합

  * 꾝 누적변수는 먼저 생성해 둬야 한다

  ```python
  # 누적변수 생성
  sumx = 0
  
  for x in range(1,11):
      sumx += x   # 누적합
  
  print('1부터 10까지의 합:', sumx)
  
  	55
  ```

* 반복문 종료 `break`

  ```python
  # 사용자로부터 이름을 입력받아서 해당 이름이 명단에 있는지 확인하는 프로그램
  # 명단은 리스트로 임의로 구성
  
  names = ['홍길동', '이몽룡', '성춘향', '변학도']
  
  search_name = input('이름입력: ')
  
  for name in names:
      if search_name == name:
          find = True # 명단에서 이름을 발견했다는 표시
          break # 명단에 이름이 있으므로 더이상 반복을 진행하지 않는다. break 문 : 반복을 종료
      else:
          find = False
  
  if find:
      print('명단에 있습니다.')
  else:
      print('명단에 없습니다.')
  ```

## 연습문제

* 구구단 단수를 입력 받아 해당 구구단 출력하는 프로그램 작성

  ```python
  num = int(input('단 수 입력 : '))
  
  for x in range(1, 10):
      print('%d * %d = %d' % (num, x, num*x))
  ```

* 별 그리기

  ```python
  # 다중 for 문 이용할 것
  
  for x in range(4):
      for y in range(5):
          print('*', end="")
      print()
  
  print('--------')
  
  for x in range(5):
      for y in range(x+1):
          print('*', end="")
      print()
  
  # for x in range(1,6):
  #     for y in range(x):
  #         print('*', end="")
  #     print()
  
  print('--------')
  
  for x in range(5):
      for y in range(5-x):
          print('*', end="")
      print()
      
      *****
      *****
      *****
      *****
      --------
      *
      **
      ***
      ****
      *****
      --------
      *****
      ****
      ***
      **
      *
  ```

  

