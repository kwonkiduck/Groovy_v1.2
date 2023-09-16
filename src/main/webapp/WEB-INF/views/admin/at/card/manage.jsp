<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 동작 위한 스타일 외엔(예: display:none 등) 전부 제가 작업하면서 편하게 보려고 임시로 먹인겁니다 ! --%>

<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
    #modifyCardInfoBtn, #saveCardInfoBtn, #cancelModifyCardInfoBtn, #disabledCardBtn {
        display: none;
    }
</style>
<header>
    <h1><a href="${pageContext.request.contextPath}/card/manage">회사 카드 관리</a></h1>
    <h1><a href="${pageContext.request.contextPath}/card/reservationRecords">대여 내역 관리</a></h1>
</header>
<main>
    <h1>카드 등록</h1>
    <div id="registerCard">
        <form id="registerCardForm" method="post">
            <label for="cardName">카드 이름</label>
            <input type="text" id="cardName" name="cprCardNm" required><br/>
            <label for="cardNo">카드 번호</label>
            <input type="text" id="cardNo" name="cprCardNo" placeholder="0000-0000-0000-0000" required><br/>
            <labek for="cardCom">카드사</labek>
            <select name="cprCardChrgCmpny" id="cardCom">
                <option value="IBK기업은행">IBK기업은행</option>
                <option value="KB국민카드">KB국민카드</option>
                <option value="NH농협은행">NH농협은행</option>
                <option value="롯데카드">롯데카드</option>
                <option value="비씨카드">비씨카드</option>
                <option value="삼성카드">삼성카드</option>
                <option value="신한카드">신한카드</option>
                <option value="우리카드">우리카드</option>
                <option value="하나카드">하나카드</option>
                <option value="한국씨티은행">한국씨티은행</option>
                <option value="현대카드">현대카드</option>
            </select>
            <button id="registerCardBtn">등록</button>
        </form>
    </div>
    <hr/>
    <h1>카드 목록</h1>
    <div id="cardList"></div>
    <hr/>
    <h1>카드 기본 정보</h1>
    <div id="cardInfo">
        <button id="modifyCardInfoBtn">수정</button>
        <button id="saveCardInfoBtn">저장</button>
        <button id="cancelModifyCardInfoBtn">취소</button>
        <button id="disabledCardBtn">사용불가 처리</button>
        <form id="cardInfoForm" method="post">
            <table border="1">
                <tr>
                    <td>카드 이름</td>
                    <td id="selectedCardName"></td>
                </tr>
                <tr>
                    <td>카드 번호</td>
                    <td id="selectedCardNo"></td>
                </tr>
                <tr>
                    <td>카드 회사</td>
                    <td id="selectedCardCom"></td>
                </tr>
            </table>
        </form>
    </div>
    <hr/>
    <h1>카드 신청 미처리건 <span id="waitingListCnt" style="color: dodgerblue; font-weight: bolder">${waitingListCnt}</span></h1>
    <div id="cardWaitingList">
        <div id="waitingListGrid" class="ag-theme-alpine"></div>
    </div>
    <hr/>

</main>

