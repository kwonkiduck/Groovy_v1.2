<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .lineList > li {
            display: flex;
        }

        .lineinner {
            width: 300px;
            height: 150px;
            border: 1px solid red;
        }
    </style>
</head>
<body>

// 인사,HRT
// 회계,AT
// 영업,ST
// 홍보,PRT
// 총무,GAT
// 경영자,CEO
<div id="line">
    <div id="ceo">
        <ul class="ceo">
            <li class="department nav-list"><a href="#"><i class="icon i-arr-bt"></i></a></li>
            <ul>
            </ul>
        </ul>
    </div>
    <div id="hrt">
        <ul class="depth1 active">
            <li class="department nav-list"><a href="#" class="active">인사팀 <i class="icon i-arr-bt"></i></a></li>
            <ul>
            </ul>
        </ul>
    </div>
    <div id="at">
        <ul class="dept2">
            <li class="department nav-list"><a href="#">회계팀 <i class="icon i-arr-bt"></i></a></li>
            <ul>
            </ul>
        </ul>
    </div>
    <div id="st">
        <ul class="depth3">
            <li class="department nav-list"><a href="#">영업팀 <i class="icon i-arr-bt"></i></a></li>
            <ul>
            </ul>
        </ul>
    </div>
    <div id="prt">
        <ul class="depth4">
            <li class="department nav-list"><a href="#">홍보팀 <i class="icon i-arr-bt"></i></a></li>
            <ul>
            </ul>
        </ul>
    </div>
    <div id="gat">
        <ul class="depth5">
            <li class="department nav-list"><a href="#">총무팀 <i class="icon i-arr-bt"></i></a></li>
            <ul>
            </ul>
        </ul>
    </div>
    <div id="orgChart">
    </div>
    <div id="search">
        검색<input type="text" id="searchLine"/>
        <button type="button">검색</button>
        <p>검색 결과</p>
        <div name="result">

        </div>
        <hr>

        <hr>
    </div>
    <div id="approval">
        <div id="sanctionLine" class="lineinner" style="display: flex;">
            <p>결재 순서</p>
            <div class="btnWrap">
                <button type="button" class="lineAddBtn">추가</button>
            </div>
            <div class="contentWrap">
                <ul class="lineList"></ul>
            </div>
        </div>
        <div id="receiveLine" class="lineinner">
            <p>수신</p>
            <div class="btnWrap">
                <button type="button" class="lineAddBtn">추가</button>
            </div>
            <div class="contentWrap">
                <ul class="lineList"></ul>
            </div>
        </div>
        <div id="refrnLine" class="lineinner">
            <p>참조</p>
            <div class="btnWrap">
                <button type="button" class="lineAddBtn">추가</button>
            </div>
            <div class="contentWrap">
                <ul class="lineList"></ul>
            </div>
        </div>
    </div>
    <button type="button" class="submitLine">결재선 적용</button>
    <button>닫기</button>
</div>


<script>
    const lineAddBtn = document.querySelectorAll(".lineAddBtn");
    const lineInner = document.querySelectorAll(".lineInner");

    $.ajax({
        url: '/sanction/loadOrgChart',
        method: 'GET',
        contentType: "application/json;charset=utf-8",
        dataType: 'json',
        success: function (data) {
            data.forEach(function (employee) {
                var employeeLi = $('<li class=emplList>');
                employeeLi.html(
                    `<label style="display: flex">
                            <input type="checkbox" class="lineChk">
                            <input type="hidden" value= "\${employee.emplId}"/>
                            <div class="line-block">
                             <span class="name">\${employee.emplNm}</span>
                             <span class="dept">\${employee.commonCodeDept}</span>
                             <span class="clsf">\${employee.commonCodeClsf}</span>
                       </div></label>`);
                if (employee.commonCodeCrsf === '대표') {
                    $('#ceo .ceo > ul').append(employeeLi);
                } else if (employee.commonCodeDept === '회계') {
                    $('#at .depth2 > ul').append(employeeLi);
                } else if (employee.commonCodeDept === '영업') {
                    $('#st .depth3 > ul').append(employeeLi);
                } else if (employee.commonCodeDept === '홍보') {
                    $('#prt .depth4 > ul').append(employeeLi);
                } else if (employee.commonCodeDept === '총무') {
                    $('#gat .depth5 > ul').append(employeeLi);
                } else if (employee.commonCodeDept === '인사') {
                    $('#hrt .depth1 > ul').append(employeeLi);
                }

            });
        },
        error: function (xhr, textStatus, error) {
            console.log("AJAX 오류:", error);
        }
    });
    /* 결재선 추가 */

    lineInner.forEach(item => {
        item.addEventListener("click", (e) => {
            const lineList = item.querySelector('.lineList');
            let myArray = [];
            if (e.target.classList.contains("lineAddBtn")) {
                const chkLineList = document.querySelectorAll('input[type=checkbox]:checked');
                chkLineList.forEach(checkbox => {

                    const label = checkbox.closest('label').cloneNode(true);
                    let checkBox = label.querySelector("input[type=checkbox]");
                    const newLi = document.createElement("li");
                    checkBox.remove();
                    const button = document.createElement("button");
                    button.classList = "deleteListBtn";
                    button.innerText = "삭제";
                    button.onclick = function () {
                        const target = this.closest("li");
                        target.remove();
                    }

                    newLi.appendChild(label);
                    newLi.appendChild(button);
                    if (lineList) lineList.appendChild(newLi);
                    checkbox.checked = false;
                    return
                });


            }

        })
    })
</script>
</body>
</html>
