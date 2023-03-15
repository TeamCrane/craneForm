<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2023-03-11
  Time: 오후 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Crane Form</title>
    <!-- Fontawesome -->
    <link type="text/css" href="../../vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
    <!-- Pixel CSS -->
    <link type="text/css" href="../../css/pixel.css" rel="stylesheet">

    <script src="/js/jquery_v3.6.4.js"></script>

</head>
<body>
<section class="min-vh-100 d-flex align-items-center section-image overlay-soft-dark" data-background="../../assets/img/pages/form-image.jpg">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 d-flex align-items-center justify-content-center">
                <div class="signin-inner my-4 my-lg-0 bg-white shadow-soft border rounded border-gray-300 p-4 p-lg-5 w-100 fmxw-500">
                    <div class="text-center text-md-center mb-4 mt-md-0">
                        <h1 class="mb-0 h3">로그인</h1>
                    </div>
                    <form action="#" class="mt-4">
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">이메일</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon1"><span class="fas fa-envelope"></span></span>
                                <input type="email" class="form-control" placeholder="example@company.com" id="email" required>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <div class="form-group">
                            <!-- Form -->
                            <div class="form-group mb-4">
                                <label for="password">비밀번호</label>
                                <div class="input-group">
                                    <span class="input-group-text" id="basic-addon2"><span class="fas fa-unlock-alt"></span></span>
                                    <input type="password" placeholder="Password" class="form-control" id="password" required>
                                </div>
                            </div>
                            <!-- End of Form -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check mb-0">
                                    <input class="form-check-input" type="checkbox" value="" id="remember">
                                    <label class="form-check-label mb-0" for="remember">
                                        로그인 정보 기억하기
                                    </label>
                                </div>
                                <div><a href="#" class="small text-right">비밀번호 찾기</a></div>
                            </div>
                        </div>
                        <div class="d-grid">
                            <button type="button" class="btn btn-primary" id="login">로그인</button>
                        </div>
                    </form>
                    <div class="d-flex justify-content-center align-items-center mt-4">
                                    <span class="fw-normal">
                                        아직 회원이 아니신가요?
                                        <a href="/signup" class="fw-bold text-underline">회원가입</a>
                                    </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    $(function () {
        $("#login").click(function () {
            loginAccess();
        })
    })

    function loginAccess() {
        let email = $("#email").val();
        let pwd = $("#password").val();
        $.ajax({
            url:"/api/login?email="+email+"&pwd="+pwd,
            type:"get",
            success:function(r) {
                console.log(r.message);
                alert(r.message);
                if(r.status) {
                    location.href = "/";
                }
            }
        })
    }
</script>
</body>
</html>
