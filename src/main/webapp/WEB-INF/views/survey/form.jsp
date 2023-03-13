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
        <div class="col-8">
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
                        <div class="row align-items-center">
                            <div class="col-md-8"></div>
                            <input type="text">
                            <div class="btn-group me-2 mb-2">
                                <button type="button" class="btn btn-secondary">Default</button>
                                <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split me-n1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="fas fa-angle-down dropdown-arrow"></span>
                                    <span class="sr-only">Toggle Dropdown</span>
                                </button>
                                <div class="dropdown-menu py-0" style="">
                                    <a class="dropdown-item rounded-top" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item rounded-bottom" href="#">Separated link</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-2"></div>
    </div>
</main>

<%@ include file="../footer.jsp" %>


