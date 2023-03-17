<%--
  Created by IntelliJ IDEA.
  User: JYeolI
  Date: 2023-03-17
  Time: 오후 4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/header.jsp"%>

<section class="min-vh-100 d-flex align-items-center section-image overlay-soft-dark" data-background="../../assets/img/pages/form-image.jpg">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 d-flex align-items-center justify-content-center">
                <div class="signin-inner my-4 my-lg-0 bg-white shadow-soft border rounded border-gray-300 p-4 p-lg-5 w-100 fmxw-500">
                    <div class="text-center text-md-center mb-4 mt-md-0">
                        <h1 class="mb-0 h3">내 프로필</h1>
                    </div>
                    <div style="text-underline: #ccc"></div>
                    <form action="#">
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label>이름 : <%=session.getAttribute("name")%></label>
                        </div>
                        <!-- End of Form -->                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label>이메일 : <%=session.getAttribute("email")%></label>
                        </div>
                        <!-- End of Form -->
                        <div class="form-group">
                            <!-- Form -->
                            <div class="form-group mb-4">
                                <label>생년월일 : <%=session.getAttribute("birthStr")%></label>
                            </div>
                            <!-- End of Form -->
                            <!-- Form -->
                            <div class="form-group mb-4">
                                <label>성별 : <%=session.getAttribute("gender")%></label>
                            </div>
                            <!-- End of Form -->
                            <!-- Form -->
                            <div class="form-group mb-4">
                                <label>전화번호 : <%=session.getAttribute("phone")%></label>
                            </div>
                            <!-- End of Form -->
                            <!-- Form -->
                            <div class="form-group mb-4">
                                <label>주소 : <%=session.getAttribute("addr")%></label>
                            </div>
                            <!-- End of Form -->
                            <!-- Form -->
                            <div class="form-group mb-4">
                                <label>가입일 : <%=session.getAttribute("created_date")%></label>
                            </div>
                            <!-- End of Form -->
                        </div>
                        <div class="d-grid">
                            <a href="/user/modify?no=<%=session.getAttribute("no")%>" class="btn btn-primary">프로필 수정</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/footer.jsp"%>