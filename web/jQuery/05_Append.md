# Document 요소 추가

## 1. 태그 추가

* `prepend` / `append`
* `before` / `after`
* `empty` / `remove`

```javascript
$(document).ready(function() {
    //<img> 태그 내용을 변수에 저장
    var img="<img src='image/banana.png'>"

    // prepend 버튼 클릭했을 때
    $('#prepend').on('click',function(){
        $('#box').prepend(img);
    });

    // append 버튼 클릭했을 때
    $('#append').on('click',function(){
        $('#box').append(img);
    });

    // before 버튼 클릭했을 때
    $('#before').on('click',function(){
        $('#box').before(img);
    });

    // after 버튼 클릭했을 때
    $('#after').on('click',function(){
        $('#box').after(img);
    });

    // empty 버튼 클릭했을 때
    $('#empty').on('click',function(){
        $('#box').empty(img);
    });

    // remove 버튼 클릭했을 때
    $('#remove').on('click',function(){
        $('img').remove();
    });

    // 초기화 버튼 클릭했을 때
    $('#initiate').on('click',function(){
        // 원래 상태로 다시 적용
        $('div').empty().append("div 내부 <img src='image/apple.png'>");
    });
});
```



## 2. 속성 추가

* `attr()`

```javascript
$(function(){
    $('#img')
        .on('mouseover',function(){
        $(this).attr('src','image/star.png');
    })
        .on('mouseout',function(){
        $(this).attr('src','image/heart.png');
    })
});
```

