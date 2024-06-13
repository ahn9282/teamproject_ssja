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
      width:90%;
    }
    


  </style>
  <script>
    var header = $("meta[name='_csrf_header']").attr('content');
    var token = $("meta[name='_csrf']").attr('content');
    $(document).ready(function(){
      let reply=$("#reply");
      let reply_count = {
        total : document.querySelector(".reply_total").innerHTML,
        count : 1,
        amount : 20
      };
      let bno_val=$("#bno").val();
      let insert_reply_content=$("#insert_reply_content");
      let none_reply=$("#none_reply");
      let insert_btn=$("#insert_btn");
      let more_btn=$("#more_btn");
      let like_btn=$("#like_btn");
      let delete_btn=$("#delete_btn");
      let update_btn=$("#update_btn");


      let m_no_val=$("#m_no").val();
      let m_NickName_val=$("#m_NickName").val();

      //게시물 추천 개수 얻어오는 함수

      let liked_total= function(){
        $.ajax({
          type : 'GET',
          url : '/community/boradLiked',
          async : false,
          dataType : 'text',
          data :{
            bno : bno_val
          },    
          success : function(result) {
            $(".like").each(function(idx,item){
              item.innerHTML=result;
            })
            reply_count.total=result;
          },    
          error : function(request, status, error) {
            alert(error);
          }
        })
      
      }

      //회원이 게시글을 추천한적이 있는지를 체크하는 함수
      let liked_check= function(){
        //false일경우 추천을 한적이 없음
        
        var check="true";
        
        $.ajax({
          type : 'GET',
          url : '/community/boradIsLiked',
          async : false,
          dataType : 'text',
          data :{
            bno : bno_val,
            mno : m_no_val
          },    
          success : function(result) {
            check=result;
          },    
          error : function(request, status, error) {
            alert(error);
          }
        })
        return check;
      
      }

      //게시물의 추천을 추가하는 함수

      let isLiked=function(){
        $.ajax({
          type : 'POST',
          url : '/community/boradLiked',
          async : false,
          beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
          },
          contentType:"application/json",
          dataType : 'text',
          data :JSON.stringify({
            bno : bno_val,
            mno : m_no_val
          }),    
          success : function(result) {
            liked_total();
          },    
          error : function(request, status, error) {
            alert(error);
          }
        })
      }

      //게시글 삭제 메서드
      let deletePost=function(){
        $.ajax({
          type : 'DELETE',
          url : '/community/post',
          async : false,
          beforeSend: function(xhr) {
              xhr.setRequestHeader(header, token);
          },
          contentType:"application/json",
          dataType : 'text',
          data :JSON.stringify({
            bno : bno_val
          }),    
          success : function(result) {
            alert("해당 게시글이 성공적으로 삭제되었습니다.");
            window.location="/community/main"
          },    
          error : function(request, status, error) {
            alert(error);
          }
        })
      }

      // 댓글 ajax 함수(더보기,페이징);
      let more_reply= function(){
        if(reply_count.total==0){
          none_reply.removeAttr("hidden");
          more_btn.attr("hidden","hidden");
          reply_count.count++
        }else{
          $.ajax({
            type : 'GET',
            url : '/community/reply',
            async : false,
            dataType : 'json',
            data :{
              replyNum : reply_count.count,
              amount : reply_count.amount,
              bno : bno_val
            },    
            success : function(result) {
              result.forEach(function(e, idx){
                var reply_wrap1;
                if(e.rindent<3){
                  reply_wrap1=$('<div class="my-2" style="margin-left:'+(16+e.rindent*30)+'px; margin-right: 16px; box-sizing: content-box; border: 1px solid #BBB;" group="'+e.rgroup+'" indent="'+e.rindent+'" step="'+e.rstep+'"></div>')
                }else{
                  reply_wrap1=$('<div class="my-2" style="margin-left: 106px; margin-right: 16px; box-sizing: content-box; border: 1px solid #BBB;" group="'+e.rgroup+'" indent="'+e.rindent+'" step="'+e.rstep+'"></div>')
                }
                var reply_wrap2=$('<div class="px-2 d-flex justify-content-between" style="background-color: #EEE;">');
                $('<span>'+e.rwriter+'</span>').appendTo(reply_wrap2);
                $('<span>'+e.rdate+'</span>').appendTo(reply_wrap2);
                reply_wrap2.appendTo(reply_wrap1);
                $('<div class="p-2 reply">'+e.rcontent+'</div>').appendTo(reply_wrap1);
                reply.append(reply_wrap1);
              });
              
              if(reply_count.total<=reply_count.amount*reply_count.count){
                more_btn.attr("hidden","hidden");
              }
              reply_count.count++;
            },    
            error : function(request, status, error) {
              alert(error);
            }
          })
        
        }
      }
      // 댓글 갯수 획득 ajax 함수;
      let reply_total= function(){
          $.ajax({
            type : 'GET',
            url : '/community/replyTotal',
            async : false,
            dataType : 'text',
            data :{
              bno : bno_val
            },    
            success : function(result) {
              $(".reply_total").each(function(idx,item){
                item.innerHTML=result;
              })
              reply_count.total=result;
            },    
            error : function(request, status, error) {
              alert(error);
            }
          })
        
        }
      
      //댓글 입력 함수
      let insert_reply= function(step,indent,cotent,group){
          if(group==undefined){
            group=0;

          }
          $.ajax({
            type : 'POST',
            url : '/community/reply',
            async : false,
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            contentType:"application/json",
            dataType : 'text',
            data :JSON.stringify({
              rno : 0,
              rbno : bno_val,
              rmno : m_no_val,
              rwriter : m_NickName_val,
              rcontent : cotent,
              rdate : "sysdate",
              rlike : 0,
              rgroup : group,
              rstep : step,
              rindent : indent
            }),    
            success : function(result) {
              reply_total();
              var temp_scroll = document.documentElement.scrollTop
              reply.empty();
              var temp=reply_count.count-1;

              reply_count.count=1;
              more_btn.removeAttr("hidden");
              for(var i=0;i<temp;i++){
                more_reply();
              }
              window.scrollTo({top : temp_scroll , left : 0 , behavior : 'instant',});
            },    
            error : function(request, status, error) {
              alert(error);
            }
          })
        
        

      }
      more_reply();

      //게시글 추천 버튼 클릭 이벤트
      like_btn.on("click",function(){
        if(m_no_val==""){
          alert("추천은 로그인후에 가능합니다.")
          return
        }

        var check=liked_check();

        if(check=="true"){
          alert("해당 게시글에 이미 추천을 한 이력이 있습니다.")
        }else{
          isLiked();
        }
      })

      delete_btn.on("click",function(){
        deletePost();
      });

      //댓글 더보기
      more_btn.on("click",function(){
        more_reply();
      })

      //댓글 입력
      insert_btn.on("click",function(){
        if(insert_reply_content.val()==""){
          alert("댓글내용을 입력해주세요.")
        }else if(m_no_val==""){
          alert("댓글은 로그인후에 입력할수 있습니다.")
          //필요에 따라 로그인으로 리다이렉트
        }else{
          insert_reply(0,0,insert_reply_content.val());
          insert_reply_content.val("");
        }
      })

      //대댓글 입력창 노출
      $(document).on("click",".reply",function(){
        $(".re_reply").remove();
        var reply_wrap1= $('<div class="w-100 px-3 re_reply" id="insert_re_reply" style="position: relative;" group="'+$(this.parentNode).attr("group")+'" indent="'+$(this.parentNode).attr("indent") +'" step="'+$(this.parentNode).attr("step") +'"></div>');
        $('<textarea name="reply" id="insert_re_reply_content" class="w-100 mt-2" style="resize :none ; box-sizing: border-box; padding-right: 50px; overflow:hidden"></textarea>').appendTo(reply_wrap1);
        $('<div id="insert_re_btn" class="text-center" style="color: #BBB; position: absolute; top: 10% ; right: 2%; width: 50px; height: 54px; line-height: 54px;">입력</div>').appendTo(reply_wrap1);
        $(this.parentNode).after(reply_wrap1);
      })
      //대댓글 입력
      $(document).on("click","#insert_re_btn",function(){
        var insert_re_reply= $("#insert_re_reply");
        if($("#insert_re_reply_content").val()==""){
          alert("댓글내용을 입력해주세요.")
        }else if(m_no_val==""){
          alert("댓글은 로그인후에 입력할수 있습니다.")
          //필요에 따라 로그인으로 리다이렉트
        }else{
          insert_reply(insert_re_reply.attr("step"),insert_re_reply.attr("indent"),$("#insert_re_reply_content").val(),insert_re_reply.attr("group"));
        }
      })


    })

  </script>
