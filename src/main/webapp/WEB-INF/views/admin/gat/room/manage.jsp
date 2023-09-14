<%--
  Created by IntelliJ IDEA.
  User: Ha-Neul Yun
  Date: 2023-09-08
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
#fcltyResveSn, #fcltyCatagory, .fcltyResveSn{
	display: none;
}
</style>
<div class="wrap">
	<ul>
		<li><a href="#" class="tab">시설 관리</a></li>
		<li><a href="#" class="tab">예약 현황</a></li>
	</ul>
</div>
<br /><br />
<div class="cardWrap">
	<div class="card">
		<div class="header">
			<h3>오늘 예약 현황</h3>
			<p>
				<a href="#" class="totalResve"><span id="countValue"></span>건</a>
			</p>
			<a href="list">더보기</a>
		</div>
<br />
		<div class="content">
				<table border=1 style="width: 100%" id="allReservedRooms">
					<thead>
						<tr>
							<th>순서</th>
							<th id="fcltyResveSn">순번</th>
							<th id="fcltyCatagory">시설 종류 구분</th>
							<th>예약시설 이름</th>
							<th>시작 날짜</th>
							<th>끝 날짜</th>
							<th>예약 사원(사번)</th>
							<th>예약 취소</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reservedRooms}" var="room" varStatus="stat">
							<tr>
								<td>${stat.count}</td>
								<td class="fcltyResveSn">${room.fcltyResveSn}</td>
								<td id="fcltyCatagory">${room.commonCodeFcltyKind}</td>
								<td>${room.fcltyName}</td>
								<c:set var="fcltyResveBegin" value="${room.fcltyResveBeginTime}"/>
								<fmt:formatDate value="${fcltyResveBegin}" pattern="yyyy-MM-dd" var="fbeginTime"/>
								<td>${fbeginTime}</td>
								<c:set var="fcltyResveEnd" value="${room.fcltyResveEndTime}"/>
								<fmt:formatDate value="${fcltyResveEnd}" pattern="yyyy-MM-dd" var="fendTime"/>
								<td>${fendTime}</td>
								<td>${room.fcltyResveEmplId}</td>
								<td><button class="delEvent" type="button" data-fcltyResveSn="${room.fcltyResveSn}">예약취소</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		</div>
	</div>
<br /><br /><hr><br /><br />
	<div class="card">
		<div class="header">
			<div class="titleWrap" style="display: block">
				<h3>시설 관리</h3>
				<br/>
				<table>
					<tbody>
					<c:forEach items="${countingRoom}" var="count">
						<tr>
							<td>회의실 | <span class="totalConfm"></span>개</td>
							<td>휴게실 | ${count.retiringRoom}개</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
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
//각 버튼에 클릭 이벤트 핸들러 추가
function delClickEvent() {
    let delEvents = document.querySelectorAll(".delEvent");
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

// 페이지가 로드될 때 실행
document.addEventListener("DOMContentLoaded", function () {
    // 모든 <td> 요소 중 id가 "fcltyResveSn"인 요소를 선택합니다.
    const tdElements = document.querySelectorAll("td.fcltyResveSn");

    // 선택된 <td> 요소의 갯수를 가져옵니다.
    const count = tdElements.length;

    // 결과를 화면에 표시합니다.
    document.getElementById("countValue").textContent = count;

    // delClickEvent 함수 호출
    delClickEvent();
});  

function countMeeting (){
	let meeting = document.querySelectorAll(".totalConfm");
	meeting.onload = function fAjax(){
		let xhr = new XMLHttpRequest();
		xhr.open("GET","/reservation/countMeeting?countingMeetng=" +countingMeetng",true);
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200){
				console.log(xhr.responseText);
			}
		}
		xhr.send();
	}

}
</script>