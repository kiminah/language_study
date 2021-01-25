# setInterval

> 시간에 따라 반복적으로 태그를 보여주는 함수

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>setInterval</title>
    <script type="text/javascript">
        function showTime(){
            var today=new Date();
            var hour=today.getHours();
            var minute=today.getMinutes();
            var second=today.getSeconds();
            var amPm; // 오전, 오후 저장할 변수

            if(hour<12)
                amPm='오전 ';
            else{
                amPm='오후 ';
                if(hour>12)
                    hour=hour-12;
            }

            var time = amPm + hour + "시 " + minute + "분 " + second + "초";
            timeShow.innerHTML = time; // timeShow가 id나 class로 존재해야 실행됨

        }
    </script>
</head>
<body>
    <button onclick="timerID=setInterval('showTime()',1000)">시간 출력</button>
    <button onclick="clearInterval(timerID)">시간 정지</button>
    <h1 id="timeShow">시간 출력</h1>

</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>setInterval 연습문제</title>
    <script type="text/javascript">

        var count=0;
        function start(){
            alert("이미지 10개 출력");
            timerID=setInterval('showImg()',1000); // 전역변수
        }

        function showImg(){
           count++;
           if(count%2==1)
               document.body.innerHTML += "<img src='image/apple.png'>"; // 기존 코드에 추가하는 작업
           else
               document.body.innerHTML += "<img src='image/bomb.png'>";

           if(count==10)
               clearInterval(timerID);
        }

    </script>
</head>
<body onload="start()">

</body>
</html>
```

