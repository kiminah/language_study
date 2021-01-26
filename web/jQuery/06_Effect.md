# Effect

## 1. Basic Effect

``` javascript
$(function(){
    $('#show').on('click',function(){
        $('img').show('slow');
    });

    $('#hide').on('click',function(){
        $('img').hide('fast');
    });

    $('#toggle1').on('click',function(){
        $('img').toggle(500);
    });
    $('#toggle2').on('click',function(){
        $('img').toggle(3000,'swing');
    });
    $('#toggle3').on('click',function(){
        $('img').toggle(3000,'linear'); // 일정한 속도
    });
});
```



## 2. Slide Effect

* 공간이 유동적으로 생기는 함수

```javascript
$(function(){
    $('#menuBox').hover(
        function(){
            $('#subMenuBox').slideDown(1000);
        },
        function(){
            $('#subMenuBox').slideUp(1000);
        }
    );
});
```



## 3. Fade Effect

* 공간 유동적 유/무

```javascript
$(function(){
    $('#fadeIn').on('click',function(){
        $('h2').fadeIn('slow');
    });

    $('#fadeOut').on('click',function(){
        $('h2').fadeOut(2000);
    });

    $('#fadeToggle').on('click',function(){
        $('h2').fadeToggle(3000,'linear');
    });
});
```



## 4. FadeTo Effect

* 공간 유지

```javascript
$(function(){
    $('#off').on('mouseover',function(){
        $('img').fadeTo(1000,0);
    });

    $('#on').on('mouseover',function(){
        $('img').fadeTo(1000,1);

    });

    $('#50').on('mouseover',function(){
        $('img').fadeTo(1000,0.5);

    });
});
```