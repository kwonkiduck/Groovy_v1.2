<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<div class="content-container">
    <h1 class="tab">공지 등록</h1>
    <button id="insertNoti">공지 등록</button>
    <div class="cardWrap">
        <div class="card">
            <input type="text" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="검색어를 입력하세요"/>
            <div id="myGrid" class="ag-theme-alpine"></div>
        </div>
    </div>
</div>
<%--<table border="1">
    <tr>
        <th>번호</th>
        <th>카테고리</th>
        <th><a href="#"></a>제목</th>
    </tr>
    <c:forEach var="noticeVO" items="${notiList}" varStatus="status"> <!-- 12: 공지사항 개수(length) -->
        <tr>
            <td>${status.count}</td>
            <td>${noticeVO.notiCtgryIconFileStreNm}</td>
            <td>${noticeVO.notiTitle}</td>
        </tr>
    </c:forEach>
</table>--%>


<%--${noticeVO.notiEtprCode}--%>
<script>
    const returnString = (params) => params.value;

    class ClassLink {
        init(params) {
            this.eGui = document.createElement('a');
            /* 매핑한거 넣으쇼*/
            this.eGui.setAttribute('href', `/notice/detailForAdmin?notiEtprCode=\${params.data.notiEtprCode}`);
            this.eGui.innerText = params.value;
        }

        getGui() {
            return this.eGui;
        }

        destroy() {
        }
    }

    class ClassBtn {
        init(params) {
            this.eGui = document.createElement('div');
            this.eGui.innerHTML = `
                    <button class="deleteNotice">삭제</button>
                `;
            this.id = params.data.notiEtprCode;
            this.deleteBtn = this.eGui.querySelector(".deleteNotice");
            /*ajax나 뭐 알아서 추가 하기~*/
            this.deleteBtn.onclick = () => {
                location.href = "/notice/deleteNotice?notiEtprCode=" + this.id
            };
        }

        getGui() {
            return this.eGui;
        }

        destroy() {
        }
    }

    /* 검색 */
    const getString = function (param) {
        const str = "${param}";
        return str;
    };
    const StringRenderer = function (params) {
        return getString(params.value);
    };

    function onQuickFilterChanged() {
        gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
    }

    let rowData = [];
    const columnDefs = [
        {field: "count", headerName: "번호", cellRenderer: returnString},
        {field: "notiCtgryIconFileStreNm", headerName: "카테고리"},
        {
            field: "notiTitle", headerName: "제목", cellRenderer: ClassLink, getQuickFilterText: (params) => {
                return params.data.notiTitle
            }
        },
        {field: "chk", headerName: " ", cellRenderer: ClassBtn},
        {field: "notiEtprCode", headerName: "notiEtprCode", hide: true},
    ];
    <c:forEach var="noticeVO" items="${notiList}" varStatus="status"> <!-- 12: 공지사항 개수(length) -->
    rowData.push({
        count: "${status.count}",
        notiCtgryIconFileStreNm: "${noticeVO.notiCtgryIconFileStreNm}",
        notiTitle: "${noticeVO.notiTitle}",
        notiEtprCode: "${noticeVO.notiEtprCode}",
    })
    </c:forEach>
    const gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData,
    };

    /*module.exports = returnCarButtonRenderer;*/
    document.addEventListener('DOMContentLoaded', () => {
        const gridDiv = document.querySelector('#myGrid');
        new agGrid.Grid(gridDiv, gridOptions);

    });
    const insertNotiBtn = document.querySelector("#insertNoti");
    const submitBtn = document.querySelector("#submitBtn");


    /*const modal = document.querySelector("#modal");*/
    insertNotiBtn.addEventListener("click", () => {
        location.href = "/notice/inputNotice";
    })

    /*submitBtn.addEventListener("click",() => {
        modal.style.display = "none";
    })*/
</script>
<%--노출 : NOTI020--%>
<%--비노출 : NOTI021--%>
