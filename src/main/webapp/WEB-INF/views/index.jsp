<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2023-03-11
  Time: 오후 8:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Crane Form</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 파비콘 -->
    <link rel="apple-touch-icon" sizes="120x120" href="/img/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/img/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon/favicon-16x16.png">

    <!-- Fontawesome -->
    <link type="text/css" href="/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">

    <!-- CSS -->
    <link type="text/css" href="/css/pixel.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/index.css">

    <%-- 폰트 --%>
    <link href="//db.onlinewebfonts.com/c/67680f2eb947c5cbd58b40961b4a61e9?family=Apple+SD+Gothic+Neo" rel="stylesheet"
          type="text/css"/>
</head>

<body>
<header class="header-global" style="box-shadow: 1px 1px #959595">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid d-flex align-items-center">
            <a class="navbar-brand me-auto" href="/">Crane Form</a>
            <div class="input-group" style="width: 50%; margin: auto;">
                <input type="text" class="form-control" placeholder="Search" aria-label="Search"
                       aria-describedby="basic-addon2">
                <button class="btn btn-outline-secondary input-group-text" type="button" id="basic-addon2"><span
                        class="fas fa-search"></span></button>
            </div>
            <ul class="navbar-nav ms-auto nav-mypage">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        My Page
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item"
                               href="/user/profile?no=<%=session.getAttribute("no") %>">Profile</a></li>
                        <li><a class="dropdown-item"
                               href="/analysis/select?no=<%=session.getAttribute("no")%>">Analysis</a></li>
                        <li class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#" id="logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>

<main class="container mt-5">
    <div class="row mb-3 d-flex">
        <div class="btn-group text-center justify-content-center" role="group" aria-label="Sort cards">
            <a href="#" class="btn-sort">최신순</a>
            <span class="separator">|</span>
            <a href="#" class="btn-sort">답변순</a>
            <span class="separator">|</span>
            <a href="#" class="btn-sort">제목순</a>
        </div>
    </div>
    <hr>

    <div class="row">
        <div class="col-md-3 mb-4">
            <div class="card text-center">
                <div class="card-body d-flex flex-column justify-content-center align-items-center">
                    <h5 class="card-title mb-1">설문지 추가</h5>
                    <button class="btn btn-primary btn-outline-secondary rounded-pill mt-3" onclick="addSurvey()">
                        <i class="fas fa-plus mr-2"></i> Add Form
                    </button>
                </div>
            </div>
        </div>

        <c:forEach var="si_list" items="${surveyInfoList}" varStatus="vs">
            <fmt:formatDate var="si_created_date" value="${si_list.si_created_date}" pattern="yyyy-MM-dd"/> <%-- 날짜 형식 지정 --%>
            <fmt:parseNumber var="si_no" value="${si_list.si_no}"/>
            <div class="col-md-3 mb-4 survey_main">
                <input type="hidden" id="surveyNo" value="${si_list.si_no}">
                <div class="card text-center">
                    <div class="card-body" style="cursor: pointer" onclick="moveSurveyDetail(${si_no})">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="card-title mb-1">${si_list.si_subtitle}</h5>
                                <p class="card-text mb-0">${si_created_date}</p>
                            </div>
                            <div class="btn-group">
                                <c:if test="${ui_no eq si_list.si_ui_no}">
                                <button type="button" class="btn dropdown-toggle dropdown-toggle-split"
                                        data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" onclick="event.stopPropagation()">
                                    <span class="fas fa-ellipsis-v"></span>
                                </button>
                                <div class="dropdown-menu py-0 dropdown-menu-md-start"
                                     style="white-space: normal; word-break: break-word">
                                    <a class="dropdown-item rounded-top"><i class="fas fa-edit me-2"></i>이름 바꾸기</a>
                                    <a class="dropdown-item" onclick="deleteSurvey(${si_list.si_no})"><i class="fas fa-trash-alt me-2"></i>삭제</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-external-link-alt me-2"></i>새창으로
                                        열기</a>
                                </div>
                                </c:if>
                            </div>
                        </div>
                        <hr>
                        <%--<div class="card-img-container">
                            <img src="/img/goodgun.png" class="card-img-top img-fluid mb-3"
                                 style="max-width:100%; max-height: 70px">
                        </div>--%>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</main>

<footer>
    <div id="scroll-to-top"></div>
</footer>
</body>

<script>

    // 설문 추가
    function addSurvey() {
        location.href = "/survey/form";
    }

    // 로그아웃
    document.getElementById("logout").addEventListener("click", function () {
        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = "/logout";
        }
    })

    // 설문 상세
    function moveSurveyDetail(si_no) {
        location.href="/survey/detail/"+si_no;
    }

    // 설문 삭제
    function deleteSurvey(si_no) {

    }

</script>

<!-- Core -->
<script src="/vendor/@popperjs/core/dist/umd/popper.min.js"></script>
<script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/vendor/headroom.js/dist/headroom.min.js"></script>

<!-- Vendor JS -->
<script src="/vendor/onscreen/dist/on-screen.umd.min.js"></script>
<script src="/vendor/jarallax/dist/jarallax.min.js"></script>
<script src="/vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
<script src="/vendor/vivus/dist/vivus.min.js"></script>
<script src="/vendor/vanillajs-datepicker/dist/js/datepicker.min.js"></script>

<script async defer src="https://buttons.github.io/buttons.js"></script>

<!-- Pixel JS -->
<script src="./assets/js/pixel.js"></script>

</html>
