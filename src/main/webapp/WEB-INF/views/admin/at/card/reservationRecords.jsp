<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 동작 위한 스타일 외엔(예: display:none 등) 전부 제가 작업하면서 편하게 보려고 임시로 먹인겁니다 ! --%>

<%--
이 jsp를 손 볼 사람에게
반납 완료된 내역에 왜 <p> 태그가 안 먹히는지 모르겠습니다...
success하면 자동으로 셀 리프레시하게 해놨는데 innerHTML이 안 돼서 그러나 그것도 안 먹힙니다
일단 백은 완벽하게 다 해놨고, 말씀 드린 부분만 잡아주세요... 감사합니다...
--%>


<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<header>
    <h1><a href="${pageContext.request.contextPath}/card/manage">회사 카드 관리</a></h1>
    <h1><a href="${pageContext.request.contextPath}/card/reservationRecords">대여 내역 관리</a></h1>
</header>
<main>
    <div id="reservationRecords">
        <div id="recordGrid" class="ag-theme-alpine"></div>
    </div>
</main>
<script>

    class ClassComp {
        init(params) {
            let data = params.node.data;
            let cprCardResveSn = data.cprCardResveSn;
            let cprCardNo = data.cprCardNo;

            let modifyData = {
                cprCardResveSn: cprCardResveSn,
                cprCardNo: cprCardNo
            };
            console.log(data.cprCardResveRturnAt);
            this.eGui = document.createElement('div');
            if(data.cprCardResveRturnAt == 0) {
                console.log("중")
                this.eGui.innerHTML = "<button id='returnChkBtn'>반납 확인</button>";
            } else {
                console.log("완료")
                this.eGui.innerHTML = "<p>반납 완료</p>";
            }

            this.returnChkBtn = this.eGui.querySelector("#returnChkBtn");
            this.returnChkBtn.onclick = () => {
                $.ajax({
                    url: "/card/returnChecked",
                    type: "post",
                    data: JSON.stringify(modifyData),
                    contentType: "application/json;charset:utf-8",
                    success: function (result) {
                        console.log(result);
                       /* data.cprCardResveRturnAt = 1;
                        this.eGui.innerHTML = "<p>반납 완료</p>";
                        gridOptions.api.refreshCells({ force: true });
                        alert("카드 반납 완료 처리하였습니다.");*/
                    },
                    error: function (xhr) {
                        alert("오류로 인한 처리 실패");
                        console.log(xhr.responseText);
                    }
                });
            };
        }

        getGui() {
            return this.eGui;
        }

        destroy() {}
    }


    function returnChkFnc(){

    }
    const getMedalString = function (param) {
        const str = `${param} `;
        return str;
    };
    const MedalRenderer = function (params) {
        return getMedalString(params.value);
    };
    function onQuickFilterChanged() {
        gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
    }
    const columnDefs = [
        {
            headerName: "순번",
            valueGetter: "node.rowIndex + 1",
        },
        { field: "cprCardResveSn", headerName:"예약 순번", hide: true, getQuickFilterText: (params) => {
                return getMedalString(params.value);
            }},
        { field: "cprCardResveEmplIdAndName",  headerName:"사원명(사번)"},
        { field: "cprCardNo",  headerName:"대여 카드 번호", hide: true},
        { field: "cprCardNm",  headerName:"대여 카드"},
        { field: "cprCardResveBeginDate", headerName:"사용 시작 일자"},
        { field: "cprCardResveClosDate", headerName:"사용 마감 일자"},
        { field: "cprCardResveRturnAt", headerName: "반납 여부", hide: true},
        { field: "cardReturnChk", headerName: "카드 반납", cellRenderer: ClassComp},
    ];

    const rowData = [];
    <c:forEach items="${records}" var="resve">
    <fmt:formatDate var= "cprCardResveBeginDate" value="${resve.cprCardResveBeginDate}" type="date" pattern="yyyy-MM-dd" />
    <fmt:formatDate var= "cprCardResveClosDate" value="${resve.cprCardResveClosDate}" type="date" pattern="yyyy-MM-dd" />
    rowData.push({
        cprCardResveSn : "${resve.cprCardResveSn}",
        cprCardNo : "${resve.cprCardNo}",
        cprCardNm: "${resve.cprCardNm}",
        cprCardResveEmplIdAndName : "${resve.cprCardResveEmplNm}(${resve.cprCardResveEmplId})",
        cprCardResveBeginDate : "${cprCardResveBeginDate}",
        cprCardResveClosDate : "${cprCardResveClosDate}",
        cprCardResveRturnAt : "${resve.cprCardResveRturnAt}"
    })
    </c:forEach>

    const gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData
    };

    document.addEventListener('DOMContentLoaded', () => {
        const gridDiv = document.querySelector('#recordGrid');
        new agGrid.Grid(gridDiv, gridOptions);

    });
</script>