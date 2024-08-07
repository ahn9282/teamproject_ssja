<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>SSJA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous">
      </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="/js/barscript.js">

    </script>
    <script src="/js/footer.js">

    </script>
    <script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>

    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
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

      .product:hover {
        cursor: pointer;
      }

      .product img {
        display: inline-block;
        width: 110px;

      }

      #product_link {
        height: 100px;
        display: inline-block;
        text-decoration: none;
      }

      #product {
        background-color: white;
      }

      #product>div:first-child {
        border: 1px solid #ccc;
      }

      #product img {
        width: 150px;
        height: 100px;
      }

      #orders_product_Info {
        width: 100%;
        height: 100px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        margin: 0 0 0 5px;
      }

      #pro_bizname {
        font-weight: bold;
      }

      #pro_category,
      #pro_wish {
        color: black;
      }

      #pro_name {
        color: black;
        text-decoration: none;
        font-weight: bold;
        word-break: keep-all;
        height: 30px;
        margin-top: 5px;
        white-space: normal;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .ck-content {
        min-height: 400px;
      }

      figcaption {
        display: none;
      }
    </style>
    <script>
      var header = $("meta[name='_csrf_header']").attr('content');
      var token = $("meta[name='_csrf']").attr('content');
      history.replaceState({}, null, location.pathname);
      $(document).ready(function () {

        let product_update = $("#product_update");
        let search_keyword = $("#search_keyword");
        let productlist = $("#productlist");
        let product_no = $("#product_no");
        let product_has = $("#product_has");
        let content = $("#content");

        let update_btn = $("#update_btn");
        let search_btn = $("#search_btn");
        let cancel_btn = $("#cancel_btn");
        let product_remove = $("#product_remove_btn")

        let bno_val = $("#bno").val();
        let m_no_val = $("#m_no").val();
        let m_NickName_val = $("#m_NickName").val();
        let img_path = "/images/board_content/board_img_" + bno_val + ".png";

        var imgList = [];

        //검색조건에 맞는 상품목록을 불러오는 메서드
        function getProductList(keyword) {

          $.ajax({
            type: 'GET',
            url: '/community/product',
            contentType: 'text',
            data: { keyword: keyword },
            success: function (data) {

              if (data.length == 0) {
                productlist.append($("<h1>해당 상품은 존재하지 않습니다.</h1>"))
              };
              data.forEach(function (e) {
                productlist.append($('<div class="product" class="my-2" style="background-color: white;" imgPath="' + e.PRO_BANNERIMG + '" pro_no="' + e.PRO_NO + '"  pro_name="' + e.PRO_NAME + '" >' +
                  '<div class="d-flex flex-row align-items-center my-3">' +
                  '<img src="' + e.PRO_BANNERIMG + '" >' +
                  '<div class="d-flex flex-column justify-content-center" id="orders_product_Info" style=" overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin-left: 1em;"><span style="font-weight: bold;">' + e.PRO_BIZNAME + '</span>' +
                  '<span style="color: black; text-decoration: none; font-weight: bold;">' + e.PRO_NAME + '</span>' +
                  '</div>' +
                  '</div>' +
                  '</div>'))

              });
            },
            error: function (e) {
              alert("error:" + e);
            }
          });
        }

        //연관 상품 화면 추가 메서드
        function addProduct(pro_no) {

          $.ajax({
            type: 'GET',
            url: '/community/product/' + pro_no,
            async: false,
            dataType: 'json',
            success: function (result) {
              if ($("#product").attr("pno") == undefined) {


                content.append('<div id="product_link" class="mt-2 w-75">' +
                  '<div id="product" pno="' + result.product.PRO_NO + '">' +
                  '<div class="d-flex flex-row align-items-center" >' +
                  '<img src="' + result.product.PRO_BANNERIMG + '" id="pro_img">' +
                  '<div class="d-flex flex-column justify-content-between" id="orders_product_Info" >' +
                  '<span class="d-flex justify-content-between ">' +
                  '<span class="fs-6 pt-2 ps-2 " id="pro_bizname">' + result.product.PRO_BIZNAME + '</span>' +
                  '<span class="fs-6 pt-2 pe-2" >' +
                  '<span id="pro_wish" style="color: rgb(240, 101, 117);">' + result.product.PRO_WISH + '</span>' +
                  '<img src="/images/utilities/wish_icon.png" style="width: 1.5em; height: 1.5em ;">' +
                  '</span>' +
                  '</span>' +
                  '<span class="fs-6 ps-2" id="pro_category">' + result.pcname + '</span>' +
                  '<span class="fs-5" id="pro_name">' + result.product.PRO_NAME + '</span>' +
                  '</div>' +
                  '</div>' +
                  '</div>' +
                  '</div>')
              } else {
                $("#product").attr("pno", result.product.PRO_NO)
                $("#pro_img").attr("src", result.product.PRO_BANNERIMG);
                $("#pro_bizname").text(result.product.PRO_BIZNAME);
                $("#pro_name").text(result.product.PRO_NAME);
                $("#pro_category").text(result.pcname);
                $("#pro_wish").text(result.product.PRO_WISH);
              }
            },
            error: function (request, status, error) {
              alert(error);
            }
          })
        }
        //남아있는 이미지의 링크리스트를 반환하는 메서드
        function getRealImg() {
          var templist = [];
          $(".ck-content img").each(function (idx, item) {
            var arrIdx = imgList.indexOf(item.getAttribute("src"));
            console.log(item);
            if (arrIdx != -1) {
              templist.push(item.getAttribute("src"));
            }
          })
          return templist;
        }


        //취소 버튼 이벤트
        cancel_btn.on('click', function () {

          location.href = "/community/content/" + bno_val;
        })

        //수정 버튼 이벤트
        update_btn.on("click", function () {
          var title = $("#title").val();
          var content = $(".ck-content").html();
          var realList = getRealImg();

          if (title == "") {
            alert("제목을 입력해주세요.");
            return;
          } else if (content == "") {
            alert("내용을 입력해주세요.");
            return;
          }
          if (realList.length == 0) {
            imgList.push("temp");
            realList.push("temp");
          }
          $.ajax({
            type: 'POST',
            url: '/community/content/modify/' + bno_val,
            async: false,
            beforeSend: function (xhr) {
              xhr.setRequestHeader(header, token);
            },
            contentType: "application/json",
            dataType: 'text',
            data: JSON.stringify({
              title: title,
              content: content
            }),
            success: function (result) {
            },
            error: function (request, status, error) {
              alert(error);
            }
          })
          $.ajax({
            type: 'Put',
            url: '/community/tempImg',
            beforeSend: function (xhr) {
              xhr.setRequestHeader(header, token);
            },
            async: false,
            dataType: 'text',
            data: {
              allList: imgList,
              realList: realList,
              bno: bno_val
            },
            success: function (data) {

            },
            error: function (e) {
              alert("error:" + e);
            }
          });


          if (product_update.val() == "true") {

            var pro_no = product_no.val();

            $.ajax({
              type: 'post',
              url: '/community/product',
              beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
              },
              dataType: "json",
              contentType: "application/json",
              data: JSON.stringify({
                'bno': bno_val,
                'proNo': pro_no,
              }),

              success: function (data) {
              }
            });
          }



          location.assign("/community/content/" + bno_val);
        })

        //상품 선택 버튼 
        $(document).on("click", ".product", function () {
          $("#product_modal_close").click();
          product_update.val("true");
          product_no.val(this.getAttribute("pro_no"));
          product_has.text(this.getAttribute("pro_name") + "상품이 선택된 상태입니다.");
          addProduct(this.getAttribute("pro_no"));
        })

        //상품 검색 이벤트
        search_btn.on("click", function () {
          productlist.empty();
          getProductList(search_keyword.val());
        })

        //상품 삭제 버튼
        product_remove.on("click", function () {
          product_update.val("true");
          product_no.val(0);
          product_has.text("선택된 상품이 없습니다.");
          $("#product_link").remove();
        })
        //초기 설정(상품 리스트 로드)
        getProductList(search_keyword.val());

        //초기설정(설정된 연관 상품 로드)
        if (product_no.val() != "") {
          addProduct(product_no.val());
        }

        //에디터 추가부분=================================================================================
        class UploadAdapter {
          constructor(loader) {
            this.loader = loader;
          }

          upload() {
            return this.loader.file.then(file => new Promise(((resolve, reject) => {
              this._initRequest();
              this._initListeners(resolve, reject, file);
              this._sendRequest(file);
            })))
          }

          _initRequest() {
            const xhr = this.xhr = new XMLHttpRequest();
            xhr.open('POST', '/community/content/img', true);
            xhr.setRequestHeader(header, token);
            xhr.responseType = 'json';
          }

          _initListeners(resolve, reject, file) {
            const xhr = this.xhr;
            const loader = this.loader;
            const genericErrorText = '파일을 업로드 할 수 없습니다.'

            xhr.addEventListener('error', () => { reject(genericErrorText) })
            xhr.addEventListener('abort', () => reject())
            xhr.addEventListener('load', () => {
              const response = xhr.response
              if (!response || response.error) {
                return reject(response && response.error ? response.error.message : genericErrorText);
              }
              imgList.push(response.url);
              resolve({
                default: response.url
              })
            })
          }

          _sendRequest(file) {
            const data = new FormData()
            data.append('upload', file)
            this.xhr.send(data)
          }
        }

        function MyCustomUploadAdapterPlugin(editor) {
          editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
            return new UploadAdapter(loader)
          }
        }

        ClassicEditor
          .create(document.querySelector('#update_content'), {
            language: 'ko',
            extraPlugins: [MyCustomUploadAdapterPlugin],
            toolbar: {
            items: [
                'heading',
                'bold',
                'italic',
				        'link',
                'bulletedList',
                'numberedList',
                'imageUpload',
                'blockquote',
                'MediaEmbed',
                'undo',
                'redo'
            ]
        }
          })
          .then(editor => {
            $.ajax({
              type: 'get',
              url: '/community/post/' + bno_val,
              dataType: "json",
              success: function (data) {
                editor.setData(data.bcontent);
                $(".ck-content img").each(function (idx, item) {
                  imgList.push(item.getAttribute("src"));
                })
              }
            });
            $(".ck-editor").addClass("w-100")
          })
          .catch(error => {
            console.error(error);
          });
        //에디터 추가부분=================================================================================



      })

    </script>
  </head>

  <body>
    <c:if test="${content==null}">
      <script>
        window.location = "/community/main";
      </script>
    </c:if>
    <header>
      <div id="title_bar" class=" fixed-top">
        <div class="py-2 px-1" id="top-bar">

          <button type="toggle-button" class="top_btn" id="top_btn"></button>
          <a id="logo_toHome" href=""><img id="logo_img" src="/images/utilities/logoSSJA.png"></a>
          <form action="http://www.naver.com" id=searchForm method="get">

          </form>
          <button id="search_icon"></button>
          <a id="cart_link"><img id="cart_img"></a>
          <a id="user_link" href="/login"><img id="login_img"></a>
        </div>

      </div>
      <nav id="total_bar">
        <div id="home_user_bar"> </div>
        <div id="sub_bar"></div>
      </nav>
      <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal" var="principal" />
      </sec:authorize>
      <input type="hidden" id="m_no" value="${principal.userInfo.m_No}">
      <input type="hidden" id="m_NickName" value="${principal.userInfo.m_NickName}">
    </header>

    <div id="side_bar">
      <div id="side_links" class="w-100"></div>
    </div>

    <main>
      <input id="bno" type="hidden" value="${content.bno}">
      <div id="main_container" class="border-start border-end container">

        <div class="d-flex flex-column align-items-center mt-3 container-fluid">
          <input class="w-100 ps-3 py-2 mb-3 border-top border-bottom fs-3 " id="title"
            style="border-right: 0px; border-left: 0px;" value="${content.btitle}">
          <div class="w-100 mb-3 d-flex flex-column align-items-center" id="content">
            <input type="hidden" id="update_img" value="${content.img_path}">
            <textarea id="update_content" class="w-75" style="min-height: 400px;"></textarea>

          </div>

          <div class="ps-3 py-2 w-100 border-bottom d-flex flex-row justify-content-end">
            <span>
              <button type="button" class="btn btn-secondary" id="cancel_btn">취소</button>
              <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#productModal">상품 태그</button>
              <button class="btn btn-primary" id="update_btn">수정하기</button>
            </span>

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

    <!-- modal 부분 -->

    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="exampleModalLabel"
      aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header flex-column">
            <h1 class="modal-title fs-5" id="exampleModalLabel">관련상품을 선택해주세요</h1>
            <p class="m-0" id="product_has">
              <c:if test="${content.prono==0}">
                선택된 상품이 없습니다
              </c:if>
              <c:if test="${content.prono!=0}">
                상품이 선택된 상태입니다.
              </c:if>
            </p>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" id="product_update" value="false">
            <input type="hidden" id="product_no" value="${content.prono}">
            <div id="productlist" style="min-height: 200px;">
            </div>
            <div class="d-flex justify-content-center my-2">
              <input type="text" id="search_keyword" class="ms-2">
              <button type="button" id="search_btn" class="btn btn-primary btn-sm ms-1">검색</button>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" id="product_modal_close"
                data-bs-dismiss="modal">취소</button>
              <button type="button" class="btn btn-secondary" id="product_remove_btn">삭제</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
 <sec:authorize access="isAuthenticated()">
	 
	 <sec:authorize access="hasRole('ROLE_VENDOR')">
        <input type="hidden" id="isVendorCheck" value="1">
    </sec:authorize>
	 
  <script src="/js/login_user_tab.js"> </script>
  <script src="/js/user_cart_tab.js"> </script>
</sec:authorize>

</html>