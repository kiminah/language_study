# iris 품종 예측(분류)

- 사이킷런 로딩

  ```python
  import sklearn
  ```

- 예측을 위한 필요 모듈 로딩

  ```python
  from sklearn.datasets import load_iris # 내장 데이터 셋
  from sklearn.tree import DecisionTreeClassifier # 결정트리 모델(트리 알고리즘 카테고리)
  from sklearn.model_selection import train_test_split # 학습데이터와 테스트 데이터 분리 함수
  ```

- 그 외 모듈

  ```python
  import pandas as pd
  import numpy as np
  ```

  

- data : 피처의 데이터 세트
- target : (분류)레이블 값, (회귀) 숫자 결과값

- target_names : 개별 레이블 이름

- feature_names : 피처의 이름

  ```python
  ## 데이터 세트 확인하기
  # 데이터 로딩
  iris = load_iris()
  iris ## dict 구조
  
  ## iris item 확인
  iris_data = iris.data #  변수 실제값
  iris_label = iris.target # 목적 변수 실제값
  print("iris target 명 : ",iris.target_names) # 목적변수 명
  col = iris.feature_names # 변수명
  ```



## 학습데이터와 테스트데이터 분리

### train_test_split(data, target, test_size, ...)

```python
### 학습 데이터와 테스트 데이터로 분리
X_train, X_test, y_train, y_test = train_test_split(iris_data, iris_label, 
                                                    test_size=0.2, random_state=11) 
# random_state=11 : seed
```



## 학습 수행

- 학습데이터로 학습 수행해야 함 (테스트 데이터로 진행하면 안 된다.)

  ```python
  ## 모델 객체 생성 - 의사결정 트리객체 사용
  dt_clf = DecisionTreeClassifier(random_state=11) # 내부 알고리즘에서 random 진행이 있으므로 seed 고정
  
  ## 학습
  dt_clf.fit(X_train, y_train)
  ```

  - 학습은 어디서나 fit() 함수 사용



## 예측 수행

- 테스트 데이터로 예측

  ```python
  pred = dt_clf.predict(X_test)
  
  # 평가 - 예측 정확도
  from sklearn.metrics import accuracy_score
  print("예측 정확도 : {0:.4f}".format(accuracy_score(y_test, pred)))
  ```

  