<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
  .border {
    border: 1px solid #333333;
    display: flex;
    gap: 24px;
  }
  .taskBoxWrapper {
    display: flex; gap: 24px;
    margin: 48px;
  }
  .inTaskBox {
    border: 1px solid #333333;
    flex: 7;
  }
  .outTaskBox {
    border: 1px solid #333333;
    flex: 3;
  }
  .todoBoardListWrapper {display: flex; gap: 24px;}
  .list-header {display: flex; justify-content: space-between; align-items: center;}
</style>
<a href="#">할 일</a>
<a href="/job/jobDiary">업무 일지</a>
<div class="taskBoxWrapper">
  <div class="inTaskBox">
    <h1>들어온 업무 요청</h1>
    <ul>
      <li class="border">
        <span>이혜진</span>
        <p>스마트홈 시스템 확장, 인공지능 비서가 집안 생활을 편리하게 지원</p>
        <p>2023년 03월 05일</p>
        <button type="button">거절</button>
        <button type="button">동의</button>
      </li>
    </ul>
  </div>
  <div class="outTaskBox">
    <h1>요청한 업무</h1>
    <button type="button">업무 요청하기</button>
    <ul>
      <li class="border">
        <p>[최서연]회의록 작성 건</p>
        <p>2023년 03월 05일</p>
      </li>
    </ul>
  </div>
</div>

<div id="todoBoard">
  <div class="todoBoardListWrapper">
    <div class="todoBoardList">
      <div class="list-header">
        <div class="list-header-name">
          <p class="day">월</p>
        </div>
        <div class="list-header-add">
          <button class="addTodoBtn">할일 추가</button>
        </div>
      </div><br />
      <div class="list-content">
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">착수 발표</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행전</span>
            <span class="dutySttus">팀</span>
            <span class="toDoClosDate">2023-08-27 까지</span>
          </div>
        </a>
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">물리 ERD</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행완료</span>
            <span class="dutySttus">개인</span>
            <span class="toDoClosDate">오늘</span> <!--끝나는 날짜랑 오늘 날짜랑 겹치면 오늘 출력-->
          </div>
        </a>
      </div>
    </div>
    <div class="todoBoardList">
      <div class="list-header">
        <div class="list-header-name">
          <p class="day">화</p>
        </div>
        <div class="list-header-add">
          <button class="addTodoBtn">할일 추가</button>
        </div>
      </div><br />
      <div class="list-content">
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">착수 발표</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행전</span>
            <span class="dutySttus">팀</span>
            <span class="toDoClosDate">2023-08-27 까지</span>
          </div>
        </a>
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">물리 ERD</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행완료</span>
            <span class="dutySttus">개인</span>
            <span class="toDoClosDate">오늘</span> <!--끝나는 날짜랑 오늘 날짜랑 겹치면 오늘 출력-->
          </div>
        </a>
      </div>
    </div>
    <div class="todoBoardList">
      <div class="list-header">
        <div class="list-header-name">
          <p class="day">수</p>
        </div>
        <div class="list-header-add">
          <button class="addTodoBtn">할일 추가</button>
        </div>
      </div><br />
      <div class="list-content">
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">착수 발표</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행전</span>
            <span class="dutySttus">팀</span>
            <span class="toDoClosDate">2023-08-27 까지</span>
          </div>
        </a>
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">물리 ERD</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행완료</span>
            <span class="dutySttus">개인</span>
            <span class="toDoClosDate">오늘</span> <!--끝나는 날짜랑 오늘 날짜랑 겹치면 오늘 출력-->
          </div>
        </a>
      </div>
    </div>
    <div class="todoBoardList">
      <div class="list-header">
        <div class="list-header-name">
          <p class="day">목</p>
        </div>
        <div class="list-header-add">
          <button class="addTodoBtn">할일 추가</button>
        </div>
      </div><br />
      <div class="list-content">
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">착수 발표</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행전</span>
            <span class="dutySttus">팀</span>
            <span class="toDoClosDate">2023-08-27 까지</span>
          </div>
        </a>
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">물리 ERD</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행완료</span>
            <span class="dutySttus">개인</span>
            <span class="toDoClosDate">오늘</span> <!--끝나는 날짜랑 오늘 날짜랑 겹치면 오늘 출력-->
          </div>
        </a>
      </div>
    </div>
    <div class="todoBoardList">
      <div class="list-header">
        <div class="list-header-name">
          <p class="day">금</p>
        </div>
        <div class="list-header-add">
          <button class="addTodoBtn">할일 추가</button>
        </div>
      </div><br />
      <div class="list-content">
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">착수 발표</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행전</span>
            <span class="dutySttus">팀</span>
            <span class="toDoClosDate">2023-08-27 까지</span>
          </div>
        </a>
        <a href="#" class="todoCard">
          <div class="todoCard-title">
            <input type="checkbox" name="todoChk" class="todoChk">
            <span class="todoName">물리 ERD</span>
          </div>
          <div class="todoCard-info">
            <span class="dutyProgrs">진행완료</span>
            <span class="dutySttus">개인</span>
            <span class="toDoClosDate">오늘</span> <!--끝나는 날짜랑 오늘 날짜랑 겹치면 오늘 출력-->
          </div>
        </a>
      </div>
    </div>
  </div>
