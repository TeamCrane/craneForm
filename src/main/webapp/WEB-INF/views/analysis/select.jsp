<%--
  Created by IntelliJ IDEA.
  User: JYeolI
  Date: 2023-03-15
  Time: 오후 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<style>

    .loading-indicator {
        display: inline-block;
        width: 20px;
        height: 20px;
        border-radius: 50%;
        border: 2px solid #ccc;
        border-top-color: #333;
        animation: spin 0.8s linear infinite;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

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
    }

    .box-content {
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

    .box:active > .box-content {
        cursor: grabbing;
        background-color: #f9f9f9;
        border: 1px dashed gray;
        opacity: 0.7;
    }

    .box.analysis > .box-content {
        flex-basis: 100px;
    }

    .box-analysis {
        flex-basis: 100%;
        margin: auto;
        display: flex;
        justify-content: space-between;
    }

    .box-bar {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        margin: 36px;
        height: 20px;
        border-radius: 10px;
        background-color: #ddd;
        position: relative;
    }

    .box-value {
        margin: 36px;
        padding: 0 8px;
        background-color: #ffabab;
        font-weight: bold;
        border: 2px solid #ddd;
        border-radius: 50%;
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
            <div class="d-flex justify-content-end align-items-center mb-4">
                <button class="btn btn-primary me-3" id="save">현재 상태 저장</button>
                <button class="btn btn-primary me-3">이미지로 변환</button>
                <button class="btn btn-primary" onclick="resetAnalysis()">초기화</button>
            </div>
            <div class="row mb-5">
                <div class="col-12 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="card shadow" id="survey-list">
                        <div class="loading-indicator m-auto"></div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-7 mb-5 mb-lg-0">
                    <div class="card shadow text-center target" id="analysis">
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-2 mb-5 mb-lg-0">
                    <div class="card shadow text-center target" id="options">
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>

    let surveys = new Array();
    let titlesNum = new Array();
    let titlesName = new Array();
    let questionsNum = new Array();
    let questionsName = new Array();
    let questionsOrder = new Array();
    let optionsNum = new Array();
    let optionsOrder = new Array();
    let optionsName = new Array();
    let answerCount = new Array();
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

                // 설문 결과 정보 객체에 저장
                surveys = r.select_result;
                for(i of r.select_result.values()) {

                    if(!titlesNum.includes(i.si_no)) {
                        titlesNum.push(i.si_no);
                        titlesName.push(i.si_subtitle);
                    }

                    if(!questionsOrder.includes(i.si_no+"-"+i.qs_order)) {
                        questionsNum.push(i.si_no);
                        questionsOrder.push(i.si_no+"-"+i.qs_order);
                        questionsName.push(i.qs_detail);
                    }

                    optionsNum.push((i.so_no));
                    optionsOrder.push(i.si_no+"-"+i.qs_order+"-"+i.so_order);
                    optionsName.push(i.so_detail);
                    answerCount.push(i.sa_count);

                }

                console.log(surveys);
                console.log(titlesNum);
                console.log(titlesName);
                console.log(questionsNum);
                console.log(questionsOrder);
                console.log(questionsName);
                console.log(optionsNum);
                console.log(optionsOrder);
                console.log(optionsName);
                console.log(answerCount)

                surveyList();
                $(".survey-question").click(optionList);

                $("#save").click(saveAnalysis);

            }
        })
    }

    // 1번 카드에 설문 리스트 만들기
    function surveyList() {

        let tag = '<div class="mt-3"></div>';
        if(titlesNum.length==0) {
            tag = '<div class="m-auto" style="color: #ddd; font-weight: bold; font-size: 2rem">설문을 만들어주세요</div>';
        }
        else {
            for (let i = 0; i < titlesNum.length; i++) {
                tag += '<div class="survey" data-order="'+titlesNum[i]+'">'+
                    '<p class="survey-title mt-4">'+titlesName[i]+'</p>'+
                    '<div class="survey-questions d-none">';
                for (let j = 0; j < questionsOrder.length; j++) {
                    if(titlesNum[i]==questionsOrder[j].split("-")[0]) {
                        tag += '<p class="survey-question" data-no="'+questionsNum[j]+'" data-order="'+questionsOrder[j].split("-")[1]+'">'+questionsName[j]+'</p>';
                    }
                }
                tag += '</div>'+
                    '</div>';
            }
        }
        $("#survey-list").html(tag);
        $('.survey-title').click(toggleQuestions);

    }

    // 3번 카드에 옵션 리스트 만들기
    function optionList() {

        $("#analysis").html("");
        let tag = "";
        for (let i = 0; i < optionsOrder.length; i++) {
            let ord = optionsOrder[i].split("-");
            if(ord[0]==$(this).parent().parent(".survey").data("order") && ord[1]==$(this).data("order")) {
                tag += '<div class="box" draggable="true" data-no="'+$(this).data("no")+'" data-order="'+ord[2]+'">'+
                            '<div class="box-content">'+optionsName[i]+'</div>'+
                            '<div class="box-analysis d-none" data-no="'+optionsNum[i]+'" data-survey="'+optionsOrder[i]+'">'+
                                '<p class="box-bar" data-value="'+answerCount[i]+'"></p>'+
                                '<p class="box-value">'+answerCount[i]+'</p>'+
                            '</div>'+
                        '</div>';
            }
        }
        $("#options").html(tag);
        dragAndDrop();

    }

    // 2번 카드에 통계 표시하기
    function analysisData() {

        let total = 0;
        $('.analysis').children(".box-analysis").children(".box-bar").each(function() {
            total += parseInt($(this).attr('data-value'));
        });
        $('.analysis').children(".box-analysis").children(".box-bar").each(function() {
            let value = parseInt($(this).attr('data-value'));
            let ratio = value / total;
            $(this).css('width', ratio * 100 + '%');
            $(this).css('background-color', '#ffabab');
        });

    }

    // 현재 상태 저장
    function saveAnalysis() {

        if($(".analysis").data("no")==undefined) { alert("일단 데이터 없음을 확인하는 메시지 입니다."); return; }

        let so_no = new Array();
        $(".analysis").children(".box-analysis").each(function() {
            so_no.push($(this).data("no"));
        });

        let data = {
            qs_no:$(".analysis").data("no"),
            so_no:so_no
        }

        $.ajax({
            url:"/api/analysis/save",
            type:"put",
            data:JSON.stringify(data),
            contentType:"application/json",
            success: function (r) {

            }
        })

    }

    // 초기화
    function resetAnalysis() {

        if(!confirm("초기화 하시겠습니까?")) { return; }
        $(".target").html("");

    }

</script>

<script>

    // survey-title 요소를 클릭했을 때 survey-questions 요소를 토글하는 함수
    function toggleQuestions(event) {
        const survey = event.target.nextElementSibling;
        survey.classList.toggle('d-none');
    }

    function toggleQuestions() {
        const survey = $(this).next('.survey-questions');
        survey.toggleClass('d-none');
    }

    // survey-title 요소에 click 이벤트를 등록함
    const surveyTitles = document.querySelectorAll('.survey-title');
    for (let i = 0; i < surveyTitles.length; i++) {
        surveyTitles[i].addEventListener('click', toggleQuestions);
    }

</script>

<script>

    function dragAndDrop() {
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
                    currentBox.classList.add("analysis");

                    // 2번 카드에 옵션을 드래그앤드롭하면 통계 표시
                    $(".analysis").children(".box-analysis").removeClass("d-none");
                    analysisData();

                } else if (target.id === "options") {
                    currentBox.classList.remove("analysis");

                    // 3번 카드에 옵션을 드래그앤드롭하면 통계 표시 제거
                    $("#options").children(".box").children(".box-analysis").addClass("d-none");
                    analysisData();

                }
            });
        });
    }

</script>


<%@ include file="../footer.jsp" %>