</head>

<body>
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
    <sec:authorize access="isAuthenticated()">
    	<sec:authentication property="principal" var="principal"/>
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
        <h3 class="w-100 ps-3 py-2 mb-0 border-top border-bottom" style="background-color: #EEE;"> ${content.btitle} </h3>
        <div class="w-100 mb-3 border-bottom d-flex justify-content-between">
          <div class="ms-4">
            ${content.bwriter}
          </div> 
          <div>
            댓글수 : <span class="reply_total">${reply_total}</span> &nbsp;
            추천수 : <span class="like">${content.blike} </span> &nbsp;
            조회수 : <span>${content.bhit}</span> &nbsp;
            작성일 : <span>${content.bdate}</span>
          </div>
        </div>
        <img src="${content.img_path}" alt="" class="w-75 d-inline-block mb-5 ">
        <div class="w-75 mb-3">
          ${content.bcontent}
        </div>
        <span class="border d-flex flex-column align-items-center mb-3" id="like_btn" style="border-radius: 10px ;">
          <img src="/images/utilities/like.png" alt="" style="width: 60px;height: 60px;">
          <span class="like">${content.blike}</span>
        </span>
        <div class="ps-3 py-2 w-100 border-top border-bottom d-flex flex-row justify-content-between">
          <span class="fs-5" style="line-height: 38px;">댓글:[<span class="reply_total">${reply_total}</span>]</span>
          <c:if test="${principal.userInfo.m_No == content.bmno}">
          	<span>
              <button class="btn btn-outline-primary" id="update_btn" >수정하기</button>
              <button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">삭제하기</button>
            </span>
          </c:if>
        </div>
        
        <div class="w-100 px-3" style="position: relative;">
          <textarea name="reply" id="insert_reply_content" class="w-100 mt-2" style="resize :none ; box-sizing: border-box; padding-right: 50px; overflow:hidden"></textarea>
          <div id="insert_btn" class="text-center" style="color: #BBB; position: absolute; top: 10% ; right: 2%; width: 50px; height: 54px; line-height: 54px;">
            입력
          </div>
        </div>
        
        <div id="reply" class="w-100">
          <div id="none_reply" class="my-2" style="margin-left: 16px; margin-right: 16px; box-sizing: content-box; border: 1px solid #BBB;" hidden >
            <div class="ps-2" style="background-color: #EEE;">
              admin
            </div>
            <div class="p-2">
              댓글이 존재하지 않습니다.
            </div>
          </div>
          
        </div>
        <div class="w-100 px-3 mb-3">
          <button id="more_btn" class="w-100" style="border-color: transparent; height: 50px; "> 더보기</button>
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

  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          정말 삭제하시겠습니까?
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요.</button>
          <button type="button" class="btn btn-primary" id="delete_btn">삭제하겠습니다.</button>
        </div>
      </div>
    </div>
  </div>

</body>
</html>