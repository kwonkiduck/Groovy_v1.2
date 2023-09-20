<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
    #myGrid {
        width: 100%;
        height: calc((360 / 1080) * 100vh);
    }
</style>
<h1 class="tab">기본 급여 및 공제 관리</h1>
<br/><br/>
<h2>급여 기본 설정</h2>
<button id="saveSalary">저장하기</button>
<%--<div id="myGrid" class="ag-theme-alpine"></div>--%>

<%--<br/>--%>
<table border=" 1">
    <tr>
        <td>(만원)</td>
        <td>사원</td>
        <td>대리</td>
        <td>과장</td>
        <td>차장</td>
        <td>팀장</td>
        <td>부장</td>
    </tr>
    <c:forEach var="salaryItem" items="${salary}" varStatus="salaryStat">
        <tr>
            <td>${salaryItem.commonCodeDeptCrsf}</td>
            <c:forEach var="bonusItem" items="${bonus}">
                <c:set var="total" value="${salaryItem.anslryAllwnc + bonusItem.anslryAllwnc}"/>
                <td>${total.toString().substring(0, 4)}</td>
            </c:forEach>
        </tr>
    </c:forEach>
</table>
<hr/>
<br/>


<h2>소득세 설정</h2>
<form action="" id="incmtaxForm">
    <button id="saveIncmtax" type="button">저장하기</button>
    <table border=" 1">
        <c:forEach var="tariffVO" items="${tariffList}" varStatus="stat">
            <c:if test="${tariffVO.taratStdrNm == '소득세' || tariffVO.taratStdrNm == '지방소득세'}">
                <tr>
                    <th>${tariffVO.taratStdrNm}</th>
                    <td>
                        <input type="text" name="${tariffVO.taratStdrCode}" value="${tariffVO.taratStdrValue}">%
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</form>

<h2>공제 기본 설정</h2>
<form action="">
    <button id="saveSis">저장하기</button>
    <table border=" 1">
        <%--        </c:forEach>--%>
        <c:forEach var="tariffVO" items="${tariffList}" varStatus="stat">
            <c:if test="${tariffVO.taratStdrNm != '소득세' && tariffVO.taratStdrNm != '지방소득세'}">
                <tr>
                    <th>${tariffVO.taratStdrNm}</th>
                    <td>
                        개인부담분 :
                        <input type="text" name="${tariffVO.taratStdrCode}" value="${tariffVO.taratStdrValue}">%
                        회사부담분 :
                        <input type="text" name="${tariffVO.taratStdrCode}" value="${tariffVO.taratStdrValue}">%
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</form>

<script>
    let saveList = [];

    function getAllData() {
        const rowData = gridOptions.api.forEachNode((obj, idx) => {
            saveList.push(obj.data);
        });
    }

    function saveDataToServer() {
        getAllData();
        const url = undefined;/* 매핑 url 쓰셈*/
        const requestData = JSON.stringify({saveList});
        ajaxFn(url, requestData);
    }

    function ajaxFn(url, item) {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: requestData = item,
        })
            .then((response) => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to save data');
                }
            })
            .then((data) => {
                console.log('Server response:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }

    const saveSalary = document.getElementById('saveSalary');
    saveSalary.addEventListener('click', () => {
        saveDataToServer();
    });


    /*그냥 확인하라고 넣음*/
    const columnDefs = [
        {headerName: '(만원)', field: 'category'},
        {field: "DEPT010", headerName: "인사팀", editable: true},
        {field: "DEPT011", headerName: "회계팀", editable: true},
        {field: "DEPT012", headerName: "영업팀", editable: true},
        {field: "DEPT013", headerName: "홍보팀", editable: true},
        {field: "DEPT014", headerName: "총무팀", editable: true}
    ];
    let rowData = [
        {DEPT010: 5, DEPT011: 1, DEPT012: 10, DEPT013: 50, DEPT014: 100, category: "사원"},
        {DEPT010: 5, DEPT011: 1, DEPT012: 10, DEPT013: 50, DEPT014: 100, category: "대리"},
        {DEPT010: 5, DEPT011: 1, DEPT012: 10, DEPT013: 50, DEPT014: 100, category: "과장"},
        {DEPT010: 5, DEPT011: 1, DEPT012: 10, DEPT013: 50, DEPT014: 100, category: "차장"},
        {DEPT010: 5, DEPT011: 1, DEPT012: 10, DEPT013: 50, DEPT014: 100, category: "팀장"},
        {DEPT010: 5, DEPT011: 1, DEPT012: 10, DEPT013: 50, DEPT014: 100, category: "부장"}
    ];

    const gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData,
    };
    /* 실제 불러올 때 -> ajax가 있고 foreach로 불러오는거 있음 선택하셈 */

    document.addEventListener('DOMContentLoaded', () => {
        const gridDiv = document.querySelector('#myGrid');
        new agGrid.Grid(gridDiv, gridOptions);
    });


    // TODO
    // 소득세 수정 ajax
    $("#saveIncmtax").on("click", function () {
        let form = ("#incmtaxForm")[0];
        let formData = new FormData(form);
        $.ajax({
            url:,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success(data) {
                console.log("소득세 업데이트 성공")
            },
            error(xhr) {

            }
        })
    })
</script>