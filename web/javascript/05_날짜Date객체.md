# 날짜Date객체

```html
<script type="text/javascript">
        // date 객체 선언
        var today=new Date();

        //var year1=today.getYear();
        var year=today.getFullYear();
        var month=today.getMonth()+1; //0:1월~11:12월
        var date=today.getDate();

        //요일 설정
        var day; // 요일 저장할 변수
        switch(today.getDay()){
            case 0: day='일'; break;
            case 1: day='월'; break;
            case 2: day='화'; break;
            case 3: day='수'; break;
            case 4: day='목'; break;
            case 5: day='금'; break;
            default: day='토';
        }

        document.write("오늘은 " + year + "년 " + month + "월 " + date + "일 " + day + "요일 입니다.");

        var hour=today.getHours();
        var minute=today.getMinutes();
        var second=today.getSeconds();

        document.write("<br>지금은 " + hour + "시 " + minute + "분 " + second + "초 입니다.");

        document.write("<br>getTime():" + today.getTime());
        document.write("<br>toLocaleString(): " + today.toLocaleString());
        document.write("<br>toGMTString(): " + today.toGMTString());

</script>
```

