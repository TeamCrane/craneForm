<%--
  Created by IntelliJ IDEA.
  User: JYeolI
  Date: 2023-03-17
  Time: 오후 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/header.jsp"%>

<section class="min-vh-100 d-flex align-items-center section-image overlay-soft-dark mt-5" data-background="../../assets/img/pages/form-image.jpg">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 d-flex align-items-center justify-content-center">
                <div class="signin-inner my-4 my-lg-0 bg-white shadow-soft border rounded border-gray-300 p-4 p-lg-5 w-100 fmxw-500">
                    <div class="text-center text-md-center mb-4 mt-md-0">
                        <h1 class="mb-0 h3">프로필 수정</h1>
                    </div>
                    <div style="text-underline: #ccc"></div>
                    <form action="#">
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">이름</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon2"><span class="fas fa-user"></span></span>
                                <input type="name" class="form-control" placeholder="이름" id="name" value="<%=session.getAttribute("name")%>" disabled required>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">이메일</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon3"><span class="fas fa-envelope"></span></span>
                                <input type="email" class="form-control" placeholder="example@company.com" id="email" value="<%=session.getAttribute("email")%>" disabled required>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">생년월일</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon6"><span class="fas fa-birthday-cake"></span></span>
                                <input type="date" placeholder="" class="form-control" id="birth" value="<%=session.getAttribute("birth")%>" required>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">성별</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon7"><span class="fas fa-transgender"></span></span>
                                <select name="gender" id="gender" class="form-control">
                                    <option value="" <%=session.getAttribute("gender")=="선택안함"?"selected":""%>>선택안함</option>
                                    <option value="m" <%=session.getAttribute("gender")=="남"?"selected":""%>>남</option>
                                    <option value="f" <%=session.getAttribute("gender")=="여"?"selected":""%>>여</option>
                                </select>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">전화번호</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon8"><span class="fas fa-headphones"></span></span>
                                <input type="phone" class="form-control" id="phone1" placeholder="000" maxlength="3" value="<%=session.getAttribute("phone").toString().split("-")[0]%>" required>
                                <input type="phone" class="form-control" id="phone2" placeholder="0000" maxlength="4" value="<%=session.getAttribute("phone").toString().split("-")[1]%>" required>
                                <input type="phone" class="form-control" id="phone3" placeholder="0000" maxlength="4" value="<%=session.getAttribute("phone").toString().split("-")[2]%>" required>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">주소</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon9"><span class="fas fa-address-book"></span></span>
                                <input type="text" class="form-control" id="sample2_postcode" placeholder="우편번호" value="<%=session.getAttribute("addr").equals("")?"":session.getAttribute("addr").toString().split("\\(|\\)")[1]%>">
                                <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기" style="border: 0.0625rem solid #D1D5DB;border-top-right-radius: 1rem;border-bottom-right-radius: 1rem;border-left: 0;"><br>
                            </div>
                            <div class="input-group" style="margin-top: 12px;">
                                <span class="input-group-text" id="basic-addon10"><span class="fas fa-address-book"></span></span>
                                <input type="text" class="form-control" id="sample2_address" placeholder="주소" value="<%=session.getAttribute("addr").equals("")?"":session.getAttribute("addr").toString().split("\\(|\\)|, ")[2].substring(1)%>" style="border-top-right-radius: 1rem;border-bottom-right-radius: 1rem;"><br>
                            </div>
                            <div class="input-group" style="margin-top: 12px;">
                                <span class="input-group-text" id="basic-addon11"><span class="fas fa-address-book"></span></span>
                                <input type="text" class="form-control" id="sample2_detailAddress" placeholder="상세주소" value="<%=session.getAttribute("addr").equals("")?"":session.getAttribute("addr").toString().split("\\(|\\)|, ")[3]%>"><br>
                                <input type="text" class="form-control" id="sample2_extraAddress" placeholder="참고항목" value="<%=session.getAttribute("addr").equals("")?"":"("+session.getAttribute("addr").toString().split("\\(|\\)|, ")[4]+")"%>">
                            </div>
                        </div>
                        <div class="input-group">
                            <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;border-radius: 1rem">
                                <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
                            </div>
                        </div>
                        <!-- End of Form -->
                        <div class="d-flex mt-5">
                            <button type="button" class="btn btn-primary w-50" id="modify" style="margin-right: 2rem;">수정</button>
                            <button type="button" class="btn btn-danger w-50" id="cancel">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    document.getElementById("cancel").addEventListener("click", function () {
        if(confirm("취소하시겠습니까?\n주의 : 변경하신 정보는 저장되지 않습니다.")) { location.href="/user/profile?no=<%=session.getAttribute("no")%>"; }
    })
</script>

<%@ include file="/WEB-INF/views/footer.jsp"%>