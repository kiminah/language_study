# animate

* `animate({이동방향:이동거리}, 시간)`

```javascript
$(document).ready(function(){
    $('div').hover(
        function(){ // 마우스가 객체위로 올라갔을 때
            $(this).animate({left:500},1000);
        },
        function(){ // 마우스가 객체에서 나왔을 때
            $(this).animate({left:0},4000);
        }); // hover close
});
```

 

* `animate` 발생 전 `delay` 선언

```javascript
$(function(){
    $('#startBtn').on('click',function(){
        $('div').each(function(index){
            $(this).delay(index*500).animate({left:500},'slow');
        }); // each close
    }); // on close

    $('#backBtn').on('click',function(){
        $('div').each(function(index){
            $(this).delay(index*500).animate({left:0},'slow');
        }); // each close
    }); // on close
});
```



* `animate` 이동 거리 점진적 증가 사용 시 작은따옴표로 묶어주기
* `clearQueue()` : 실행중인 animate들 실행 종료

```javascript
$(function(){
    $('#box1').animate({left:'+=100'},1000)
        .animate({width:'+=100'},2000)
        .animate({height:'+=100'},2000);
    
    // 6초 후에 함수 실행
    setTimeout(function(){
        // 애니메이션 큐 제거
        $('div').clearQueue();
        $('div').hide();
    },6000);

    $('#box2').animate({left:'+=100'},1000)
        .animate({width:'+=100'},2000)
        .animate({height:'+=100'},2000,
                 function(){
        $(this).css('transform','rotate(30deg)')
    });

}); // ready close
```

