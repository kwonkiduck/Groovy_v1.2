<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    ul {
        list-style: none;
        padding-left: 0;
    }

    .wrap ul {
        display: flex;
        gap: 10px
    }

    #myGrid {
        width: 100%;
        height: calc((360 / 1080) * 100vh);
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<div class="content-container">
    <div class="wrap">
        <%--    <ul>--%>
        <%--        <li><a href="/reserve/manageVehicle" class="tab">차량 관리</a></li>--%>
        <%--        <li><a href="/reserve/loadVehicle" class="tab">예약 현황</a></li>--%>
        <%--    </ul>--%>
    </div>
    <br/>
    <div class="serviceWrap">
        <input type="text" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="검색어를 입력하세요"/>
    </div>
    <br/><br/>
    <div class="cardWrap">
        <div class="card">
            <div id="myGrid" class="ag-theme-alpine"></div>
        </div>
    </div>
</div>
<script>
    /*예시*/
    // const returnCar = (params) => params.value;

    // class ClassComp {
    //     init(params) {
    //         this.eGui = document.createElement('div');
    //         if (rowData.pop().vhcleResveReturnAt == 'Y') {
    //             this.eGui.innerHTML = `
    //                 <p class="returnStatus">반납완료</p>
    //             `;
    //
    //         } else if (rowData.pop().vhcleResveReturnAt == 'N') {
    //             this.eGui.innerHTML = `
    //                 <button class="returnCarBtn" id="\${params.value}">반납 확인</button>
    //                 <p class="returnStatus" style="display: none;">반납완료</p>
    //             `;
    //         }
    //         this.id = params.value;
    //         this.btnReturn = this.eGui.querySelector(".returnCarBtn");
    //         this.returnStatus = this.eGui.querySelector(".returnStatus");
    //         this.btnReturn.onclick = () => {
    //             let vhcleResveNo = rowData.pop().chk;
    //             let xhr = new XMLHttpRequest();
    //             xhr.open("put", "/reserve/return", true);
    //             xhr.onreadystatechange = () => {
    //                 if (xhr.status == 200 && xhr.readyState == 4) {
    //                     if (xhr.responseText == 1) {
    //                         this.btnReturn.style.display = 'none';
    //                         this.returnStatus.style.display = 'block';
    //                     }
    //                 }
    //             }
    //             xhr.send(vhcleResveNo);
    //         }
    //     }
    //
    //     getGui() {
    //         return this.eGui;
    //     }
    //
    //     destroy() {
    //     }
    // }

    const getMedalString = function (param) {
        const str = `\${param} `;
        return str;
    };
    const MedalRenderer = function (params) {
        return getMedalString(params.value);
    };

    function onQuickFilterChanged() {
        gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
    }

    const columnDefs = [
        {field: "cprCardResveSn", headerName: "예약번호"},
        // {
        //     field: "vhcleNo", headerName: "차량번호", getQuickFilterText: (params) => {
        //         return getMedalString(params.value);
        //     }
        // },
        {field: "cprCardUsePurps", headerName: "사용 목적"},
        {field: "cprCardUseExpectAmount", headerName: "사용 예상 금액"},
        {field: "cprCardResveBeginDate", headerName: "사용 시작 일자"},
        {field: "cprCardResveClosDate", headerName: "사용 종료 일자"},
        {field: "commonCodeDept", headerName: "부서"},
        {field: "cprCardResveEmplId", headerName: "사번"},
        {field: "emplNm", headerName: "이름"},
        // {field: "chk", headerName: " ", cellRenderer: ClassComp},
    ];
    const rowData = [];
    <c:forEach var="sanctionVO" items="${sanctionList}" varStatus="status">

    rowData.push({
        cprCardResveSn: "${sanctionVO.cprCardResveSn}",
        cprCardUsePurps: "${sanctionVO.cprCardUsePurps}",
        cprCardUseExpectAmount: "${sanctionVO.cprCardUseExpectAmount}",
        cprCardResveBeginDate: "${sanctionVO.cprCardResveBeginDate}",
        cprCardResveClosDate: "${sanctionVO.cprCardResveClosDate}",
        commonCodeDept: "${sanctionVO.commonCodeDept}",
        cprCardResveEmplId: "${sanctionVO.cprCardResveEmplId}",
        emplNm: "${sanctionVO.emplNm}",

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

    //
    // /* 실제 ajax에서 데이터 가져올 때 */
    // const realGrid = () => {
    //     const columnDefs = [
    //         {field: "vhcleResveNo", headerName: "예약번호", cellRenderer: returnCar},
    //         {
    //             field: "vhcleNo", headerName: "차량번호", getQuickFilterText: (params) => {
    //                 return getMedalString(params.value);
    //             }
    //         },
    //         {field: "vhcleResveBeginTime", headerName: "시작 시간"},
    //         {field: "vhcleResveEndTime", headerName: "끝 시간"},
    //         {field: "vhcleResveEmpNm", headerName: "예약 사원"},
    //         {field: "vhcleResveEmplId", headerName: "사번"},
    //         {field: "chk", headerName: " ", cellRenderer: ClassComp},
    //     ];
    //
    //     const gridOptions = {
    //         columnDefs: columnDefs,
    //     };
    //     document.addEventListener('DOMContentLoaded', () => {
    //         const gridDiv = document.querySelector('#myGrid');
    //         new agGrid.Grid(gridDiv, gridOptions);
    //
    //         $.ajax({
    //             url: '',
    //             method: 'GET',
    //             dataType: 'json',
    //             success: function (data) {
    //                 gridOptions.api.setRowData(data);
    //             },
    //             error: function (error) {
    //                 console.error('Error fetching data:', error);
    //             },
    //         });
    //     });
    // }
</script>