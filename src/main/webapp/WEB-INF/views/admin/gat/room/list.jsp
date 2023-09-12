<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
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
<div class="wrap">
    <ul>
        <li><a href="/gat/manageVehicle" class="tab">차량 관리</a></li>
        <li><a href="/gat/loadVehicle" class="tab">예약 현황</a></li>
    </ul>
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

<script>
    const returnValue = (params) => params.value;

    class ClassBtn {
        init(params) {
            this.eGui = document.createElement('div');
            this.eGui.innerHTML = `
                    <button class="cancelRoom" id="\${params.value}">예약 취소</button>
                `;
            this.id = params.value;
            this.btnReturn = this.eGui.querySelector(".cancelRoom");

            /*ajax 추가 하기~*/
            this.btnReturn.onclick = () => alert(this.id + "ddd 예약 취소 완료");
        }

        getGui() {
            return this.eGui;
        }

        destroy() {
        }
    }
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
    const columnDefs = [
        {field: "fcltyResveSn", headerName: "순번", cellRenderer: returnValue},
        {field: "commonCodeFcltyKindParent", headerName: "시설 종류 구분",getQuickFilterText: (params) => {return params.value}},
        {field: "commonCodeFcltyKind", headerName: "시설 이름"},
        {field: "fcltyResveBeginTime", headerName: "시작 시간"},
        {field: "fcltyResveEndTime", headerName: "끝 시간"},
        {field: "fcltyResveEmplNm", headerName: "예약 사원"},
        {field: "fcltyResveEmplId", headerName: "사번"},
        {field: "fcltyResveRequstMatter", headerName: "요청사항"},
        {field: "chk", headerName: " ", cellRenderer: ClassBtn},
    ];
    const rowData = [
        {
            fcltyResveSn: "1",
            commonCodeFcltyKindParent: "회의실",
            commonCodeFcltyKind: "A101",
            fcltyResveBeginTime: "09:00",
            fcltyResveEndTime: "13:00",
            fcltyResveEmplNm: "강서주",
            fcltyResveEmplId: "202308001",
            fcltyResveRequstMatter : "요청사항",
        },
        {
            fcltyResveSn: "1",
            commonCodeFcltyKindParent: "회의실",
            commonCodeFcltyKind: "A101",
            fcltyResveBeginTime: "09:00",
            fcltyResveEndTime: "13:00",
            fcltyResveEmplNm: "강서주",
            fcltyResveEmplId: "202308001",
            fcltyResveRequstMatter : "요청사항",
        }
    ]
    const gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData,
    };

    /*module.exports = returnCarButtonRenderer;*/
    document.addEventListener('DOMContentLoaded', () => {
        const gridDiv = document.querySelector('#myGrid');
        new agGrid.Grid(gridDiv, gridOptions);

    });
</script>