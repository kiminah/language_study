# Django 중요 요소

#### HTML에서 변수선언

![image-20210202113551151](md-images/image-20210202113551151.png)

* {{변수명}}

#### HTML에서 IF, FOR문 선언

* {% if ~ %} ~~{% endif %}
* {% for ~ %} ~~{% endfor %}

#### question.choice_set.all 

- question과 choice를 조인해서 현재 question_id에 해당하는 레코드 전부를 갖고 옴

#### {% csrf_token %}

* 장고의 고유 명령어 : 잘못된 접근에 대비해서 기존 csrf 번호와 접근시 가져온 번호를 대조한 후 번호가 다르면 거부 처리를 해서 줌



#### form 태그 action

* `'<form action="{% url 'polls:vote' question.id %}" method="post">`

![image-20210202114042293](md-images/image-20210202114042293.png)

#### 템플릿 필터

![image-20210202113615488](md-images/image-20210202113615488.png)



## ERROR

* RuntimeError: Model class django.contrib.sites.models.Site doesn't declare an explicit app_label and isn't in an application in INSTALLED_APPS. 에러 발생시

  settings.py에 

  1. SITE_ID=1 넣어두기
  2. App 등록 'django.contrib.sites', --> allauth 전에 선언되어야 함

  