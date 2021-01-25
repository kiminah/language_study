# Event

## 1. mouseEvent

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>mouseEvent</title>
    <script type="text/javascript">
        window.onload=function(){
            var birdImg=document.getElementById("birdImg");

            // 이미지에 마우스 올렸을 때 이벤트 처리하는 함수(콜백함수로 생성)
            birdImg.onmouseover=function(){
                birdImg.style.opacity=0.5; // 투명도 변경
            };
            birdImg.onmouseout=function(){
                birdImg.style.opacity=1; // 투명도 변경
            };
        };
        document.oncontextmenu=function(){ // 문서상에서 오른쪽 마우스를 클릭했을 때 이벤트 처리
            alert("마우스 오른쪽 버튼 사용을 금지합니다.");
            return false; // 컨텍스트 메뉴 출력을 false로 전달해서 종료
        };
    </script>
</head>
<body>
    <img id="birdImg" src="image/bird.jpg">
</body>
</html>
```



## 2. addEventListener

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>addEventListener</title>
    <script type="text/javascript">
        var greenBtn;
        var redBtn;
        var h2;

        window.onload=function(){
            greenBtn=document.getElementById("greenBtn");
            redBtn=document.getElementById("redBtn");
            h2=document.getElementById("h2");

            greenBtn.addEventListener("click",changeToGreen);
            redBtn.addEventListener("click",changeToRed);
        };
        function changeToGreen(){ // 다른 곳에서도 사용 가능한 함수
            h2.style.color='green';
        };

        function changeToRed(){ // 다른 곳에서도 사용 가능한 함수
            h2.style.color='red';
        };


    </script>
</head>
<body>
    <h2 id="h2">색상변경</h2>
    <button id="greenBtn">green</button>
    <button id="redBtn">red</button>

</body>
</html>
```

