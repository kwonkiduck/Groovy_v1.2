<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content-container">
    <h1><a href="/facility/meeting">회의실 예약</a></h1>
    <h1><a href="/facility/rest">자리 예약</a></h1>
    <h1><a href="/facility/vehicle">차량 예약</a></h1>

    <hr/>
    <c:forEach var="vehicleVO" items="${vehicles}">
        <button type="button" onclick="setRoomNumber(this); loadReservedList(this);">
            <i></i>
            <div>
                <h3>${vehicleVO.vhcleVhcty}</h3> <!-- 차량 -->
                <p class="no">${vehicleVO.vhcleNo}</p> <!-- 차 번호 -->
                <h4>하이패스</h4>
                <p>${vehicleVO.commonCodeHipassAsnAt}</p> <!-- 가능/불가능 -->
                <h4>인원</h4>
                <p><span>${vehicleVO.vhclePsncpa}</span>명</p>
            </div>
        </button>
    </c:forEach>
    <hr/>
    <h2 onclick="goReservation()">예약하기</h2>
    <div id="reserveBox">
        <input type="hidden" name="vhcleNo" id="vhcleNo"/>
        <p id="today"></p>
        <p id="time"></p>
        <p>대여시간</p>
        <label>
            <select name="selectVhcleResveBeginTime" id="selectVhcleResveBeginTime">
                <option value="대여시간" selected>대여시간</option>
                <option value="9:00">9:00</option>
                <option value="10:00">10:00</option>
                <option value="11:00">11:00</option>
                <option value="12:00">12:00</option>
                <option value="13:00">13:00</option>
                <option value="14:00">14:00</option>
                <option value="15:00">15:00</option>
                <option value="16:00">16:00</option>
                <option value="17:00">17:00</option>
                <option value="18:00">18:00</option>
            </select>
        </label>

        <p>반납시간</p>
        <select name="selectVhcleResveEndTime" id="selectVhcleResveEndTime" required>
            <option value="반납시간" selected>반납시간</option>
            <option value="9:00">9:00</option>
            <option value="10:00">10:00</option>
            <option value="11:00">11:00</option>
            <option value="12:00">12:00</option>
            <option value="13:00">13:00</option>
            <option value="14:00">14:00</option>
            <option value="15:00">15:00</option>
            <option value="16:00">16:00</option>
            <option value="17:00">17:00</option>
            <option value="18:00">18:00</option>
            <option value="19:00">19:00</option>
            <option value="20:00">20:00</option>
            <option value="21:00">21:00</option>
            <option value="22:00">22:00</option>
        </select>
        <div>
            <p><i></i>가능</p>
            <p><i></i>불가능</p>
        </div>

        <button onclick="createReservation()" type="button">예약하기</button>
    </div>
    <h2 onclick="getMyReserveList()">내 예약 현황</h2>
    <div id="myReserveList" style="display: none"></div>
