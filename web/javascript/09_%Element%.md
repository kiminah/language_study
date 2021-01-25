# %Element%

## 1. createElement

```html
<script type="text/javascript">
    window.onload=function(){ // 윈도우 로딩후 함수 실행
        //1단계. 요소노드 생성(태그 생성)
        var img=document.createElement('img');
        // 속성설정
        img.src='image/bird.jpg';
        img.width=250;
        img.height=180;
        img.title='예쁜새';

        //2단계. 문서에 출력
        document.body.appendChild(img);

        //1단계. 요소 노드 생성
        var h3=document.createElement('h3');
        var text=document.createTextNode("출력할 텍스트: 이미지");

        //2단계. 문서에 출력
        //텍스트노드를 h3 태그에 연결
        h3.appendChild(text);
        //h3태그를 문서 body에 연결(출력)
        document.body.appendChild(h3)
    };
</script>
```



## 2. getElementById

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>getElementById_image</title>
    <!--  이미지와 변경 버튼을 출력 - 변경 버튼을 누르면 이미지를 교체하고 버튼의 텍스트로 완료로 변경  -->
    <script type="text/javascript">
        var imageA;
        var hint;
        var changeButton;

        // 윈도우가 로드되면 해당 엘리먼트 객체 저장
        window.onload=function(){
            imageA=document.getElementById("imageA");
            hint=document.getElementById("hint");
            changeButton=document.getElementById("changeButton");
        }

        // 요소의 속성 변환
        function change(){
            imageA.src='image/B.png'; // 이미지 교체
            hint.innerHTML='새로운 이미지로 변경되었습니다.';
            hint.style.background='red';
            changeButton.innerHTML='완료';
        }

    </script>
</head>
<body>
    <center>
        <img id="imageA" src="image/A.png">
        <div id="hint">[변경] 버튼을 누르면 이미지가 바뀝니다.</div>
        <button id="changeButton" onclick="change()">변경</button>
    </center>
</body>
</html>
```



## 3. getElementsTagName

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>getElementsByTagName</title>
    <style>
        td{width:50px;height:30px;text-align:center;}
    </style>
    <script type="text/javascript">
        window.onload=function(){
            var tdArr=document.getElementsByTagName('td'); // tdArr(문서내 모든 td 요소를 배열로 받아옴)

            // 버튼의 id
            var setNumberBtn=document.getElementById("setNumberBtn");
            var setColorBtn=document.getElementById("setColorBtn");
            var clearNumberBtn=document.getElementById("clearNumberBtn");
            var clearColorBtn=document.getElementById("clearColorBtn");

            setNumberBtn.onclick=function(){
                for(var i=0;i<tdArr.length;i++){
                    tdArr[i].innerHTML=i;
                }
            };

            setColorBtn.onclick=function(){
                var colors=['red','orange','yellow','green','blue','navy','violet'];
                for(var i=0;i<tdArr.length;i++){
                    tdArr[i].style.background=colors[i];
                }
            };

            // 지우기 버튼
            clearNumberBtn.onclick=function(){
                for(var i=0;i<tdArr.length;i++){
                    tdArr[i].innerHTML="";
                }
            };

            clearColorBtn.onclick=function(){
                for(var i=0;i<tdArr.length;i++){
                    tdArr[i].style.background="";
                }
            };

        };
    </script>
</head>
<body>
    <center>
        <div id="box">
            <table border="1">
                <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            </table>
            <p>
                <button id="setNumberBtn">셀에 번호 채우기</button>
                <button id="setColorBtn">셀에 색상 채우기</button>
            </p>
            <p>
                <button id="clearNumberBtn">셀에 번호 지우기</button>
                <button id="clearColorBtn">셀에 색상 지우기</button>
            </p>
        </div>
    </center>
</body>
</html>
```

