<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SSJA</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="/js/barscript.js">

  </script>
  <script src="/js/footer.js">

  </script>
   <meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
  <link href="/css/footerstyle.css?after" rel="stylesheet">
  <link href="/css/barstyle.css?after" rel="stylesheet">

  <link rel="stylesheet" href="https://webfontworld.github.io/NanumSquare/NanumSquare.css">

  <style>
#notice_write_form{
border-right:1px solid #ccc;
border-bottom:1px solid #ccc;
border-left:1px solid #ccc;
min-height:400px;
}

  </style>
</head>

<body>
  <header>
    <div id="title_bar" class=" fixed-top">
      <div class="py-2 px-1" id="top-bar">

        <button type="toggle-button" class="top_btn" id="top_btn"></button>
        <a id="logo_toHome" href=""><img id="logo_img" src="/images/utilities/logoSSJA.png"></a>
        <form action="/logout" id=searchForm method="post">

        </form>
        <button id="search_icon"></button>
        <a id="cart_link"><img id="cart_img"></a>
        <a id="user_link"><img id="login_img"></a>
      </div>

    </div>
    <nav id="total_bar">
      <div id="home_user_bar"> </div>
      <div id="sub_bar"></div>
    </nav>
  </header>

  <div id="side_bar"> 
    <div id="side_links" class="w-100"></div>
</div>
<main>
  <div id="main_container" style="min-height: 400px; width: 70%;">
    <form action="/adminPage/notice/${currentNotice.bno }/renew" method="post">
        <div id="notice_write_div">
            <div id="adimnPage_notic_title" class="mt-5 py-5" style="background: #ccc;">
                <h2 style="margin-left: 2em; font-weight: bold;">관리자 - 공지사항 수정</h2>
            </div>
        </div>

        <div id="notice_write_form" class="px-5 mb-5 w-100">
            <div class="d-flex flex-row pt-5">
                <div id="form_category" class="mx-3" style="width: 20%;">
                    <label for="btitle" style="margin-bottom:60px;">공지 제목 :</label><br>
                    <label for="bcontent">공지 내용 :</label>
                </div>
                <div style="width: 75%;">
                    <div id="form_title" style="width: 100%; margin-right: 1em;">
                        <input type="text" name="btitle" id="btitle" style="width: 80%;margin-bottom:50px;" value="${currentNotice.btitle }">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </div>

                    <div id="form_content" style="width: 100%; position: relative; overflow: hidden;">
                        <textarea name="bcontent" id="bcontent" style="width: 80%; height: 200px; resize: none; overflow-y: scroll;">${currentNotice.bcontent }
                        </textarea>
                    </div>
                </div>
            </div>

            <div id="btn_div" class="d-flex flex-row justify-content-center align-items-center">
                <button type="submit" class="btn btn-dark" style="width: 5em; height: 3em; margin: 1em;">작성</button>
                <a href="/adminPage/notice" class="btn btn-secondary" style="width: 5em; height: 3em; margin: 1em;lineheight:3em;">취소</a>
            </div>
        </div>
    </form>
</div>


  </main>


  <footer>
    <div id="first_footer" class="p-3"></div>
    <div id="second_footer"></div>
    <div id="third_footer"></div>
  </footer>
  
   <sec:authorize access="isAuthenticated()">
  <script src="/js/login_user_tab.js"> </script>
  <script src="/js/user_cart_tab.js"> </script>
</sec:authorize>


</html>