<script>
    const cardListDiv = $("#cardList");
    const registerCardBtn = $("#registerCardBtn");
    const saveCardInfoBtn = $("#saveCardInfoBtn");
    const cancelModifyCardInfoBtn = $("#cancelModifyCardInfoBtn");
    const modifyCardInfoBtn = $("#modifyCardInfoBtn");
    const disabledCardBtn = $("#disabledCardBtn");
    const selectedCardName = $("#selectedCardName");
    const selectedCardCom = $("#selectedCardCom");
    const selectedCardNo = $("#selectedCardNo");

    let currentCardNo;
    let currentCardNm;
    let optionCode;

    const returnResve = (params) => params.value;

    class ClassComp {

        init(params) {
            let data = params.node.data;
            let cprCardResveSn = data.cprCardResveSn;
            let selectedCardNo;
            let assignData = {};

            this.eGui = document.createElement('div');
            this.eGui.innerHTML = `<select name="cprCardNo" class="selectedCard"></select>
            <button id="submitBtn">저장</button>`;

            this.selectElement = this.eGui.querySelector('.selectedCard');
            this.btn = this.eGui.querySelector("#submitBtn");

            this.selectElement.innerHTML = optionCode;

            this.selectElement.addEventListener('change', (event) => {
                this.selectedOptionValue = event.target.value;
                selectedCardNo = this.selectedOptionValue;
                assignData = {
                    cprCardResveSn : cprCardResveSn,
                    cprCardNo : selectedCardNo,
                }
            });

            this.btn.onclick = () => {
                console.log(assignData);
                $.ajax({
                    url : "/card/assignCard",
                    type : "post",
                    data: JSON.stringify(assignData),
                    contentType: "application/json;charset:utf-8",
                    success : function (result) {
                        loadAllCard();
                        const newData = rowData.filter(item => item.cprCardResveSn !== assignData.cprCardResveSn);
                        gridOptions.api.setRowData(newData);
                        let cntText = $("#waitingListCnt").text();
                        let cnt = parseInt(cntText, 10);
                        $("#waitingListCnt").text(cnt - 1);
                        alert("카드 지정 완료")
                    },
                    error : function (xhr) {
                        alert("실패")
                        console.log(xhr.responseText);
                    }
                })
            };
        }

        constructor() {
            this.selectedOptionValue = '';
        }

        getGui() {
            return this.eGui;
        }

        destroy() {
        }
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
        { field: "cprCardResveBeginDate", headerName:"사용 시작 일자"},
        { field: "cprCardResveClosDate", headerName:"사용 마감 일자"},
        { field: "assign", headerName: "카드 지정", cellRenderer: ClassComp},
    ];

    const rowData = [];
    <c:forEach items="${loadCardWaitingList}" var="resve">
    <fmt:formatDate var= "cprCardResveBeginDate" value="${resve.cprCardResveBeginDate}" type="date" pattern="yyyy-MM-dd" />
    <fmt:formatDate var= "cprCardResveClosDate" value="${resve.cprCardResveClosDate}" type="date" pattern="yyyy-MM-dd" />
    rowData.push({
        cprCardResveSn : "${resve.cprCardResveSn}",
        cprCardResveEmplIdAndName : "${resve.cprCardResveEmplNm}(${resve.cprCardResveEmplId})",
        cprCardResveBeginDate : "${cprCardResveBeginDate}",
        cprCardResveClosDate : "${cprCardResveClosDate}",
    })
    </c:forEach>

    const gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData
    };

    document.addEventListener('DOMContentLoaded', () => {
        const gridDiv = document.querySelector('#waitingListGrid');
        new agGrid.Grid(gridDiv, gridOptions);

    });

    loadAllCard();


    registerCardBtn.on("click", function (event) {
        event.preventDefault();

        let cardNo = $("#cardNo").val();
        if (!isValidCardNumber(cardNo)) {
            alert("카드 번호 형식이 올바르지 않습니다.\n0000-0000-0000-0000 형식으로 입력하세요.");
            return;
        }

        let form = $("#registerCardForm")[0];
        let formData = new FormData(form);
        $.ajax({
            url: "/card/inputCard",
            type: "post",
            data: formData,
            success: function (result) {
                loadAllCard();
            },
            error: function (xhr) {
                console.log(xhr.responseText);
                alert("오류로 인한 실패")
            }
        })
    })

    function loadAllCard() {
        $.ajax({
            url: "/card/loadAllCard",
            type: "get",
            dataType: "json",
            success: function (result) {
                codeforList = "";
                optionCode = "<option value='null'>카드 선택</option>";
                $.each(result, function (idx, obj) {
                    codeforList += `<button class="cards" id="\${obj.cprCardNo}">
                    <p id="btnCardNm">\${obj.cprCardNm}</p>
                    <p id="btnCardNo">\${obj.maskCardNo}</p>
                    <p id="btnCardCom">\${obj.cprCardChrgCmpny}</p>
                    <input type=hidden id="btnCardStatus" value="\${obj.cprCardSttus}">
                    </button><br/>`;

                    let cprCardSttus = obj.cprCardSttus

                    if(cprCardSttus == 0) {
                        optionCode += `<option value="\${obj.cprCardNo}">\${obj.cprCardNm}</option>`;
                    }

                });
                cardListDiv.html(codeforList);
                $(".selectedCard").html(optionCode);

            },
            error: function (xhr) {
                console.log(xhr.responseText);
                alert("실패");
            }
        })
    }

    cardListDiv.on("click", ".cards", function () {
        let selectedCard = $(this);
        let cardNo = selectedCard.attr("id");
        let cardMarkNo = selectedCard.find("#btnCardNo").text();
        let cardNm = selectedCard.find("#btnCardNm").text();
        let cardCom = selectedCard.find("#btnCardCom").text();
        let cardStatus = selectedCard.find("#btnCardStatus").val();

        saveCardInfoBtn.hide();
        cancelModifyCardInfoBtn.hide();
        modifyCardInfoBtn.show();
        if(cardStatus != 2) {
            disabledCardBtn.show();
        } else {
            disabledCardBtn.hide();
        }

        selectedCardName.text(cardNm);
        selectedCardCom.text(cardCom);
        selectedCardNo.text(cardMarkNo);

        currentCardNo = cardNo;
        currentCardNm = cardNm;
    })

    modifyCardInfoBtn.on("click", function () {
        selectedCardName.html(`<input type='text' id='newCardNm' value='\${currentCardNm}'>`);
        $(this).hide();
        disabledCardBtn.hide();
        saveCardInfoBtn.show();
        cancelModifyCardInfoBtn.show();
    })

    saveCardInfoBtn.on("click", function () {
        let newCardNm = $("#newCardNm").val();
        selectedCardName.html('');
        selectedCardName.text(newCardNm);

        let modifiedData = {
            cprCardNo: currentCardNo,
            cprCardNm: newCardNm
        }

        $.ajax({
            url: "/card/modifyCardNm",
            type: "post",
            data: JSON.stringify(modifiedData),
            contentType: "application/json;charset:utf-8",
            success: function (result) {
                if (result == 1) {
                    loadAllCard();
                } else {
                    alert("수정 실패")
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
                alert("오류로 인한 실패");
            }
        })

        $(this).hide();
        cancelModifyCardInfoBtn.hide();
        modifyCardInfoBtn.show();
        disabledCardBtn.show();
    })

    cancelModifyCardInfoBtn.on("click", function () {
        selectedCardName.html('');
        selectedCardName.text(currentCardNm);

        $(this).hide();
        saveCardInfoBtn.hide();
        modifyCardInfoBtn.show();
        disabledCardBtn.show();
    })

    disabledCardBtn.on("click", function () {
        if (confirm(`'\${currentCardNm}' 카드를 사용불가 처리하시겠습니까?`)) {
            $.ajax({
                url: `/card/modifyCardStatusDisabled/\${currentCardNo}`,
                type: "get",
                success: function (result) {
                    if (result == 1) {
                        loadAllCard();
                        selectedCardName.html('');
                        selectedCardNo.html('');
                        selectedCardCom.html('');
                        alert("사용불가 처리 완료");
                    } else {
                        alert("사용불가 처리 실패")
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                    alert("오류로 인한 실패")
                }
            })
        } else {
            alert("사용불가 처리 취소");
        }
    })


    function isValidCardNumber(cardNumber) {
        let cardNumberPattern = /^\d{4}-\d{4}-\d{4}-\d{4}$/;
        return cardNumberPattern.test(cardNumber);
    }



</script>