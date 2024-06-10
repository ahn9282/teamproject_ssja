<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
   <meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

  <script src="/js/barscript.js">

  </script>

  <script src="/js/footer.js">

  </script>
  <link href="/css/footerstyle.css?after" rel="stylesheet">
  <link href="/css/barstyle.css?after" rel="stylesheet">

  <link rel="stylesheet" href="https://webfontworld.github.io/NanumSquare/NanumSquare.css">

  <style>
    @font-face {
      font-family: 'fonts';
      src: url("https://webfontworld.github.io/NanumSquare/NanumSquare.css") fotmat('font1');
    }

    body {
      font-family: 'fonts', NanumSquare;
      background-color: #f7f0e8;
    }

    #logo_img {
      width: 3.5em;
      height: 3em;
    }
  </style>
  <style>
.MyPage_btn {
	background-color: white;
	padding: 20px;
}

#MyPage_point {
	margin-left: auto;
}

#select_dv {
	margin: 2em;
	height: auto;
}

#content_dv {
	width: 80%;
	margin: 2em;
}

#MyPage_content_name {
	background-color: #f7f0e8;
	padding: 3em;
}

#MyPage_content_name>h1 {
	font-weight: bold;
	margin-left: 1em;
}

#select_MyPage {
	z-index: 900;
	position: fixed;
	top: 30%;
	left: 5%;
	width: 12%;
}

#select_mp_top {
	background-color: #f7f0e8;
	padding: 2em;
	height: auto;
}

#userInfo_dv1 {
	display: flex;
	flex-direction: row;
	align-items: center;
}

#userInfo_dv1>h2 {
	margin-left: 1em;
	margin-right: 1em;
}

#userInfo_dv2 {
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-items: center;
	height: auto;
}

#userInfo_coupons, #userInfo_points, #userInfo_wishs {
	border-left: 1px solid #cccccc;
}

#userInfo_dv2>div {
	font-weight: bold;
	margin-top: 1em;
	margin-bottom: 1em;
	padding: 5px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	height: auto;
	width: 100%;
}

#your_address>input {
	border: none;
}

@media ( max-width : 1120px) {
	#select_MyPage {
		left: 0%;
		top: 25%;
	}
}

@media ( max-width : 780px) {
	#select_content {
		display: none;
	}
	#select_mp_top {
		padding-left: 0;
		padding-right: 0;
	}
}

#status_dv>span {
	color: #ccc;
	margin-left: 1em;
}

#select_mp_top {
	cursor: pointer;
}

#paging_dv>button {
	background-color: white;
	border: 1px solid #ccc;
	color: #ccc;
}

#Input_info_title>div {
	padding: 2rem;
	padding-left: 3em;
	font-weight: bold;
	max-height: 8rem;
	min-height: 8rem;
	font-size: 1.2em;
}

#Input_info_apply>div {
	padding: 2rem;
	display: flex;
	flex-direction: row;
	align-items: center;
	max-height: 8rem;
	min-height: 8rem;
}

#Input_info_apply>div>input {
	width: 15em;
	border-radius: 5px;
}

#Input_info_apply>span {
	color: #aaa;
}
#userlink {
    position: relative;
    display: inline-block;
}

#login_user_div {
    display: none;
    position: absolute;
    top: 75%;
    background: white;
    border: 1px solid #ccc;
    padding: 10px;
    z-index: 1000;
    display:flex;
    flex-direction:column;
    align-items:center;
}
#login_user_div button{
background:white;
padding:15px;
text-align:center;
border:none;
}
#totalInfo_container{
display:none;
z-index:999;
position:absolute;
top:50%-300px;
left:50%-400px;
}
#paging_modal_dv > button{
border:none;
background:white;
}
#span_porductName, #longpronamespan{
 white-space: nowrap; 
    overflow: hidden; 
    text-overflow: ellipsis; 
    width: 50%; 
}
#coupon_select_dv > button{
width:20%;
height:auto;
}
#star_rating .star {
  width: 25px; 
  height: 25px; 
  margin-right: 10px;
  display: inline-block; 
  background: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FE2bww%2FbtsviSSBz4Q%2F5UYnwSWgTlFt6CEFZ1L3Q0%2Fimg.png') no-repeat; 
  background-size: 100%; 
  box-sizing: border-box; 
}
#star_rating .star.on {
  width: 25px; 
  height: 25px;
  margin-right: 10px;
  display: inline-block; 
  background: url('https://blog.kakaocdn.net/dn/b2d6gV/btsvbDoal87/XH5b17uLeEJcBP3RV3FyDk/img.png') no-repeat;
  background-size: 100%; 
  box-sizing: border-box; 
}
</style>
</head>

