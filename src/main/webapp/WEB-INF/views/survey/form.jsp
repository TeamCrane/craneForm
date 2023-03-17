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
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
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
        font-weight: bolder;
        color: #535cff;
        background-color: #c9c7ff;
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

    .option_main {
        display: flex;
        flex: 1;
    }

    .option_main > input {
        font-size: 16px;
        margin-top: 10px;
        margin-bottom: 10px;
        border-right: none;
        border-left: none;
        border-top: none;
        border-bottom: 0.0625rem solid #D1D5DB;
        padding-bottom: 5px;
        width: 95%;
    }

    .option_main > input:focus {
        outline: none;
    }

    .example_del {
        cursor: pointer;
        padding: 3px;
    }

    .example_del:hover {
        background-color: #fdd6e2;
        border: 1px solid #fdbbbe;
        border-radius: 4px;
    }

    .question_main {
        display: flex;
        flex-wrap: wrap;
    }

    .multi-check {
        margin: auto;
        padding-right: 10px;
    }

    .multi-check input[type="checkbox"] {
        margin-right: 5px;
    }

    .required {
        margin-left: auto;
        padding-right: 10px;
    }

    .required input[type="checkbox"] {
        margin-right: 5px;
    }

    label {
        font-weight: normal;
    }

</style>

<main class="container mt-5">
    <form method="post">
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
                                <input type="text" name="title" class="title" placeholder="제목 없는 설문지" value="">
                                <input type="text" name="description" class="form-control description" placeholder="설문지 설명" value="">
                            </div>
                        </div>
                    </div>
                </div>

                <div id="question" class="mb-5">
                    <div class="card shadow">
                        <div class="card-body px-5 py-5 text-center text-md-left">
                            <div class="row">
                                <input type="hidden" id="question_cnt" value="0">
                                <div id="question_main_0" class="question_main btn-group align-items-center">
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" placeholder="질문 1">
                                    </div>
                                    <div class="col-md-4">
                                        <div id="select_wrapper_0" class="select-wrapper">
                                            <div class="select-trigger"
                                                 onclick="selectTypeMenu(this)">
                                                객관식
                                            </div>
                                            <ul id="select_options_0" class="select-options" style="display: none">
                                                <li onclick="updateTypeMenu(this)"><i class="fas fa-pencil-alt"></i>
                                                    &nbsp;
                                                    주관식 - 단답형
                                                </li>
                                                <li onclick="updateTypeMenu(this)"><i class="fas fa-pencil-alt"></i>
                                                    &nbsp;
                                                    주관식 - 장문형
                                                </li>
                                                <hr>
                                                <li selected onclick="updateTypeMenu(this)"><i
                                                        class="fas fa-check-circle"></i> &nbsp; 객관식
                                                </li>
                                                <li onclick="updateTypeMenu(this)"><i class="far fa-check-square"></i>
                                                    &nbsp; 체크박스
                                                </li>
                                                <li onclick="updateTypeMenu(this)"><i class="fas fa-caret-down"></i>
                                                    &nbsp;
                                                    드롭다운
                                                </li>
                                                <hr>
                                                <li onclick="updateTypeMenu(this)"><i class="fas fa-th"></i> &nbsp; 객관식
                                                    표
                                                </li>
                                                <li onclick="updateTypeMenu(this)"><i class="far fa-check-square"></i>
                                                    &nbsp; 체크박스 표
                                                </li>
                                                <hr>
                                                <li onclick="updateTypeMenu(this)"><i class="far fa-calendar-alt"></i>
                                                    &nbsp; 날짜
                                                </li>
                                                <li onclick="updateTypeMenu(this)"><i class="far fa-clock"></i> &nbsp;
                                                    시간
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="required">
                                        <input type="checkbox" id="required_0"><label for="required_0"><span style="color: red">*</span> 필수 여부</label>
                                    </div>
                                    <div class="multi-check">
                                        <input type="checkbox" id="multi_check_0"><label for="multi_check_0">다중 선택 허용</label>
                                    </div>
                                    <div id="option_0" class="col-12">
                                        <div id="option_main_0_0" class="option_main align-items-center">
                                            <input type="hidden" id="option_cnt_0_0" value="0">
                                            <i class="fas fa-solid fa-arrow-circle-right"></i>&nbsp;
                                            <input type="text" id="option_0_0" placeholder="옵션 1">&nbsp;
                                        </div>
                                        <div id="addOption_0_0" class="option_main align-items-center">
                                            <i class="fas fa-solid fa-arrow-circle-plus"></i>&nbsp;<button
                                                class="btn btn-outline-gray option_btn">옵션 추가
                                        </button>
                                        </div>
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
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <button type="button" class="btn btn-lg btn-primary btn-block" onclick="questionComplete()" style="width: 100%">제출</button>
            </div>
            <div class="col-2"></div>
        </div>
    </form>
</main>

<section id="setting">

</section>

