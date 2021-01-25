# setTimeout

> 창 자동으로 닫히는 함수

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>공지사항(msgWindow)</title>
    <script type="text/javascript">
        function winClose(){
            window.close(); // 현재창(msgWindow.html)
            opener.focus(); // 현재창을 연 부모창(opener)에 포커스 주기
        }
    </script>
</head>
<body onload="setTimeout('winClose()',3000)"> <!-- setTimeout은 1/1000초 단위로 설정 -->
공지사항<br>
이 창은 3초 후에 자동으로 닫힙니다.
</body>
</html>
```

