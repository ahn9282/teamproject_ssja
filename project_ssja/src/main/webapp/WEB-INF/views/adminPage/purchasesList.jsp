<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SSJA</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
	
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/js/barscript_admin.js"></script>
<script src="/js/footer.js"></script>
<link href="/css/footerstyle.css?after" rel="stylesheet">
<link href="/css/barstyle.css?after" rel="stylesheet">
<link href="/css/board.css?after" rel="stylesheet">

<link rel="stylesheet"
	href="https://webfontworld.github.io/NanumSquare/NanumSquare.css">
<style>
@font-face {
	font-family: 'fonts';
	src: url("https://webfontworld.github.io/NanumSquare/NanumSquare.css")
		fotmat('font1');
}

body {
	font-family: 'fonts', NanumSquare;
	background-color: #f7f0e8;
}

#logo_img {
	width: 3.5em;
	height: 3em;
}

.MyPage_btn {
	background-color: white;
	padding: 20px;
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
</style>
</head>
<body>
		<header>
		<div id="title_bar" class=" fixed-top">
			<div class="py-2 px-1" id="top-bar">
				 <button type="toggle-button" class="top_btn" id="top_btn"></button>
				<a id="logo_toHome" href=""><img id="logo_img"
					src="/images/utilities/logoSSJA.png"></a>
			</div>
		</div>
		<nav id="total_bar">
		</nav>
	</header>
	<div id="side_bar">
		<div id="side_links" class="w-100"></div>
	</div>
	<main>
		<div id="main_container"
			class="d-flex flex-row align-items-center justify-content-center">
			<div id="content_dv_productsInfo">
				<h2>주문목록</h2>
				<table class="table" style="text-align: center;">
					<thead class="table-dark">
						<tr>
							<td>주문번호</td>
							<td>구매번호</td>
							<td>총 금액</td>
							<td>총 할인액</td>
							<td>총 결제액</td>
							<td>결제수단</td>
							<td>주문일자</td>
							<td>주소</td>
							<td>배송업체</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="purchase" items="${purchases}">
							<tr>
								<td>${purchase.getPUR_NO()}</td>
								<td>${purchase.getM_NO()}</td>
								<td>${purchase.getPUR_TOT()}</td>
								<td>${purchase.getPUR_DC()}</td>
								<td>${purchase.getPUR_PAY()}</td>
								<td>${purchase.getPUR_PAYMENT()}</td>
								<td>${purchase.getPUR_DATE()}</td>
								<td>${purchase.getPUR_DVADDRESS()}</td>
								<td>${purchase.getPUR_DV()}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<form name="search-form" autocomplete="off">
					<select name="type">
						<option selected value="">선택</option>
						<option value="m_name">회원이름</option>
						<option value="m_id">아이디</option>
						<option value="m_grade">등급</option>
					</select> <input type="text" name="keyword" value=""> <input
						type="button" onclick="membersSearchList()"
						class="btn btn-outline-primary mr-2" value="검색">
				</form>
				<div id="paging_dv">
					<nav aria-label="Page navigation example">
						<ul class="pagination ch-col justify-content-center">
							<c:if test="${purchasepageMaker.prev}">
								<li class="page-item"><a class="page-link ch-col"
									href="${pageContext.request.contextPath}/adminPage/purchasesList${purchasepageMaker.makeQuery(purchasepageMaker.startPage-1)}"><</a></li>
							</c:if>
							<c:forEach var="idx" begin="${purchasepageMaker.startPage}"
								end="${purchasepageMaker.endPage}">
								<c:choose>
									<c:when test="${purchasepageMaker.criteria.pageNum == idx}">
										<li class="page-item active"><a class="page-link"
											href="${pageContext.request.contextPath}/adminPage/purchasesList${purchasepageMaker.makeQuery(idx)}">${idx}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link"
											href="${pageContext.request.contextPath}/adminPage/purchasesList${purchasepageMaker.makeQuery(idx)}">${idx}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if
								test="${purchasepageMaker.next && purchasepageMaker.endPage > 0}">
								<li class="page-item"><a class="page-link ch-col"
									href="${pageContext.request.contextPath}/adminPage/purchasesList${purchasepageMaker.makeQuery(purchasepageMaker.endPage+1)}">></a></li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</main>
	<footer>
		<div id="first_footer" class="p-3"></div>
		<div id="second_footer"></div>
		<div id="third_footer"></div>
	</footer>
</body>

</html>