<script>

    const select_option_list = document.querySelectorAll('.select-options');

    // 클릭하면 질문 유형 목록이 보인다
    function selectTypeMenu(event) {

        // 해당 요소의 이웃 요소를 가져온다
        const selectOptions = event.nextElementSibling;

        // 목록이 닫혀있다면 열고 열려있다면 닫는다
        selectOptions.style.display = (selectOptions.style.display === 'none') ? 'flex' : 'none';
    }

    // 질문 유형 목록이 열렸을 때 다른 곳을 클릭하면 display:none 처리한다
    document.addEventListener('click', function (event) {
        const question_cnt = parseInt(document.getElementById('question_cnt').value);
        const select_wrappers = document.querySelectorAll('.select-wrapper');

        for (let i = 0; i <= question_cnt; i++) {
            const select_options = select_wrappers[i].querySelector('.select-options');
            if (!select_wrappers[i].contains(event.target)) {
                select_options.style.display = 'none';
            }
        }
    });

    // 옵션을 클릭하면 해당 옵션으로 텍스트 내용이 바뀌고 목록이 사라진다
    function updateTypeMenu(event) {
        const selected_option = event.parentElement.querySelector('li[selected]');
        const chosen_option = event;

        // alert(selected_option.textContent.trim());

        // 클릭된 요소로 selected 옮기기
        selected_option.removeAttribute('selected');
        chosen_option.setAttribute('selected', 'selected');

        // 클릭된 요소를 기본으로 세팅하고 선택창 display:none
        const select_trigger = chosen_option.closest('.select-wrapper').querySelector('.select-trigger');
        select_trigger.textContent = chosen_option.textContent.trim();
        event.parentElement.style.display = 'none';

    }


    // 질문 추가
    function addQuestion() {

        // 질문 번호 가져오기
        let question_cnt = parseInt(document.getElementById('question_cnt').value);

        // 옵션 번호 가져오기
        let option_main_id = $('#question_main_' + question_cnt).find('.option_main').eq(0).attr('id');
        let option_cnt = parseInt(option_main_id.slice(-1));

        // 1 더해서 대입
        question_cnt += 1;
        document.getElementById('question_cnt').value = question_cnt;

        let message = "";
        message += '<br>';
        message += '<div class="card shadow">';
        message += '    <div class="card-body px-5 py-5 text-center text-md-left">';
        message += '    <div class="row">';
        message += '        <div id="question_main_' + question_cnt + '" class="question_main btn-group align-items-center">';
        message += '            <div class="col-md-8">';
        message += '                <input type="text" class="form-control" placeholder="질문 ' + (question_cnt + 1) + '">';
        message += '            </div>';
        message += '            <div class="col-md-4">';
        message += '                <div id="select_wrapper_' + question_cnt + '" class="select-wrapper">';
        message += '                    <div class="select-trigger" onclick="selectTypeMenu(this)">객관식</div>';
        message += '                    <ul id="select_options_' + question_cnt + '" class="select-options" style="display: none">';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="fas fa-pencil-alt"></i> &nbsp; 주관식 - 단답형</li>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="fas fa-pencil-alt"></i> &nbsp; 주관식 - 장문형</li>';
        message += '                        <hr>';
        message += '                        <li selected onclick="updateTypeMenu(this)"><i class="fas fa-check-circle"></i> &nbsp; 객관식</li>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="far fa-check-square"></i> &nbsp; 체크박스</li>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="fas fa-caret-down"></i> &nbsp; 드롭다운</li>';
        message += '                        <hr>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="fas fa-th"></i> &nbsp; 객관식 표</li>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="far fa-check-square"></i> &nbsp; 체크박스 표</li>';
        message += '                        <hr>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="far fa-calendar-alt"></i> &nbsp; 날짜</li>';
        message += '                        <li onclick="updateTypeMenu(this)"><i class="far fa-clock"></i> &nbsp; 시간</li>';
        message += '                    </ul>';
        message += '                </div>';
        message += '                </div>';
        message += '                <div class="required">';
        message += '                    <input type="checkbox" id="required_' + question_cnt + '"><label for="required_' + question_cnt + '"><span style="color: red">*</span> 필수 여부</label>';
        message += '                </div>';
        message += '                <div class="multi-check">';
        message += '                    <input type="checkbox" id="multi_check_' + question_cnt + '"><label for="multi_check_' + question_cnt + '">다중 선택 허용</label>';
        message += '                </div>';
        message += '                <div id="option_' + question_cnt + '" class="col-12">';
        message += '                    <div id="option_main_' + question_cnt + '_' + option_cnt + '" class="option_main align-items-center">';
        message += '                        <input type="hidden" id="option_cnt_' + question_cnt + '_' + option_cnt + '" value="0">';
        message += '                        <i class="fas fa-solid fa-arrow-circle-right"></i>&nbsp;';
        message += '                        <input type="text" id="option_' + question_cnt + '_' + option_cnt + '" placeholder="옵션 ' + (option_cnt + 1) + '">&nbsp;';
        message += '                    </div>';
        message += '                    <div id="addOption_' + question_cnt + '_' + option_cnt + '" class="option_main align-items-center">';
        message += '                        <i class="fas fa-solid fa-arrow-circle-plus"></i>&nbsp;<button class="btn btn-outline-gray option_btn">옵션 추가</button>';
        message += '                    </div>';
        message += '                </div>';
        message += '            </div>';
        message += '        </div>';
        message += '    </div>';
        message += '</div>';
        message += '</div>';

        document.getElementById('question').innerHTML += message;
    }

    // 옵션 추가
    $(document).on('click', '.option_btn', function (event) {
        // 옵션 추가 버튼을 클릭하면 해당 옵션의 질문 번호를 가져온다
        // 선택한 요소의 질문 번호를 가져와야하기에 번거로운 방법을 거친다
        const question_main_id = $(event.target).closest('.question_main').attr('id');
        const question_main_array = question_main_id.split('_');
        const question_cnt = question_main_array[2];

        // 해당 옵션의 옵션 번호를 가져온다.
        //const option_main_id = $(this).closest('.option_main').attr('id');
        //let option_cnt = parseInt(option_main_id.slice(-1));
        let option_main_id = $('#question_main_' + question_cnt).find('.option_main').last().attr('id');
        let option_cnt = parseInt(option_main_id.slice(-1));

        // 버튼을 제거한다.
        const addButton = document.getElementById('addOption_' + question_cnt + '_' + option_cnt);
        addButton.remove();

        option_cnt += 1;


        let message = "";
        message += '<div id="option_main_' + question_cnt + '_' + option_cnt + '" class="option_main align-items-center">';
        message += '    <input type="hidden" id="option_cnt_' + question_cnt + '_' + option_cnt + '" value="0">';
        message += '        <i class="fas fa-solid fa-arrow-circle-right"></i>&nbsp;';
        message += '        <input type="text" id="option_' + question_cnt + '_' + option_cnt + '" placeholder="옵션 ' + (option_cnt + 1) + '">&nbsp;';
        message += '</div>';
        message += '<div id="addOption_' + question_cnt + '_' + option_cnt + '" class="option_main align-items-center">';
        message += '    <i class="fas fa-solid fa-arrow-circle-plus"></i>&nbsp;<button class="btn btn-outline-gray option_btn">옵션 추가</button>';
        message += '</div>';

        document.getElementById('option_' + question_cnt).innerHTML += message;
    });

    /*const select_trigger0 = $(this).closest('.select-wrapper');
        const select_trigger = select_trigger0.children('.select-trigger');
        select_trigger.text(event.textContent);
        selected_option.style.display = 'none';*/

    /*if (!event.target.querySelector('hr')) {
        alert()

        event.addEventListener('click', function () {
            const selected_option = event.querySelector('.select-options li[selected]');

            // 클릭된 요소로 selected 옮기기
            selected_option.removeAttribute('selected');
            event.setAttribute('selected', 'selected');

            // 클릭된 요소를 기본으로 세팅하고 선택창 display:none
            const selectTrigger0 = $(this).closest('.select-wrapper');
            const selectTrigger = selectTrigger0.children('.select-trigger');
            selectTrigger.text(event.textContent);
            selected_option.style.display = 'none';
        });
    }*/

    // const selectOptions = document.querySelector(".select-options");

    // 클릭 이벤트가 발생한 곳이 select-options 내부인지 외부인지 판단
    /*if (event.target.closest(".select-wrapper") === null) {

        // select-options 외부를 클릭했다면 display:none
        const questionCnt = document.getElementById('question_cnt').value;

        for (let i = 0; i < questionCnt; i++) {
            const select_options = document.getElementById('select_options_'+i);
            select_options.style.display = "none";
        }
    }*/

    /*selectOptions.querySelectorAll('li').forEach(function (option) {
        if (!option.querySelector('hr')) {
            option.addEventListener('click', function (event) {
                // const targeted_option = event.target;
                const selectedOption = document.querySelector('.select-options li[selected]');

                // 클릭된 요소로 selected 옮기기
                selectedOption.removeAttribute('selected');
                option.setAttribute('selected', 'selected');

                // 클릭된 요소를 기본으로 세팅하고 선택창 display:none
                const selectTrigger0 = $(this).closest('.select-wrapper');
                const selectTrigger = selectTrigger0.children('.select-trigger');
                selectTrigger.text(option.textContent);
                selectOptions.style.display = 'none';
            });
        }
    });*/

    /*for (let i = 0; i < select_wrappers; i++) {
            const select_options = select_wrappers[i].querySelectorAll('.select-options');
            let flag = true;
            for (let j = 0; j < select_options.length; j++) {
                // 옵션 목록이 전부 닫혀있는지 확인
                if (getComputedStyle(select_options[j]).display !== 'flex') {
                    flag = false;
                    break;
                }
            }

            // 하나라도 열려있으면 전부 닫기
            if (flag) {
                for (let j = 0; j < select_options.length; j++) {
                    select_options[j].style.display = 'none';
                }
            }
        }*/
</script>

<%@ include file="../footer.jsp" %>
