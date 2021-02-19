

1. pip install django
2. django-admin startproject 프로젝트명
3. django-admin startapp 앱명
4. settings.py에서 app 등록
   * INSTALLED_APP=['앱명',]



* 최상단에 폴더 static 생성 후 그 안에 img 파일 저장

* html에서 static에 저장된 이미지 사용방법

  * img src="{% static '파일명' %}" 

    

##### 두번째 페이지

* 접속 url http://서버주소:포트번호/cafelist

  * 처리함수 cafelist

* Cafe model 생성

  * model.py

* root 생성

  * python manage.py createsuperuser

    

* cafe 테이블에 데이터 3개 입력

  * http://서버주소:포트번호/admin에서 데이터 입력 

    카페이름

    카페내용

    

* cafe object를 cafe name으로 표시되게 변경

  * model.py에 class 안에서 선언

    `def __str__(self): return self.name`

    

* cafe 테이블에 저장된 리스트 (views.py)



##### cafedetails 페이지 생성

1. url 등록

   cafelist/세부페이지id  `<int:pk>`

   처리함수 cafedetails

2. views.py에 cafedetails 함수 등록

   페이지 id에 해당하는 레코드 하나 추출해서 그 결과를 html로 반환

3. cafedetails.html 파일 생성한 후에

   반환받은 내용 출력



## image 업로드 구현

1. models에서 사진을 저장할 공간 만들기

   : 필드의 속성 => models.ImageField(blanck=True, null=True)

   black=True : 필수 입력 속성은 아니다라는 의미

   null=True : 레코드에 값이 저장되어 있지 않아도 된다.

2. 이미지 업로드에 필요한 패키지 설치

   pip install Pillow

3. model migration & migrate

4. 업로드되는 이미지 저장공간을 지정(url도 지정해야 함) - settings.py

   MEDIA라는 디렉터리르 운영해야 함

5. urls.py에 media 디렉터리 url 설정

   urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)