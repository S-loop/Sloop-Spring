<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<h1>
		Hello world!
	</h1>


	<P>
		<h3>로그인 정보</h3>
		loginEmail = ${sessionScope.loginEmail}<br>
		loginMemberIdx = ${sessionScope.loginMemberIdx}<br>
		loginMemberNickname = ${sessionScope.loginMemberNickname}<br>
	</P>

	<!-- 김지원 - 주석 아래로 작성 -->
	<a href="/study">스터디그룹 리스트 /study</a><br>
	<a href="/study/add">스터디그룹 생성 /study/add</a><br>

	<!-- 박석은 - 주석 아래로 작성 -->

	<!-- 이지연 - 주석 아래로 작성 -->
	<a href="/postforum/list">자유 게시판</a><br>

	<!-- 이창규 - 주석 아래로 작성 -->
  	<a href="/member/login">로그인</a><br>
	<a href="/member/signup">회원가입</a>
	<a href="/member/memberList">회원리스트</a>
	<a href="/member/mypage">마이페이지</a>
	<!-- 차소영 - 주석 아래로 작성 -->

	<!-- 최지혜 - 주석 아래로 작성 -->


</body>
</html>
