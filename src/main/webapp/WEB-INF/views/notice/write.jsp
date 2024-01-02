<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 헤더 임포트 -->
<jsp:include page="../include/header.jsp"></jsp:include>
	<section>
		<div class="container px-5 my-5 px-5">
			<h2>글쓰기</h2>
			<form name="form" id="form" role="form" method="post" action="">
				<input type="hidden" name="postIdx" id="postIdx" 	value="${noticeDTO.postIdx}"/>
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="postNoticeTitle" id="postNoticeTitle" placeholder="제목을 입력해 주세요" 	value="${noticeDTO.postNoticeTitle}">
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="postNoticeContents" id="postNoticeContents" placeholder="내용을 입력해 주세요" >${noticeDTO.postNoticeContents}</textarea>
				</div>
			</form>
			<div >
				<button type="button" class="btn btn-sm btn-success" id="writeBtn">저장</button>
				<button type="button" class="bn btn-sm btn-primary"  onclick="javascript:location.href='/notice/list';">목록</button>
			</div>
		</div>
	</section>
<!-- 푸터 임포트 -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {

		//게시판 저장버튼
           $("#writeBtn").on("click", function(){
               let form = $("#form");
			
               //게시판번호가 있으면 기존수정모드 없으면 신규글쓰기모드.
              	$('#postIdx').val() != "" ?   form.attr("action", "/notice/updateNotice") :   form.attr("action", "/notice/insertNotice")
               form.attr("method", "post");
               //게시판 유효성 체크
               if(formCheck()){
               	form.submit();
               }
       	});
		
	});

	//게시판 입력폼 체크
       let formCheck = function() {
           let form = document.getElementById("form");
           if(form.postNoticeTitle.value=="") {
               alert("제목을 입력해 주세요.");
               form.postNoticeTitle.focus();
               return false;
           }
           if(form.postNoticeContents.value=="") {
               alert("내용을 입력해 주세요.");
               form.postNoticeContents.focus();
               return false;
           }
           return true;
       }
</script>

<style type="text/css">
	a:link { text-decoration: none;}
	a:visited { text-decoration: none;}
	a:active { text-decoration: none;}
	a:hover {text-decoration:underline;}
</style>