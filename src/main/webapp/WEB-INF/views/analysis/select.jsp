<%--
  Created by IntelliJ IDEA.
  User: JYeolI
  Date: 2023-03-15
  Time: 오후 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<script src="/js/jquery_v3.6.4.js"></script>

<style>

    .container {
        max-width: 1600px;
    }

    .card {
        height: 700px;
        overflow-y: scroll;
    }

    .card::-webkit-scrollbar {
        display: none;
    }

    .box {
        display: flex;
        align-items: center;
        justify-content: center;
        width: calc(100% - 20px);
        height: 100px;
        margin: 10px;
        background-color: #f9f9f9;
        border: 2px solid #ddd;
        border-radius: 10px;
        cursor: grab;
        transition: opacity 0.2s ease-in-out;
        text-align: center;
    }

    .box:hover {
        background-color: #eee;
    }

    .box:active, .box.selected {
        cursor: grabbing;
        background-color: #f9f9f9;
        border: 1px dashed gray;
        opacity: 0.7;
    }

    .hovered {
        background-color: lightgray;
        border: 1px dashed gray;
        opacity: 0.7;
    }

    .survey {
        display: block;
        padding-left: 20px;
        width: calc(100% - 20px);
        margin: 10px;
        border: 2px solid #ddd;
        border-radius: 10px;
    }
    
    .survey:hover {
        background-color: #eee;
    }

    .survey-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
        padding-right: 0;
        cursor: pointer;
    }

    .survey-question {
        font-size: 16px;
        margin-bottom: 5px;
        padding-left: 20px;
        cursor: pointer;
    }

    .survey-title:hover,
    .survey-question:hover {
        text-decoration: underline;
    }

</style>

<main>
    <div class="section section-md">
        <div class="container">
            <div class="row mb-5">
                <div class="col-12 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="card shadow">
                        <div class="mt-3"></div>
                        <div class="survey" data-order="1">
                            <p class="survey-title mt-4">Survey 1</p>
                            <div class="survey-questions d-none">
                                <p class="survey-question">Survey 1 Question 1</p>
                                <p class="survey-question">Survey 1 Question 2</p>
                            </div>
                        </div>
                        <div class="survey" data-order="2">
                            <p class="survey-title mt-4">Survey 2</p>
                            <div class="survey-questions d-none">
                                <p class="survey-question">Survey 2 Question 1</p>
                                <p class="survey-question">Survey 2 Question 2</p>
                                <p class="survey-question">Survey 2 Question 3</p>
                            </div>
                        </div>
                        <div class="survey" data-order="3">
                            <p class="survey-title mt-4">Survey 3</p>
                            <div class="survey-questions d-none">
                                <p class="survey-question">Survey 3 Question 1</p>
                                <p class="survey-question">Survey 3 Question 2</p>
                            </div>
                        </div>
                        <div class="survey" data-order="4">
                            <p class="survey-title mt-4">Survey 4</p>
                            <div class="survey-questions d-none">
                                <p class="survey-question">Survey 4 Question 1</p>
                                <p class="survey-question">Survey 4 Question 2</p>
                            </div>
                        </div>
                        <div class="survey" data-order="5">
                            <p class="survey-title mt-4">Survey 5</p>
                            <div class="survey-questions d-none">
                                <p class="survey-question">Survey 5 Question 1</p>
                                <p class="survey-question">Survey 5 Question 2</p>
                                <p class="survey-question">Survey 5 Question 3</p>
                                <p class="survey-question">Survey 5 Question 4</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-7 mb-5 mb-lg-0">
                    <div class="card shadow text-center target" id="analysis">
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-2 mb-5 mb-lg-0">
                    <div class="card shadow text-center target" id="options">
                        <div class="box" draggable="true" data-order="1">Box 1</div>
                        <div class="box" draggable="true" data-order="2">Box 2</div>
                        <div class="box" draggable="true" data-order="3">Box 3</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>

    let titlesNum = new Array();
    let titlesName = new Array();
    let questionsNum = new Array();
    let questionsName = new Array();
    let questionsOrder = new Array();
    let optionsName = new Array();
    let optionsOrder = new Array();
    let saved;

    $(function () {
        selectResultList();

    })

    function selectResultList() {
        $.ajax({
            url:"/api/analysis/select",
            type:"get",
            resultType:"application/json",
            success:function(r) {

                console.log(r.select_result);

                for(i of r.select_result.values()) {

                    if(!titlesNum.includes(i.si_no)) {
                        titlesNum.push(i.si_no);
                        titlesName.push(i.si_subtitle);
                    }
                    if(!questionsNum.includes(i.qs_no)) {
                        questionsNum.push(i.qs_no);
                        questionsName.push(i.qs_detail);
                        questionsOrder.push(i.qs_order);
                    }
                    optionsName.push(i.so_detail);
                    optionsOrder.push(i.so_order);
                }

                console.log(titlesNum);
                console.log(titlesName);
                console.log(questionsNum);
                console.log(questionsName);
                console.log(questionsOrder);
                console.log(optionsName);
                console.log(optionsOrder);

            }
        })
    }

</script>

<script>

    // survey-title 요소를 클릭했을 때 survey-questions 요소를 토글하는 함수
    function toggleQuestions(event) {
        const survey = event.target.nextElementSibling;
        survey.classList.toggle('d-none');
    }

    // survey-title 요소에 click 이벤트를 등록함
    const surveyTitles = document.querySelectorAll('.survey-title');
    for (let i = 0; i < surveyTitles.length; i++) {
        surveyTitles[i].addEventListener('click', toggleQuestions);
    }

</script>

<script>

    const boxes = document.querySelectorAll('.box');
    const targets = document.querySelectorAll('.target');
    let currentBox = null;

    boxes.forEach(box => {
        box.addEventListener('dragstart', () => {
            box.classList.add('selected');
            currentBox = box;
        });

        box.addEventListener('dragend', () => {
            box.classList.remove('selected');
            const order = Array.from(target.children).indexOf(box) + 1;
            box.dataset.order = order;
            currentBox = null;
        });
    });

    targets.forEach(target => {
        target.addEventListener('dragover', e => {
            e.preventDefault();
            target.classList.add('hovered');
        });

        target.addEventListener('dragleave', () => {
            target.classList.remove('hovered');
        });

        target.addEventListener('drop', () => {
            target.classList.remove('hovered');
            const children = Array.from(target.children);
            const order = parseInt(currentBox.dataset.order);
            const targetIndex = children.findIndex(child => parseInt(child.dataset.order) > order);
            if (targetIndex >= 0) {
                target.insertBefore(currentBox, children[targetIndex]);
            } else {
                target.appendChild(currentBox);
            }
            if (target.id === "analysis") {
                currentBox.innerHTML += "-1";
            } else if (target.id === "options") {
                currentBox.innerHTML = currentBox.innerHTML.replace("-1", "");
            }
        });
    });

</script>


<%@ include file="../footer.jsp" %>