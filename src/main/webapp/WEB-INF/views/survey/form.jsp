<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2023-03-13
  Time: 오후 4:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<style>

    .btn-sort {
        color: #6c757d;
        font-size: 0.9rem;
        font-weight: bold;
        text-decoration: none;
        padding: 0 10px;
    }

    .titlebox {
        border-top: 7px solid #fdb7d6;
        margin-top: 20px;
    }

    .title {
        font-size: 32px;
        margin-bottom: 10px; /* add some margin to bottom */

        border-right: none;
        border-left: none;
        border-top: none;
        border-bottom: 0.0625rem solid #D1D5DB;
        padding-bottom: 5px;
    }

    .title:focus {
        outline: none;
    }

    .description {
        font-size: 16px;
        margin-bottom: 1rem !important;
    }

    .nav-form {
        border: 1px solid #D1D5DB;
        border-radius: 10px;
        position: sticky;
        top: 50px;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-right: 60%;
        padding: 10%;
    }

    .nav-form-link {
        margin-bottom: 5px;
        margin-top: 5px;
        font-size: 20px;
        position: relative;
    }

    .nav-form-link:hover:after {
        content: attr(title);
        position: absolute;
        top: 50%;
        left: 100%;
        padding: 5px;
        background-color: #454545;
        color: whitesmoke;
        font-size: 14px;
        border-radius: 5px;
        white-space: nowrap;
        transform: translate(5px, -50%);
    }

    .nav-form-link:hover:before {
        content: '';
        position: absolute;
        top: 50%;
        left: 100%;
        width: 10px;
        height: 10px;
        background-color: #454545;
        transform: translate(5px, -50%) rotate(45deg);
    }

    .select-wrapper {
        position: relative;
        width: 100%;
        padding: 10px;
    }

    .select-trigger {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 12px;
        color: #4B5563;
        background-color: #F9FAFB;
        border: 0.0625rem solid #D1D5DB;
        cursor: pointer;
        margin-bottom: 5px;
        margin-top: 5px;
    }

    .select-trigger:before {
        content: "\25b6";
        font-size: 0.8em;
        margin-right: 5px;
    }

    .select-options {
        position: absolute;
        top: -200%;
        left: 100%;
        width: 100%;
        z-index: 999;
        color: #4B5563;
        background-color: #F9FAFB;
        border: 0.0625rem solid #D1D5DB;
        border-top: none;
        list-style: none;
        padding: 0;
        margin: 0;
        flex-direction: column;
        border-radius: 5px;
        box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2);
        display: none;
    }

    .select-options li {
        padding: 12px;
        cursor: pointer;
        font-size: 12px;
    }

    .select-options li:hover {
        background-color: #f5f5f5;
    }

    .select-options li[selected] {
        font-weight: bold;
        background-color: #fffec9;
    }

    .select-wrapper.open .select-options {
        display: flex;
    }

    optgroup[label] {
        font-weight: bold;
        margin-top: 10px;
        margin-bottom: 5px;
    }

    .container {
        overflow: visible;
    }

</style>

<main class="container mt-5">
    <div class="row mb-3 d-flex">
        <div class="btn-group text-center justify-content-center" role="group" aria-label="Sort cards">
            <a href="#" class="btn-sort">질문</a>
            <span class="separator">|</span>
            <a href="#" class="btn-sort">설정</a>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-2"></div>
        <div id="survey_main" class="col-8">
            <div class="mb-5">
                <div class="card shadow">
                    <div class="card-body px-5 text-center text-md-left titlebox">
                        <div class="row align-items-center">
                            <input type="text" class="title" placeholder="제목 없는 설문지" value="">
                            <input type="text" class="form-control description" placeholder="설문지 설명" value="">
                        </div>
                    </div>
                </div>
            </div>

            <div class="mb-5">
                <div class="card shadow">
                    <div class="card-body px-5 py-5 text-center text-md-left">
                        <div id="question_main" class="row align-items-center">
                            <div class="col-md-8">
                                <input type="text" class="form-control" placeholder="질문">
                            </div>
                            <div class="col-md-4">
                                <div class="select-wrapper">
                                    <div class="select-trigger">객관식 질문</div>
                                    <ul class="select-options">
                                        <li>주관식 - 단답형</li>
                                        <li>주관식 - 장문형</li>
                                        <hr>
                                        <li selected>객관식 질문</li>
                                        <li>체크박스</li>
                                        <li>드롭다운</li>
                                        <hr>
                                        <li>객관식 표</li>
                                        <li>체크박스 표</li>
                                        <hr>
                                        <li>날짜</li>
                                        <li>시간</li>
                                    </ul>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-2">
            <div class="nav-form">
                <a class="nav-form-link" title="질문 추가" onclick="addQuestion()"><i class="fas fa-plus"></i></a>
                <a class="nav-form-link" title="질문 가져오기"><i class="fas fa-download"></i></a>
                <a class="nav-form-link" title="섹션 추가"><i class="fas fa-plus-square"></i></a>
            </div>
        </div>
    </div>
</main>

<script>
    const selectTrigger = document.querySelector('.select-trigger');
    const selectOptions = document.querySelector(".select-options");

    // 클릭하면 질문 유형 목록이 보인다
    selectTrigger.addEventListener('click', function () {
        selectOptions.style.display = "flex";
    });

    // 질문 유형 목록이 열렸을 때 다른 곳을 클릭하면 display:none 처리된다
    document.addEventListener('click', function (event) {
        if (selectOptions.style.display === 'flex' && !event.target.closest('.select-wrapper')) {
            selectOptions.style.display = 'none';
        }
    });

    // 옵션을 클릭하면 해당 옵션으로 텍스트 내용이 바뀌고 목록이 사라진다
    selectOptions.querySelectorAll('li').forEach(function (option) {
        if (!option.querySelector('hr')) {
            option.addEventListener('click', function (event) {
                // const targeted_option = event.target;
                const selectedOption = document.querySelector('.select-options li[selected]');

                // 클릭된 요소로 selected 옮기기
                selectedOption.removeAttribute('selected');
                option.setAttribute('selected', 'selected');

                // 클릭된 요소를 기본으로 세팅하고 선택창 display:none
                selectTrigger.textContent = option.textContent;
                selectOptions.style.display = 'none';
            });
        }
    });

    function addQuestion() {
        let message = "";
        message += '<div class="col-md-8">';
        message += '    <input type="text" class="form-control" placeholder="질문">'
        message += '</div>'
        message += '<div class="col-md-4">'
        message += '    <div class="select-wrapper">'
        message += '        <div class="select-trigger">객관식 질문</div>'
        message += '        <ul class="select-options">'
        message += '            <li>주관식 - 단답형</li>'
        message += '            <li>주관식 - 장문형</li>'
        message += '            <hr>'
        message += '            <li selected>객관식 질문</li>'
        message += '            <li>체크박스</li>'
        message += '            <li>드롭다운</li>'
        message += '            <hr>'
        message += '            <li>객관식 표</li>'
        message += '            <li>체크박스 표</li>'
        message += '            <hr>'
        message += '            <li>날짜</li>'
        message += '            <li>시간</li>'
        message += '        </ul>'
        message += '    </div>'
        message += '</div>'

        document.getElementById('question_main').innerHTML += message;
    }

</script>

<%@ include file="../footer.jsp" %>
