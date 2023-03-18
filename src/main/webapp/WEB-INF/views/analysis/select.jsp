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

    .container {
        max-width: 1600px;
    }

    .card {
        height: 700px;
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
        background-color: #f9f9f9;
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

</style>

<main>
    <div class="section section-md">
        <div class="container">
            <div class="row mb-5">
                <div class="col-12 col-md-6 col-lg-4 mb-5 mb-lg-0">
                    <div class="card shadow text-center">
                        <a href="#">tag</a>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 mb-5 mb-lg-0">
                    <div class="card shadow text-center target">
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 mb-5 mb-lg-0">
                    <div class="card shadow text-center target">
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
        });
    });
</script>


<%@ include file="../footer.jsp" %>