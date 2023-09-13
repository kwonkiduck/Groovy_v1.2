<%--
  Created by IntelliJ IDEA.
  User: Ha-Neul Yun
  Date: 2023-09-08
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
ul {
	list-style: none;
	padding-left: 0;
}

.wrap ul {
	display: flex;
	gap: 10px
}

.header, .titleWrap {
	display: flex;
	align-items: center;
	gap: 10px;
}

table tr {
	display: flex;
}

table tr td, table tr th {
	flex: 1;
}

.roomInfoList, .fxrpsList {
	display: flex;
	align-items: center;
	gap: 24px;
}

.content>ul {
	display: flex;
	flex-direction: column;
}

.roomInfo {
	display: grid;
	grid-template-rows: repeat(2, 1fr);
	grid-template-columns: repeat(2, 1fr)
}
</style>
<div class="wrap">
	<ul>
		<li><a href="#" class="tab">시설 관리</a></li>
		<li><a href="#" class="tab">예약 현황</a></li>
	</ul>
</div>
<div class="cardWrap">
	<div class="card">
		<div class="header">
			<h3>오늘 예약 현황</h3>
			<p>
				<a href="#" class="totalResve"><span id="countValue"></span>건</a>
			</p>
			<a href="#">더보기</a>
		</div>
		<div class="content">
			<table border=1 style="width: 100%" id="allReservedRooms">
				<thead>
					<tr>
						<th>순번</th>
						<th>시설 종류 구분</th>
						<th>시설 이름</th>
						<th>시작 날짜</th>
						<th>끝 날짜</th>
						<th>예약 사원(사번)</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${reservedRooms}" var="room">
						<tr>
							<td id="fcltyResveSn">${room.fcltyResveSn}</td>
							<td>${room.commonCodeFcltyKind}</td>
							<td>${room.fcltyName}</td>
							<td>${room.fcltyResveBeginTime}</td>
							<td>${room.fcltyResveEndTime}</td>
							<td>${room.fcltyResveEmplId}</td>
							<td><button class="deleteButton"
									data-fcltyResveSn="${room.fcltyResveSn}">예약취소</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="card">
		<div class="header">
			<div class="titleWrap" style="display: block">
				<h3>시설 관리</h3>
				<ul>
					<li>회의실 | <span class="totalConf">10</span>개
					</li>
					<li>휴게실 | <span class="totalRest">10</span>개
					</li>
				</ul>
			</div>
		</div>
		<div class="content">
			<div class="roomInfo">
				<ul id="conference">
					<li class="roomInfoList">
						<h4 class="roomId">A101</h4> <span class="roomType">회의실</span>
						<h5>비품</h5>
						<ul class="fxrpsList">
							<li>프로젝터</li>
							<li>스크린</li>
							<li>의자</li>
							<li>책상</li>
							<li>소화기</li>
						</ul>
					</li>
					<li class="roomInfoList">
						<h4 class="roomId">A101</h4> <span class="roomType">회의실</span>
						<h5>비품</h5>
						<ul class="fxrpsList">
							<li>프로젝터</li>
							<li>스크린</li>
							<li>의자</li>
							<li>책상</li>
							<li>소화기</li>
						</ul>
					</li>

				</ul>
				<ul id="rest">
					<li class="roomInfoList">
						<h4 class="roomId">R101</h4> <span class="roomType">휴게실</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    const deleteButtons = document.querySelectorAll(".deleteButton");
    deleteButtons.forEach(function(deleteButton) {
        deleteButton.addEventListener("click", function() {
            const fcltyResveSn = this.getAttribute("data-fcltyResveSn");
            
            // 값이 비어있으면 요청을 보내지 않도록 확인
            if (fcltyResveSn) {
                let xhr = new XMLHttpRequest();
                const encodedFcltyResveSn = encodeURIComponent(fcltyResveSn);
                xhr.open("GET", `/deleteReserved?fcltyResveSn=${encodedFcltyResveSn}`, true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log("삭제가 완료되었습니다. 상태 코드: " + xhr.responseText);
                        // 여기에서 필요한 추가 작업을 수행할 수 있습니다.
                    } else {
                        console.log("삭제 요청이 실패했습니다. 상태 코드: " + xhr.status);
                    }
                };
                xhr.send();
            }
        });
    });
});

//모든 <td> 요소 중 id가 "fcltyResveSn"인 요소를 선택합니다.
const tdElements = document.querySelectorAll("td#fcltyResveSn");

// 선택된 <td> 요소의 갯수를 가져옵니다.
const count = tdElements.length;

// 결과를 화면에 표시합니다.
document.getElementById("countValue").textContent = count;

</script>
