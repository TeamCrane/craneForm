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

    .nav-description {
        position: absolute;
        right: 100%;
        top: 0;
        background-color: whitesmoke;
        color: #454545;
        padding: 10px;
        border-radius: 5px;
        opacity: 0;
        transform: translateX(-10px);
        transition: opacity 0.2s, transform 0.2s;
    }

    .nav-form-link:hover .nav-description {
        opacity: 1;
        transform: translateX(0);
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

    .question-separator {
        border-top: 1px solid rgba(0, 0, 0, .12);
        margin: 8px 0;
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
                                <div class="mb-2 me-2 question-type">
                                    <label for="question-type-select" class="form-label"></label>
                                    <select class="form-select" id="question-type-select">
                                        <option value="short-answer">주관식 - 단답형</option>
                                        <option value="long-answer">주관식 - 장문형</option>
                                        <optgroup label="&#xf0da; &#xf0da; &#xf0da;"></optgroup>
                                        <option value="multiple-choice" selected>객관식 질문</option>
                                        <option value="checkbox">체크박스</option>
                                        <option value="dropdown">드롭다운</option>
                                        <optgroup label="&#xf0da; &#xf0da; &#xf0da;"></optgroup>
                                        <option value="multiple-choice-table">객관식 표</option>
                                        <option value="checkbox-table">체크박스 표</option>
                                        <optgroup label="&#xf0da; &#xf0da; &#xf0da;"></optgroup>
                                        <option value="date">날짜</option>
                                        <option value="time">시간</option>
                                    </select>
                                </div>
                            </div>
                            <div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-2">
            <div class="nav-form">
                <a href="#" class="nav-form-link" title="질문 추가"><i class="fas fa-plus"></i></a>
                <a href="#" class="nav-form-link" title="질문 가져오기"><i class="fas fa-download"></i></a>
                <a href="#" class="nav-form-link" title="섹션 추가"><i class="fas fa-plus-square"></i></a>
            </div>
        </div>
    </div>
</main>
<%@ include file="../footer.jsp" %>


