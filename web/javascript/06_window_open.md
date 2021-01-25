# window_open

> 새창 열어주는 함수

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>window_open</title>
    <script type="text/javascript">
        function showBigImage(){
            window.open("bigimage.html","bigwin","width=699,hegiht=800,top=50");
        }
    </script>
</head>
<body>
    <center>
        그림에 마우스를 가져가면 <br>
        그림을 크게 볼 수 있습니다. <br><br>
        <img src="image/고흐.jpg" width="118" height="146" onmouseover="showBigImage()">
    </center>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>윈도우오픈예제</title>
    <script type="text/javascript">
        // window_open.html 창 열기
        function openWindow(){
            window.open("window_open.html","Big Image","width=200, height=200,status=yes, scrollbars=yes, resizable=yes");
        }

        // 새창 만들기
        // 창 객체를 이용해서 구성
        function openNewWindow(){
            createWin=window.open("","createWin","width=400,height=150");
            createWin.document.write("createWin 이름으로 새로 만든 창입니다.")
            createWin.document.write("<p><button onclick='window.close()'>닫기</button></p>");
        }
    </script>
</head>
<body>
    <button onclick="openWindow()">Big Image 열기</button>
    <button onclick="openNewWindow()">새창 열기</button>
</body>
</html>
```