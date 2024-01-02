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
			<h2>상세보기</h2>
			<form name="form" id="form" role="form" >
				<input type="hidden" name="postIdx" id="postIdx" value="${noticeDTO.postIdx}">
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="postNoticeTitle" id="postNoticeTitle" 	readonly 	value="${noticeDTO.postNoticeTitle}">
				</div>

				<div class="mb-3">
					<label for="reg_id">작성자</label>
					<!-- 로그인기능 오류로 임시 강제값 지정 -->
					<input type="text" class="form-control" name="memberIdx" id="memberIdx"	readonly	value="${noticeDTO.memberIdx}"	> 
				</div>

				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="postNoticeContents" id=postNoticeContents 	readonly >${noticeDTO.postNoticeContents}</textarea>
				</div>
			</form>
			<div >
				<button type="button" class="btn btn-sm btn-success" id="modBtn">수정</button>
				<button type="button" class="btn btn-sm btn-danger" id="delBtn">삭제</button>
				<button type="button" class="btn btn-sm btn-primary"  onclick="javascript:location.href='/notice/list';">목록</button>
			</div>
		</div>
	</section>
<!-- 푸터 임포트 -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {

		//게시판 수정버튼
           $("#modBtn").on("click", function(){
           	location.href = "/notice/write?postIdx="+$('#postIdx').val();
           });

		//게시판 삭제버튼
           $("#delBtn").on("click", function(){
               let form = $("#form");
               form.attr("action", "/notice/deleteNotice");
               form.attr("method", "post");
            	form.submit();
           });
		
	});
</script>

<style type="text/css">
	a:link { text-decoration: none;}
	a:visited { text-decoration: none;}
	a:active { text-decoration: none;}
	a:hover {text-decoration:underline;}
</style>