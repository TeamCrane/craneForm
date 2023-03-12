<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>

  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- 파비콘 -->
  <link rel="apple-touch-icon" sizes="120x120" href="/img/favicon/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/img/favicon/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon/favicon-16x16.png">

  <!-- Fontawesome -->
  <link type="text/css" href="/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">

  <!-- CSS -->
  <link type="text/css" href="/css/pixel.css" rel="stylesheet">

  <%-- 폰트 --%>
  <link href="//db.onlinewebfonts.com/c/67680f2eb947c5cbd58b40961b4a61e9?family=Apple+SD+Gothic+Neo" rel="stylesheet"
        type="text/css"/>

  <style>
    header {
      font-family: AppleSDGothicNeoB00, sans-serif;
    }

    .dropdown-menu {
      position: absolute;
      top: 100%;
      left: 0;
      z-index: 9999;
      float: none;
      min-width: 100%;
      padding: 0;
    }

    .nav-mypage {
      border: 1px solid #ccc;
      border-radius: 10px;
      padding: 3px;
    }
  </style>
</head>

<body>
<header class="header-global" style="box-shadow: 1px 1px #959595">
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid d-flex align-items-center">
      <a class="navbar-brand me-auto" href="#">Crane Form</a>
      <div class="input-group" style="width: 50%; margin: auto;">
        <input type="text" class="form-control" placeholder="Search" aria-label="Search" aria-describedby="basic-addon2">
        <button class="btn btn-outline-secondary input-group-text" type="button" id="basic-addon2"><span class="fas fa-search"></span></button>
      </div>
      <ul class="navbar-nav ms-auto nav-mypage">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            My Page
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">Profile</a></li>
            <li><a class="dropdown-item" href="#">Settings</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Logout</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </nav>
</header>
