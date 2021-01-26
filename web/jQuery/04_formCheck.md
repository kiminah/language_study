# formCheck

```javascript
/**
* formCheck.js
* 회원가입 폼 입력 확인
**/

$(document).ready(function(){
    $('#id').focus(); // 시작시 id에 포커스

    // input 텍스트 입력란과 비밀번호 입력란에 포커스 있을 때 색상 변경
    $('input[type=text],input[type=password]').on('focus',function(){
        $(this).css('background','rgb(232,232,232)');
    });

    //포커스 잃을때(blur)
    $(':text,:password').on('blur',function(){
        $(this).css('background','white');
    });

    // 키보드 이벤트
    // 첫 번째 번호 입력란에서 입력값이 3개가 되면 포커스 이동
    $('#hp1').on('keyup',function(){
        if($(this).val().length==3)
            $('#hp2').focus();
    });
    $('#hp2').on('keyup',function(){
        if($(this).val().length==4)
            $('#hp3').focus();
    });

    // id 입력 후 엔터키를 눌렀을 때 비밀번호로 포커스 이동
    $('#id').on('keydown',function(e){
        if($('#id').val() != "" && e.keyCode==13)
            $('#pwd').focus();
    });


    // enter 키를 눌렀을 때 무조건 submit 가 발생하므로
    // 문서에 enter 키 이벤트를 false 로 제거
    // [Enter] 키의 아스키코드 값은 : 13
    $(document).on('keydown', function(e){
        if(e.keyCode==13)
            return false;
    });

    // newMemberForm 의 submit(전송) 버튼 누를때
    $('#newMemberForm').on('submit',function(){
        if($('#id').val()==""){ // id 입력하지 않은 경우
            alert("아이디를 입력하세요.");
            $('#id').focus(); // 이 코드 만으로는 submit 발생
            return false; // 서버로 전송되지 않도록 전송기능을 막는 코드
        }

        if($('#pwd').val()==""){
            alert("비밀번호를 입력하세요.");
            $('#pwd').focus(); // 이 코드 만으로는 submit 발생
            return false; // 서버로 전송되지 않도록 전송기능을 막는 코드
        }

        if(!$('input[type=radio]').is(':checked')){ // 라디오버튼에 체크되지 않으면
            alert("학년을 선택하세요");
            return false; // 서버로 전송되지 않도록 전송기능을 막는 코드
        }

        if(!$('input[type=checkbox]').is(':checked')){ // 체크박스에 체크되지 않으면
            alert("관심분야는 1개 이상 선택하세요");
            return false; // 서버로 전송되지 않도록 전송기능을 막는 코드
        }

        if($('select').val("")){
            alert("학과를 선택하세요.");
            $('select').focus();
            return false; // 서버로 전송되지 않도록 전송기능을 막는 코드
        }
    }); // form submit close


}); // $function close
```

