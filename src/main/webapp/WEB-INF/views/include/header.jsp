<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <link href="/resources/assets/favicon.ico"  rel="icon" type="image/x-icon" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/resources/css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="/resources/css/style2.css" media="screen" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="/resources/js/jquery.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
    <style>
        *{
            font-family: 'Gowun Dodum', sans-serif;
        }
    </style>
    <!-- Favicon-->
    <title>스프링 사이트</title>
</head>
<!--headerFragment 선언-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
        <a class="navbar-brand" href="/">스프링 사이트</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <!-- 타임리프 로그인 세션 체크 하기, 세션이 없으면-->

                <c:choose>
                    <c:when test="${empty sessionScope.loginMemberInfo}"> <!-- if와 동일 -->
                        <li class="nav-item"><a class="nav-link" href="/login/login">로그인</a></li>
                        <li class="nav-item"><a class="nav-link" href="/member/join">회원가입</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" >${sessionScope.loginMemberInfo.name}님 환영합니다.</a></li>
                        <li class="nav-item"><a class="nav-link"  id="logout">로그아웃</a></li>
                        <li class="nav-item"><a class="nav-link" href="/member/mypage">마이페이지</a></li>
                    </c:otherwise>
                </c:choose>

                <li class="nav-item"><a class="nav-link" href="/bbs/list">공지사항</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">임시메뉴</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                        <li><a class="dropdown-item" href="#">임시1</a></li>
                        <li><a class="dropdown-item" href="#">임시2</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<script>
    $("#logout").click(function(){
        Swal.fire({
            title: '로그아웃을 하시겠습니까?',
            //text: '다시 되돌릴 수 없습니다. 신중하세요.',
            icon: 'warning',
            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
            cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정
        }).then(function(result){
            if(result.isConfirmed == true){
                location.href="/login/logout";
            }
        });
    });
</script>