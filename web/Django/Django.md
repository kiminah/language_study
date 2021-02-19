# Django

![image-20210202113448145](md-images/image-20210202113448145.png)

1. `pip install django`

2. 프로젝트 생성과 동시에 시작

   `django-admin startproject 프로젝트명 [프로젝트시작위치] `

   : 위 명령어는 가상환경 안에서 작업되어야 함

   : 대부분 프로젝트는 최상위 폴더에서 생성(파이참프로젝트 폴더내에 생성)

3. 앱시작 `django-admin startapp 앱명`

   django-admin startapp bookmark

4. `settings.py` 파일을 열어서 `app 등록`해야함

   INSTALLED_APPS=[

   ...

   ...

   '앱명',    // 마지막 문단이어도 `,` 붙여야 함

   ]

5. migrate => model 과 관련된 기능을 추가시키는 작업

   dbms의 구조를 변경하는 작업이 일어나면(모델링-테이블생성, 테이블 수정, 필드수정) migrate 진행

   단, 생성 후 한번은 migrate만 진행

   `model 변경하면(모델링) -makemigration` 후에 migrate 명령을 진행함

   `python manage.py migrate`

6. 서버 구동 확인

   `python manage.py runserver`



## admin 사이트 사용하기 위한 준비

서버주소:8000/admin 접속

1. 슈퍼유저 생성(관리자)

   `python manage.py createsuperuser`

   root/0000

   

## 장고 프로젝트 생성 시 환경 설정(서버 종료 후 작업)

config/setting.py

```python
DEBUG = True # 개발자모드/ False : 운영모드

ALLOWED_HOSTS = [] # 기동할 서버의 ip 나열
ALLOWED_HOSTS = ['localhost','127.0.0.1','192.168.56.101']
# 서버주소 localhost 127.0.0.1 192.168.56.101 을 사용할 수 있다.
ALLOWED_HOSTS = ['*'] # 모든 ip로 서버 운영 가능
ALLOWED_HOSTS = [] # 기본 127.0.0.1로 운영
INSTALLED_APPS = [ # 프로젝트에 등록된 app
    # 프로젝트에 포함되는 모든 app는 등록되어야 함
    
# db 설정
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3', # 변경하려는 db 엔진명 찾아서 기록
        'NAME': BASE_DIR / 'db.sqlite3', # 해당 dbms 파일 경로 및 이름
    }
}
    
# 타임존 변경
TIME_ZONE = 'Asia/Seoul'

# 정적파일 경로 설정    
STATIC_URL = '/static/' # js, css, image 파일은 /static/ 에 둬야 한다. base_dir 밑에 static 폴더 생성해야 함
```



## Model 생성

1. model.py 가 생성되어야 함 (기본 생성 - app 별로 생성)

   ** 모델 설계가 되어 있어야 함

2. model 관련 코딩

   ```python
   class Cafe(models.Model) :
       # 짧은 텍스트 : 최대 길이 50
       name=models.CharField(max_length=50)
       # 긴 텍스트 필드
       content=models.TextField()
   
       def __str__(self):
           return self.name # name을 대표 필드로 설정
   ```

   

3. admins.py에 등록(필요한 경우)

   `admin.site.register(모델클래스명(테이블명))`

   admin.site.register(Cafe)

4. `python manage.py makemigrations` 명령을 수행

   데이터베이스에 변경이 필요한 사항을 추출하라는 뜻

5. `manage.py migrate`

   데이터베이스에 변경사항을 반영

6. 반영 확인 (admin 사이트에서 확인)

   각 dbms 인터페이스툴로 확인



## url conf 작업

1. urls.py 파일에 url patterns 등록

   **url/view 매핑 정의 방식은 항상 동일. url 패턴 매칭을 위에서 아래로 진행하면서 정의해야 함. 순서 유의**

   ```python
   path('polls/', views.index, name='index'), # 서버주소/polls/
   path('polls/<int:question_id>/', views.detail, name='detail'), # 서버주소/polls/5
   path('polls/<int:question_id>/results/', views.result, name='results'), # 서버주소/polls/5/results
   path('polls/<int_question_id>/vote/', views.vote, name='vote'), # 서버주소/polls/5/vote
   ```

   * question_id 는 설문 고유번호 - 클라이언트 측에서 설문 고유번호랑 같이 url 요청

   * /polls/7/results 라면 view 함수 호출시 views.results(request,question_id=7)과 같이 호출

     

* path(route, view, kwargs, name) → 시스템의 경로/웹의 주소 경로 등 경로 생성시 사용되는 함수
  * route : url 패턴(시스템경로)을 표현하는 문자열 - url 스트링 (필수 인수)
  * view : url 스트링으로 매칭되면 호출되는 뷰 함수 (필수 인수)
  * kwargs : url 스트링에서 추출된 항목 외에 추가적인 인자를 뷰 함수에 전달할 때 파이썬 사전 타입으로 인자를 정의 (생략 가능)
  * name : 각 url 패턴별로 이름을 부텽줌 - 템플릿에서 사용 (생략 가능)

* url은 각 app 별로 분리해서 사용하는 것이 좋다.

  * 프로젝트(config)의 urls.py → 공통패스(url)만 설정

    ⇒ 프로젝트의 urls.py 에 path('앱의 최상단 url', include('polls.urls'))

    ex) path('polls/', include('polls.urls'))

  * 앱(polls)의 urls.py → 앱 전용 url 설정해서 사용

    ⇒ 앱 디렉터리 밑에 urls.py 생성

## view.py에 app logic 코딩

