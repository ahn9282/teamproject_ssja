<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>T 9</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

 
  <script src="/js/footer.js">
  </script>
  <script src="/js/barscript.js">
  </script>
  
   <link href="/css/footerstyle.css?after" rel="stylesheet">
  <link href="/css/barstyle.css?after" rel="stylesheet">
  <link rel="stylesheet" href="https://webfontworld.github.io/NanumSquare/NanumSquare.css">

 

  <style>
    input:focus {
      outline: none;
      border-color: #ffffff;
    }

    @font-face {
      font-family: 'fonts';
      src: url("https://webfontworld.github.io/NanumSquare/NanumSquare.css") fotmat('font1');
    }

    body {
      font-family: 'fonts', NanumSquare;
      background-color: #f7f0e8;
    }
    input[type=password]{
      font-family: sans-serif;
    }
    #logo_img {
      width: 3.5em;
      height: 3em;
    }
    /* 로그인 추가코드 */
    #recover a{
      color: black;
      text-decoration: none;
    }
    #recover button{
      background-color: transparent; 
      border-color: transparent;
    }
    #social_login button{
      width: 50px;
      height: 50px;
      border: 0px;      
    }
    #social_login button:nth-child(2){
      background: no-repeat url('/images/utilities/naver.png');
      background-size: cover;
    }
    #social_login button:nth-child(3){
      background: no-repeat url('/images/utilities/kakao.png');
      background-size: cover;
    }
    #social_login button:nth-child(4){
      background: no-repeat url('/images/utilities/google.png');
      background-size: cover;
    }
  </style>
  <script>
    $(document).ready(function(){
      let find_id_btn=$('#findId');
      let find_pw_btn=$('#findPw');
    
      find_id_btn.on("click",function(){
        var popup=window.open("/sign/findId","_blank", "width=500, height=700");
      })
      find_pw_btn.on("click",function(){
        var popup=window.open("/sign/findPw","_blank", "width=500, height=700");
      })
  })
  </script>
</head>

<body>
  <header>
    <div id="title_bar" class=" fixed-top">
      <div class="py-2 px-1" id="top-bar">

        <button type="toggle-button" class="top_btn" id="top_btn"></button>
        <a href="${pageContext.request.contextPath}/"><img id="logo_img" src="/images/utilities/logoSSJA.png"></a>
        <form action="http://www.naver.com" id=searchForm method="get">
        
        </form>
        <a id="cart_link"><img id="cart_img"></a>
        <a id="user_link"><img id="login_img"></a>
      </div>

    </div>
    <nav id="total_bar">
      <div id="home_user_bar"> </div>
      <div id="sub_bar"></div>
    </nav>
  </header>

  <div id="side_bar"></div>
  <main style="background-color: #f7f0e8; height: 650px;" >
    <!--로그인추가부 -->
    <div id="main_container" class="d-flex flex-column justify-content-center align-items-center " >
      <img class="mb-4" src="/images/utilities/big_logo.png" alt="">
      <c:if test="${not empty errorMessage}">
    <div class="error">${errorMessage}</div>
</c:if>
      <!-- 실제 사용시 post로 변경 링크추가 -->
      <form action="${pageContext.request.contextPath}/loginCheck" method="post">
        <table class="text-center">
          <tr>
            <!-- 시큐리티 설정에 따라 name 변경 -->
            <td><input type="text" name="username" class="mb-3 form-control" id="id" size="26" placeholder="아이디"></td>
          </tr>
          <tr>
            <td><input type="password" name="password" class="mb-3 form-control" id="pw" size="26" placeholder="비밀번호" aria-describedby="passwordHelpBlock"></td>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </td>
          </tr>
          <tr>
            <td><input type="submit" class="w-100 btn btn-dark mb-1" value="로그인" ></td>
          </tr>
          <tr>
            <td id="recover">
              <button id="findId" type="button">아이디찾기</button>|
              <button id="findPw" type="button">비밀번호찾기</button>|
              <a href="${pageContext.request.contextPath}/sign/sign_up_before">회원가입</a>
            </td>
          </tr>
        </table>
        <input type="hidden" name="_csrf" value="{{_csrf.token}}" /> 

        <div class="border-bottom text-center my-3">
          <p class="mb-1" style="font-size: 1.3rem;">다른 방법으로 로그인</p>
        </div>
        <div id="social_login" class="d-flex justify-content-between">
          <span></span>
          <!-- a태그추가 또는 클릭이벤트 추가 -->
          <button type="button"></button>
          <button type="button"></button>
          <button type="button"></button>
         
          <span></span>
        </div>
      </form>
    </div>

  </main>

  <footer>
    <div id="first_footer" class="p-3"></div>
    <div id="second_footer"></div>
    <div id="third_footer"></div>
  </footer>

</body>

</html>