<body>
<sec:authentication property="principal" var="principal" />
  <header>
    <div id="title_bar" class=" fixed-top">
      <div class="py-2 px-1" id="top-bar">

        <button type="toggle-button" class="top_btn" id="top_btn"></button>
        <a id="logo_toHome" href=""><img id="logo_img" src="/images/utilities/logoSSJA.png"></a>
        <form action="http://www.naver.com" id=searchForm method="get">

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
		   <div id="select_MyPage" class="d-flex flex-column">
		    <div id="select_mp_top" class="text-center">마이 페이지</div>
		    <div id="select_content">
		        <button class="MyPage_btn w-100" id="myPage_userInfo_Select" style="border:1px solid #cccccc">회원 정보</button>
		        <button class="MyPage_btn w-100" id="myPage_orderInfo_Select" style="border:1px solid #cccccc">주문 내역</button>
		        <button class="MyPage_btn w-100" style="border:1px solid #cccccc">내가 쓴 글</button>
		        
		        <!--  principal객체를 꺼내서 해당 객체의 auth값을 yourAuth변수로 지정 -->
		     <sec:authentication property="principal.auth" var="yourAuth"/> 
		     
		       <c:if test="${principal.isOAuth2User() == true }">
		       <button class="MyPage_btn w-100" style="border:1px solid #cccccc" id="not_authorized_vendor_apply">판매자 신청</button>
		       </c:if> 
		 <c:if test="${yourAuth == 'ROLE_USER'}"><!-- 유저 권한 -->
		    <c:if test="${principal.isOAuth2User() == false }">
		        <button class="MyPage_btn w-100" style="border:1px solid #cccccc" id="vendor_apply">판매자 신청</button>
		        </c:if>
			</c:if>
			
			 <c:if test="${yourAuth == 'ROLE_VENDOR'}"><!--  판매자 권한일 경우 대체 되는 버튼 -->
		        <button class="MyPage_btn w-100" style="border:1px solid #cccccc" id="mange_yoursell">판매 관리</button>
		        </c:if>
		        
			 <c:if test="${yourAuth == 'ROLE_ADMIN'}"><!--  판매자 권한일 경우 대체 되는 버튼 -->
		        <button class="MyPage_btn w-100" style="border:1px solid #cccccc" id="mange_yoursell">판매 관리</button>
		        </c:if>
		        
		        <button class="MyPage_btn w-100" style="border:1px solid #cccccc" id="go_qna">문의 및 요청</button>
		    </div>
		</div>
  <main>
  
    <div id="main_container" class="d-flex flex-row align-items-center justify-content-center" >
      <div id="content_dv" >
        <div id="MyPage_content_name" > </div>
        <div id=main_div>
        <div id="MyPage_content_container" class="border">
        </div>
        </div>
      </div>
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

   <div class="modal fade" id="totalInfoModal" tabindex="-1" aria-labelledby="totalInfoModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width:800px; height:700px; background-color:white;">
                <div class="modal-header">
                    <h5 class="modal-title" id="totalInfoModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                  <div class="modal-body" id="totalInfoContent">
					<p>Modal body text goes here.</p>
						</div>
                <div class="modal-footer d-flex flex-row justify-content-center" id="totlaInfoTooter">
         
                </div>
            </div>
        </div>
    </div>

</body>

<script src="/js/myPage/userMyPage.js"></script>
<script src="/js/myPage/userOrders.js"></script>
<script src="/js/myPage/applyVendor.js"></script>
<script>
let path = window.location.pathname;
 if (path === '/myPage/orderInfo') {
    myPageOrderInfo(1);
}else{
	
    myPageUserInfo();
}

</script>

</html>