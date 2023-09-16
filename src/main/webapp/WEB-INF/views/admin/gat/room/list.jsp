<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script defer
	src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
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
	height: calc(( 360/ 1080)* 100vh);
}
</style>
<div class="wrap">
	<ul>
		<li><a href="room" class="tab">시설 관리</a></li>
		<li><a href="room" class="tab">예약 현황</a></li>
	</ul>
</div>
<br />
<div class="serviceWrap">
	<input type="text" oninput="onQuickFilterChanged()" id="quickFilter"
		placeholder="검색어를 입력하세요" />
</div>
<br />
<br />
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
        {field: "fcltyResveSn", headerName: "예약번호", cellRenderer: returnValue},
        {field: "commonCodeFcltyKindParent", headerName: "시설 종류 구분",getQuickFilterText: (params) => {return params.value}},
        {field: "commonCodeFcltyKind", headerName: "시설 이름"},
        {field: "fcltyResveBeginTime", headerName: "시작 시간"},
        {field: "fcltyResveEndTime", headerName: "끝 시간"},
        {field: "fcltyResveEmplNm", headerName: "예약 사원"},
        {field: "fcltyResveEmplId", headerName: "사번"},
        {field: "fcltyResveRequstMatter", headerName: "요청사항"},
        {field: "chk", headerName: " ", cellRenderer: ClassBtn},
    ];
    const rowData = [];
        <c:forEach items="${toDayList}" var="room" varStatus="state">
         <c:set var="beginTime" value="${room.fcltyResveBeginTime}"/>
         <fmt:formatDate var="fBeginTime" value="${beginTime}" pattern="HH:mm"/>
         <c:set var="endTime" value="${room.fcltyResveEndTime}"/>
         <fmt:formatDate var="fEndTime" value="${endTime}" pattern="HH:mm"/>
        rowData.push({
            fcltyResveSn: "${room.fcltyResveSn}",
            commonCodeFcltyKindParent: "${room.fcltyCode}",
            commonCodeFcltyKind: "${room.fcltyName}",
            fcltyResveBeginTime: "${fBeginTime}",
            fcltyResveEndTime: "${fEndTime}",
            fcltyResveEmplNm: "${room.fcltyEmplName}",
            fcltyResveEmplId: "${room.fcltyResveEmplId}",
            fcltyResveRequstMatter : "${room.fcltyResveRequstMatter}",
            chk:"${room.fcltyResveSn}"
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
    function delClickEvent() {
        let delEvents = document.querySelectorAll("#myGrid");
        delEvents.forEach(function (delEvent) {
            delEvent.addEventListener("click", function () {
                console.log("취소가 되니?");
                if (confirm("정말 취소하시겠습니까?")) { // 사용자에게 확인 메시지 표시
                    const fcltyResveSn = this.getAttribute("data-fcltyResveSn");
    					console.log(fcltyResveSn);

                    // 값이 비어있으면 요청을 보내지 않도록 확인
                    if (fcltyResveSn) {
                        const xhr = new XMLHttpRequest();
                     // 삭제 요청을 보낼때 중요한 정보가 아니므로 get을 사용하고, 파라미터 값을 가져올때 순번으로 가져오는데
                     // 쿼리에서 orderBy를 한번에 순번에 적용하지 말고,
                     // from밑에 orderBy를 하고 순번을 가져올때 카운트랑 별개로 가져와야 하므로,
                     // varStatus="stat"를 추가해서 카운트는 순번과 별개로 화면에 보여지고,버튼을 누르면 순번만 인식해서 지워짐!
                        xhr.open("get", "/reservation/deleteReserved?fcltyResveSn=" +fcltyResveSn, true);  
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                console.log("삭제가 완료되었습니다. 상태 코드: " + xhr.responseText);
                                location.reload(); // 페이지 리로드
                            } else {
                                console.log("삭제 요청이 실패했습니다. 상태 코드: " + xhr.status);
                            }
                        };

                        xhr.onerror = function () {
                            console.error("네트워크 오류로 인해 삭제 요청이 실패했습니다.");
                        };

                        xhr.send("fcltyResveSn=" + fcltyResveSn);
                    }
                }
            });
        });
    }
</script>