</div>
<br /><br/><br /> <!--- 아래의 목록 클릭했을 때 -->
<h1>업무 상세보기</h1>
<table border="1" style="width: 50%;">
  <colgroup>
    <col style="width: 50%">
  </colgroup>
  <tr>
    <th>업무 순번</th>
    <td class="seeTd">s</td>
    <td class="modifyTd"><input type="text" name="jobNO" id="jobNO4" readonly value="s"></td>
  </tr>
  <tr>
    <th>업무 번호</th>
    <td class="seeTd">11</td>
    <td class="modifyTd"><input type="text" name="jobProgrsSn" id="jobProgrsSn" readonly value="11"></td>
  </tr>
  <tr>
    <th>업무 요청자(업무 요청자가 나랑 같지않을때만 노출)</th>
    <td class="seeTd">최아리</td>
    <td class="modifyTd"><input type="text" name="modifyJobRecptnEmplId" id="modifyJobRecptnEmplId" readonly value="최아리"></td>
  </tr>
  <tr>
    <th>업무 기간</th>
    <td class="seeTd">2023-09-04 ~ 2023-09-05</td>
    <td class="modifyTd">
      <input type="date" name="modifyJobBeginDate" id="modifyJobBeginDate" value="2023-09-04">
      ~
      <input type="date" name="modifyJobEndDate" id="modifyJobEndDate" value="2023-09-05">
    </td>
  </tr>
  <tr>
    <th>업무 진행구분</th>
    <td class="seeTd">진행전</td>
    <td class="modifyTd">
      <input type="radio" name="commonDutySttus" id="$DUTY030">
      <label for="$DUTY030">진행전</label>
      <input type="radio" name="commonDutySttus" id="$DUTY031">
      <label for="$DUTY031">진행중</label>
      <input type="radio" name="commonDutySttus" id="$DUTY032">
      <label for="$DUTY032">진행완료</label>
    </td>
  </tr>
  <tr>
    <th>업무 상태구분</th>
    <td class="seeTd">승인</td>
    <td class="modifyTd"><input type="text" name="modifycommonCodeDutyProgrs" id="modifycommonCodeDutyProgrs" readonly value="승인"></td>
  </tr>
  <tr>
    <td colspan="2"><button id="modifyJobBtn">수정</button>
      <button id="updateJobBtn" style="display: none;">저장</button>
      <button id="cancelJobBtn">취소</button></td>
  </tr>
