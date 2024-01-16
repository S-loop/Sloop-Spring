<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <link href="/resources/css/style_main.css" rel="stylesheet">
</head>

    <!-- main 페이지의 컨텐츠 부분 시작 -->
    <div class="container-main">
        <div class="card banner-img">
            <img src="${contextPath}/resources/images/banner01.png" class="card-img" alt="...">
            <div class="card-img-overlay">
            </div>
        </div>

        <div class="main-tab">
            <p>
                <a href="#">초등</a> |
                <a href="#">중등</a> |
                <a href="#">고등</a>
            </p>
        </div>

        <div class="row">
            <c:forEach items="${studyGroupList}" var="studyGroup">
                <div class="col-sm-3">
                    <div class="card-study">
                        <a href="/study/introduce?group=${studyGroup.studyGroupCode}">
                            <img src="${contextPath}/resources/images/thumbnail_01.png" class="card-img-top" alt="...">
                            <div class="card-body">
                                <p class="card-badge">
                                    <span class="badge rounded-pill bg-lightblue text-dark">${studyGroup.studyGroupGrade}</span>
                                    <span class="badge rounded-pill bg-lightorange text-dark">${studyGroup.studyGroupSubject}</span>
                                    <span class="badge rounded-pill bg-lightgreen text-dark">${studyGroup.studyGroupRegion}</span>
                                </p>
                                <h5 class="card-title">
                                        ${studyGroup.studyGroupName}
                                </h5>
                                <p class="card-text">
                                    모집 마감
                                    <span class="badge rounded-pill bg-light text-dark">
                                        <fmt:formatDate value="${studyGroup.studyGroupDuedate}" pattern="yyyy-MM-dd"></fmt:formatDate>
                                    </span>
                                </p>
<%--                                <a href="#" class="btn btn-primary">Go somewhere</a>--%>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <!-- main 페이지의 컨텐츠 부분 끝 -->
