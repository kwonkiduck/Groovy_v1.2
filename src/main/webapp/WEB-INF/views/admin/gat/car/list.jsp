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
<div class="wrap">
    <ul>
        <li><a href="/reserve/manageVehicle" class="tab">차량 관리</a></li>
        <li><a href="/reserve/loadVehicle" class="tab">예약 현황</a></li>
    </ul>
</div>
<br/>
<div class="serviceWrap">
    <!--<select name="filter" id="filter">
        <option value="vhcleNo">차량번호</option>
        <option value="vhcleVhcty">차종</option>
    </select>-->
    <input type="text" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="검색어를 입력하세요"/>
</div>
<br/><br/>
<div class="cardWrap">
    <div class="card">
        <div id="myGrid" class="ag-theme-alpine"></div>
    </div>
</div>

<script>
    /*예시*/
    const returnCar = (params) => params.value;

    class ClassComp {
        init(params) {
            this.eGui = document.createElement('div');
            this.eGui.innerHTML = `
                    <button class="returnCarBtn" id="\${params.value}">반납 확인</button>
                `;
            this.id = params.value;
            this.btnReturn = this.eGui.querySelector(".returnCarBtn");
            /*ajax 추가 하기~*/
            this.btnReturn.onclick = () => alert(this.id + "ddd 반납 완료");
        }

        getGui() {
            return this.eGui;
        }

        destroy() {
        }
    }

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
        {field: "vhcleResveNo", headerName: "예약번호", cellRenderer: returnCar},
        {
            field: "vhcleNo", headerName: "차량번호", getQuickFilterText: (params) => {
                return getMedalString(params.value);
            }
        },
        {field: "vhcleResveBeginTime", headerName: "시작 시간"},
        {field: "vhcleResveEndTime", headerName: "끝 시간"},
        {field: "vhcleResveEmpNm", headerName: "예약 사원"},
        {field: "vhcleResveEmplId", headerName: "사번"},
        {field: "chk", headerName: " ", cellRenderer: ClassComp},
    ];
    const rowData = [];
    <c:forEach var="vehicleVO" items="${todayReservedVehicles}" varStatus="status"> <!-- 12: 공지사항 개수(length) -->
    <c:set var="beginTimeStr" value="${vehicleVO.vhcleResveBeginTime}"/>
    <fmt:formatDate var="beginTime" value="${beginTimeStr}" pattern="HH:mm"/>
    <c:set var="endTimeStr" value="${vehicleVO.vhcleResveEndTime}"/>
    <fmt:formatDate var="endTime" value="${endTimeStr}" pattern="HH:mm"/>
    rowData.push({
        vhcleResveNo: "${vehicleVO.vhcleResveNo}",
        vhcleNo: "${vehicleVO.vhcleNo}",
        vhcleResveBeginTime: "${beginTime}",
        vhcleResveEndTime: "${endTime}",
        vhcleResveEmpNm: "${vehicleVO.vhcleResveEmplNm}",
        vhcleResveEmplId: "${vehicleVO.vhcleResveEmplId}",
        chk: "${vehicleVO.vhcleResveNo}"
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


    /* 실제 ajax에서 데이터 가져올 때 */
    const realGrid = () => {
        const columnDefs = [
            {field: "vhcleResveNo", headerName: "예약번호", cellRenderer: returnCar},
            {
                field: "vhcleNo", headerName: "차량번호", getQuickFilterText: (params) => {
                    return getMedalString(params.value);
                }
            },
            {field: "vhcleResveBeginTime", headerName: "시작 시간"},
            {field: "vhcleResveEndTime", headerName: "끝 시간"},
            {field: "vhcleResveEmpNm", headerName: "예약 사원"},
            {field: "vhcleResveEmplId", headerName: "사번"},
            {field: "chk", headerName: " ", cellRenderer: ClassComp},
        ];

        const gridOptions = {
            columnDefs: columnDefs,
        };
        document.addEventListener('DOMContentLoaded', () => {
            const gridDiv = document.querySelector('#myGrid');
            new agGrid.Grid(gridDiv, gridOptions);

            $.ajax({
                url: '',
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    gridOptions.api.setRowData(data);
                },
                error: function (error) {
                    console.error('Error fetching data:', error);
                },
            });
        });
    }
</script>