</div>
<script>
    //날짜
    let today = document.querySelector("#today");

    const currentDate = new Date();
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth() + 1;
    const day = currentDate.getDate();
    const now = `\${year}/\${month}/\${day}`;
    const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
    const dayOfWeek = daysOfWeek[currentDate.getDay()];

    let todayCode = `\${month}.\${day}(\${dayOfWeek})`;
    today.innerText = todayCode;

    //차량 번호
    function setRoomNumber(vhcle) {
        vhcleNo = $(vhcle).find(".no").html();
        $("#vhcleNo").attr("value", vhcleNo);
    }

    const selectVhcleResveBeginTime = document.getElementById("selectVhcleResveBeginTime");

    function loadReservedList(vhcle) {
        vhcleNo = $(vhcle).find(".no").html();
        let xhr = new XMLHttpRequest();
        xhr.open("get", `/facility/vehicle/reserved/\${vhcleNo}`, true);
        xhr.setRequestHeader("ContentType", "application/json;charset=utf-8");
        xhr.onreadystatechange = function () {
            if (xhr.status == 200 && xhr.readyState == 4) {
                const selectBeginTimeList = selectVhcleResveBeginTime.querySelectorAll('option');
                for (let i = 0; i < selectBeginTimeList.length; i++) {
                    selectBeginTimeList[i].removeAttribute("disabled");
                }
                let result = JSON.parse(xhr.responseText); // 어차피 예약된 애들만 옴
                for (let i = 0; i < result.length; i++) {
                    const reservedDate = new Date(result[i].vhcleResveBeginTime);
                    let reservedYear = reservedDate.getFullYear();
                    let reservedMonth = reservedDate.getMonth() + 1;
                    let reservedDay = reservedDate.getDate();
                    let reservedTime = reservedDate.getHours();

                    const reservedStr = `\${reservedYear}/\${reservedMonth}/\${reservedDay}`;
                    for (let j = 0; j < selectBeginTimeList.length; j++) {
                        let selectBeginTime = selectBeginTimeList[j].value;
                        let selectBeginHour = selectBeginTime.substring(0, selectBeginTime.indexOf(":"));
                        if (reservedStr == now && reservedTime == selectBeginHour) {
                            let option = selectVhcleResveBeginTime.querySelector(`option[value='\${selectBeginTime}']`);
                            option.disabled = true;
                        }
                    }
                }
            }
        }
        xhr.send(vhcleNo);
    }

    const myReserveList = document.querySelector("#myReserveList");
    const reserveBox = document.querySelector("#reserveBox");

    function getMyReserveList() {
        if (myReserveList.style.display === "none") {
            myReserveList.style.display = "block";
            reserveBox.style.display = "none";
            loadMyReserveList();
        }
    }

    function loadMyReserveList() {
        let tableStr = `<table border=1><tr><td>차번호</td><td>예약시간</td><td>취소</td></tr>`;
        let xhr = new XMLHttpRequest();
        xhr.open("get", "/facility/vehicle/myReservations", true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let myReservedList = JSON.parse(xhr.responseText);
                if (myReservedList.length > 0) {
                    for (let i = 0; i < myReservedList.length; i++) {
                        let beginHour = new Date(myReservedList[i].vhcleResveBeginTime).getHours().toString() + ":00";
                        let endHour = new Date(myReservedList[i].vhcleResveEndTime).getHours().toString() + ":00";
                        let newTr = document.createElement("tr");

                        tableStr += `
                            <tr>
                                <td>\${myReservedList[i].vhcleNo}</td>
                                <td>\${beginHour} - \${endHour}</td>
                                <td><button onclick="cancelReservation('\${myReservedList[i].vhcleResveNo}')">취소</button></td>
                             </tr>`;
                        document.querySelector("#myReserveList").innerHTML = tableStr;
                    }
                } else {
                    document.querySelector("#myReserveList").innerHTML = tableStr;
                }
            }
        }
        xhr.send();
    }

    function goReservation() {
        if (reserveBox.style.display === "none") {
            reserveBox.style.display = "block";
            myReserveList.style.display = "none";
        }
    }

    function createReservation() {
        let $vhcleResveBeginTime = $("select[name='selectVhcleResveBeginTime'] option:selected").val();
        $vhcleResveBeginTime = new Date(`\${now} \${$vhcleResveBeginTime}`);
        let $vhcleResveEndTime = $("select[name='selectVhcleResveEndTime'] option:selected").text();
        $vhcleResveEndTime = new Date(`\${now} \${$vhcleResveEndTime}`);

        let vehicleVO = {
            vhcleResveBeginTime: $vhcleResveBeginTime,
            vhcleResveEndTime: $vhcleResveEndTime,
            vhcleNo: $("input[name='vhcleNo']").val(),
            commonCodeResveAt: 'RESVE011'
        }

        $.ajax({
            url: "/facility/vehicle",
            type: "post",
            data: JSON.stringify(vehicleVO),
            contentType: "application/json;charset=utf-8",
            dataType: 'json',
            success: function (result) {
                if (result) {
                    alert("예약이 완료되었습니다. 총무팀에서 차키를 받을 수 있습니다.");
                }
                getMyReserveList();
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status);
                console.log("message: " + xhr.responseText);
                console.log("error: " + xhr.error);
                if (xhr.responseText === "vhcleNo is null") {
                    alert("차량을 선택해주세요.");
                } else if (xhr.responseText === "beginTime is null") {
                    alert("대여시간을 선택해주세요.");
                } else if (xhr.responseText === "endTime is null") {
                    alert("반납시간을 선택해주세요.");
                }

                if (xhr.responseText === "same time") {
                    alert("대여시간과 반납시간을 다르게 선택해주세요.");
                } else if (xhr.responseText === "end early than begin") {
                    alert("반납시간이 대여시간보다 이르게 선택되었습니다. 다시 시도해주세요.");
                }
            }
        });
    }

    function cancelReservation(vhcleResveNo) {
        $.ajax({
            url: `/facility/vehicle/\${vhcleResveNo}`,
            type: "delete",
            dataType: 'json',
            success: function (result) {
                loadMyReserveList();
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status);
                console.log("message: " + xhr.responseText);
                console.log("error: " + xhr.error);
            }
        });
    }
</script>
