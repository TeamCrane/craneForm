<%--
  Created by IntelliJ IDEA.
  User: JYeolI
  Date: 2023-03-17
  Time: 오후 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/header.jsp"%>
<script src="/js/jquery_v3.6.4.js"></script>

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
                                <input type="date" placeholder="" class="form-control" id="birth" disabled value="<%=session.getAttribute("birth")%>" required>
                            </div>
                        </div>
                        <!-- End of Form -->
                        <!-- Form -->
                        <div class="form-group mb-4">
                            <label for="email">성별</label>
                            <div class="input-group">
                                <span class="input-group-text" id="basic-addon7"><span class="fas fa-transgender"></span></span>
                                <select name="gender" id="gender" class="form-control" disabled>
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
                                <input type="text" class="form-control" id="sample2_postcode" placeholder="우편번호" disabled value="<%=session.getAttribute("addr").equals("")?"":session.getAttribute("addr").toString().split("\\(|\\)")[1]%>">
                                <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기" style="border: 0.0625rem solid #D1D5DB;border-top-right-radius: 1rem;border-bottom-right-radius: 1rem;border-left: 0;"><br>
                            </div>
                            <div class="input-group" style="margin-top: 12px;">
                                <span class="input-group-text" id="basic-addon10"><span class="fas fa-address-book"></span></span>
                                <input type="text" class="form-control" id="sample2_address" placeholder="주소" disabled value="<%=session.getAttribute("addr").equals("")?"":session.getAttribute("addr").toString().split("\\(|\\)|, ")[2].substring(1)%>" style="border-top-right-radius: 1rem;border-bottom-right-radius: 1rem;"><br>
                            </div>
                            <div class="input-group" style="margin-top: 12px;">
                                <span class="input-group-text" id="basic-addon11"><span class="fas fa-address-book"></span></span>
                                <input type="text" class="form-control" id="sample2_detailAddress" placeholder="상세주소 1" value="<%=session.getAttribute("addr").equals("")?"":session.getAttribute("addr").toString().split("\\(|\\)|, ")[3]%>"><br>
                                <input type="text" class="form-control" id="sample2_extraAddress" placeholder="상세주소 2" disabled value="<%=session.getAttribute("addr").equals("")?"":"("+session.getAttribute("addr").toString().split("\\(|\\)|, ")[4]+")"%>">
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
    $(function () {
        $("#cancel").click(function () {
            if(confirm("취소하시겠습니까?\n주의 : 변경하신 정보는 저장되지 않습니다.")) { location.href="/user/profile?no=<%=session.getAttribute("no")%>"; }
        })

        $("#modify").click(function () {
        if(!confirm("변경하신 내용을 저장하시겠습니까?")) { return; }

            let user = {
                ui_no:<%=session.getAttribute("no")%>,
                ui_name:$("#name").val(),
                ui_email:$("#email").val(),
                ui_addr:$("#sample2_postcode").val()==""?"":"(" + $("#sample2_postcode").val() + ") " + $("#sample2_address").val() + ", " + $("#sample2_detailAddress").val() + " " + $("#sample2_extraAddress").val(),
                ui_phone:$("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val(),
                ui_gender:$("#gender option:selected").val(),
                ui_birth:$("#birth").val(),
                ui_password:$("#password_confirm").val()
            }

            $.ajax({
                url:"/api/user/modify",
                type:"patch",
                data:JSON.stringify(user),
                contentType:"application/json",
                success:function(r) {
                    alert(r.message);
                    if(r.status) location.href = "/user/profile?no=<%=session.getAttribute("no")%>";
                }
            })
        })
    })
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>

<%@ include file="/WEB-INF/views/footer.jsp"%>