</table>
<br/><br />
<div id="Modal" style="display: none;">
  <button id="newJobBtn">신규 등록</button>
  <button id="requestJobBtn">요청 받은 업무 목록</button>
  <div id="writeTodo">
    <ul id="requestTodo" style="display:none;">
      <li>
        <input type="radio" id="jobNo1">
        요청한 사람 : "\${}" &nbsp; 업무 제목 : '\${}' &nbsp; 요청 날짜 : '\${}'
      </li>
      <li>
        <input type="radio" id="jobNo2">
        요청한 사람 : '\${}' &nbsp; 업무 제목 : '\${}' &nbsp; 요청 날짜 : '\${}'
      </li>
      <li>
        <input type="radio" id="jobNo3">
        요청한 사람 : '\${}' &nbsp; 업무 제목 :'\${}' &nbsp; 요청 날짜 :'\${}'
      </li>
    </ul>
    <form action="#">
      <table border="1" style="width: 50%">
        <tr>
          <th>업무 제목</th>
          <td>
            <input type="text" name="jobSj" id="jobSj">
          </td>
        </tr>
        <tr>
          <th>업무 내용</th>
          <td>
            <input type="text" name="jobCn" id="jobCn">
          </td>
        </tr>
        <tr>
          <th>업무 기간</th>
          <td>
            <input type="date" name="jobBeginDate" id="jobBeginDate">
            -
            <input type="date" name="jobClosDate" id="jobClosDate">
          </td>
        </tr>
        <tr>
          <th>업무 분류</th>
          <td>
            <input type="radio" name="commonDutyKind" id="DUTY010">
            <label for="DUTY010">회의</label>
            <input type="radio" name="commonDutyKind" id="DUTY011">
            <label for="DUTY011">개인</label>
            <input type="radio" name="commonDutyKind" id="DUTY012">
            <label for="DUTY012">팀</label>
            <input type="radio" name="commonDutyKind" id="DUTY013">
            <label for="DUTY013">교육</label>
            <input type="radio" name="commonDutyKind" id="DUTY014">
            <label for="DUTY014">기타</label>
          </td>
        </tr>
        <tr id="dutySttus">
          <th>업무 상태</th>
          <td>
            <input type="radio" name="commonDutySttus" id="DUTY030">
            <label for="DUTY030">진행전</label>
            <input type="radio" name="commonDutySttus" id="DUTY031">
            <label for="DUTY031">진행중</label>
            <input type="radio" name="commonDutySttus" id="DUTY032">
            <label for="DUTY032">진행완료</label>
          </td>
        </tr>
      </table>
      <button type="submit">등록</button>
      <button type="reset">취소</button>
    </form>
  </div>
</div>

<h1>들어온 업무 요청</h1>
<table></table>

<script>
  const newJobBtn = document.querySelector("#newJobBtn");
  const updateJobBtn = document.querySelector("#updateJobBtn");
  const requestJobBtn = document.querySelector("#requestJobBtn");
  const addTodoBtn = document.querySelectorAll(".addTodoBtn");
  const modifyTd = document.querySelectorAll(".modifyTd");
  const seeTd = document.querySelectorAll(".seeTd");
  modifyTd.forEach((item) => {
    item.style.display = "none";
  })
  modifyJobBtn.addEventListener("click",function(){
    modifyTd.forEach((item) => {
      item.style.display = "block";
    })
    seeTd.forEach((item) => {
      item.style.display = "none";
    })
    updateJobBtn.style.display = "inline-block";
    this.style.display = "none";

  })
  updateJobBtn.addEventListener("click",function(){
    modifyTd.forEach((item) => {
      item.style.display = "none";
    })
    seeTd.forEach((item) => {
      item.style.display = "block";
    })
    modifyJobBtn.style.display = "inline-block";
    this.style.display = "none";
  })
  newJobBtn.addEventListener("click",()=>{
    document.querySelector("#dutySttus").style.display = "block";
    document.querySelector("#requestTodo").style.display = "none";
  })
  requestJobBtn.addEventListener("click",() => {
    document.querySelector("#requestTodo").style.display = "block";
    document.querySelector("#dutySttus").style.display = "none";
  })
  addTodoBtn.forEach((item)=>{
    item.addEventListener("click",()=>{
      document.querySelector("#Modal").style.display = "block";
    })
  })
</script>