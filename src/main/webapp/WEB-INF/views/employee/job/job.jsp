<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .border {
        border: 1px solid #333333;
        display: flex;
        gap: 24px;
    }

    .orgBorder {
        border: 1px solid #333333;
        width: 100%;
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

    #modal {
        width: 30%;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        border: 1px solid red;
    }
    .modal-container{
        width: 100%;
    }
    .modal-header {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .modal-body{
        display: flex;
        width: 100%;
    }
    .form-data-list {
        display: flex;
        flex-direction: column;
    }
    .modal-body > ul {
        padding: 0 24px;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    form {
        width: 100%;
    }
    .input-date, .date {
        display: flex;
        gap: 12px;
    }
    .date > div {
        flex: 1;
    }
    .input-date > input {
        flex: 1;
    }
    .modal-footer {
        display: flex;
        justify-content: center;
    }
    .modal-footer > button {
        width: 40%;
        padding: 10px;
    }
    .modal-common, .modal-option {
        display: none;
    }
    .modal-common.on, .modal-option.on {
        display: block;
    }
    .state-list,.tab-list {
        list-style: none;
        display: flex;
        gap: 12px;
    }
    .head {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .data-box {
        border: 1px solid black;
        padding: 12px;
    }
</style>

<a href="#">할 일</a>
<a href="/job/jobDiary">업무 일지</a>

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

<button class="receiveJob">스마트 홈 시스템 확장,인공지능 비서가 집안 생활을 편리하게 지원</button> <br />
<div id="requestJobDetailContainer">
    <button class="requestJobDetail">요청한 업무 [최서연] 회의록 작성 건</button><br /><br />
</div>
<button class="requestJob">업무 요청하기</button><br />
<button class="addJob">+</button>
<button class="myjob">등록된 업무</button>
<div id="modal">
    <div class="modal-container">
        <div id="modal-receive-job" class="modal-common">
            <div class="modal-header">
                <h4><i class="icon icon-idea"></i>들어온 업무 요청</h4>
                <button class="close">&times;</button>
            </div>
            <div class="modal-body">
                <ul>
                    <li class="form-data-list">
                        <h5>📚 업무 제목</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5>✅ 업무 내용</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5>📅 업무 기간</h5>
                        <div>
                            <div class="data-box">
                                <p></p>
                            </div>
                            <div class="data-box">
                                <p></p>
                            </div>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">💭 업무 분류</h5>
                        <div class="input-data">
                            <input type="radio" name="" id="">
                            <label for="">회의</label>
                            <input type="radio" name="" id="">
                            <label for="">팀</label>
                            <input type="radio" name="" id="">
                            <label for="">개인</label>
                            <input type="radio" name="" id="">
                            <label for="">교육</label>
                            <input type="radio" name="" id="">
                            <label for="">기타</label>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">🔥 업무 상태</h5>
                        <div class="input-data">
                            <input type="radio" name="" id="">
                            <label for="">업무 전</label>
                            <input type="radio" name="" id="">
                            <label for="">업무 중</label>
                            <input type="radio" name="" id="">
                            <label for="">업무 완료</label>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">💌 보낸 사람</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="modal-footer">
                <button id="reject">거절</button>
                <button id="agree">승인</button>
            </div>
        </div>

        <!-- 업무 요청하기 -->
        <div id="modal-request-job" class="modal-common">
            <div class="modal-header">
                <h4><i class="icon icon-idea"></i>업무 요청하기</h4>
                <button class="close">&times;</button>
            </div>
            <div class="modal-body">
                <form id="requestJob" method="post">
                    <ul>
                        <li class="form-data-list">
                            <label for="jobSj">📚 업무 제목</label>
                            <input type="text" name="jobSj" id="jobSj" placeholder="업무 제목을 입력하세요.">
                        </li>
                        <li class="form-data-list">
                            <label for="jobCn">✅ 업무 내용</label>
                            <input type="text" name="jobCn" id="jobCn" placeholder="업무 내용을 입력하세요.">
                        </li>
                        <li class="form-data-list">
                            <label>📅 업무 기간</label>
                            <div class="input-date">
                                <input type="date" name="jobBeginDate" id="jobBeginDate" onchange="validateDate()" placeholder="시작 날짜">
                                ~
                                <input type="date" name="jobClosDate" id="jobClosDate" onchange="validateDate()" placeholder="끝 날짜">
                            </div>
                        </li>
                        <li class="form-data-list">
                            <label>💭 업무 분류</label>
                            <div class="input-data">
                                <input type="radio" name="commonCodeDutyKind" id="meeting" value="DUTY010" />
                                <label for="">회의</label>
                                <input type="radio" name="commonCodeDutyKind" id="team" value="DUTY012" />
                                <label for="">팀</label>
                                <input type="radio" name="commonCodeDutyKind" id="personal" value="DUTY011" />
                                <label for="">개인</label>
                                <input type="radio" name="commonCodeDutyKind" id="edu" value="DUTY013" />
                                <label for="">교육</label>
                                <input type="radio" name="commonCodeDutyKind" id="etc" value="DUTY014" />
                                <label for="">기타</label>
                            </div>
                        </li>
                        <li class="form-data-list">
                            <label>🔥 업무 진행</label>
                            <div class="input-data">
                                <input type="radio" name="commonCodeDutyProgrs" id="DUTY030" value="DUTY030">
                                <label for="DUTY030">업무 전</label>
                                <input type="radio" name="commonCodeDutyProgrs" id="DUTY031" value="DUTY031">
                                <label for="DUTY031">업무 중</label>
                                <input type="radio" name="commonCodeDutyProgrs" id="DUTY032" value="DUTY032">
                                <label for="DUTY032">업무 완료</label>
                            </div>
                        </li>
                        <li class="form-data-list">
                            <label for="" style="display: inline-block;">💌 받는 사람</label>
                            <button type="button" id="orgBtn">조직도</button>
                            <label for="receive" style="width: 100%">

                                <div id="receive" style="border: 1px solid #333; height: 50px; border-radius: 50px">
                                </div>
                                <div id="orgChart"></div>
                            </label>
                        </li>
                    </ul>
                </form>
            </div>
            <div class="modal-footer">
                <button class="close">취소</button>
                <button type="submit" id="request">요청</button>
            </div>
        </div>
        <!-- 업무 요청하기 -->
        <div id="modal-requestDetail-job" class="modal-common">
            <div class="modal-header">
                <h4><i class="icon icon-idea"></i>업무 요청하기(상세)</h4>
                <button class="close">&times;</button>
            </div>
            <div class="modal-body">
                <ul>
                    <li class="form-data-list">
                        <h5>📚 업무 제목</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5>✅ 업무 내용</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5>📅 업무 기간</h5>
                        <div class="date">
                            <div class="data-box">
                                <p></p>
                            </div>
                            <div class="data-box">
                                <p></p>
                            </div>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">💭 업무 분류</h5>
                        <div class="input-data">
                            <input type="radio" name="" id="">
                            <label for="">회의</label>
                            <input type="radio" name="" id="">
                            <label for="">팀</label>
                            <input type="radio" name="" id="">
                            <label for="">개인</label>
                            <input type="radio" name="" id="">
                            <label for="">교육</label>
                            <input type="radio" name="" id="">
                            <label for="">기타</label>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">🔥 업무 상태</h5>
                        <div class="input-data">
                            <input type="radio" name="" id="">
                            <label for="">업무 전</label>
                            <input type="radio" name="" id="">
                            <label for="">업무 중</label>
                            <input type="radio" name="" id="">
                            <label for="">업무 완료</label>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <div class="head">
                            <h5>💌 받는 사람</h5>
                            <ul class="state-list">
                                <li>대기</li>
                                <li>승인</li>
                                <li>거절</li>
                            </ul>
                        </div>
                        <div class="data-box">
                            <p></p>
                        </div>

                    </li>
                </ul>
            </div>
            <div class="modal-footer">
                <button class="close">확인</button>
            </div>
        </div>
        <div id="modal-newJob" class="modal-common">
            <div class="modal-header">
                <h4><i class="icon icon-idea"></i>업무 등록</h4>
                <button class="close">&times;</button>
            </div>
            <div class="modal-tab">
                <ul class="tab-list">
                    <li>
                        <button id="tab-new-job">신규 등록</button>
                    </li>
                    <li>
                        <button id="tab-new-request">요청 받은 업무 목록</button>
                    </li>
                </ul>
            </div>
            <div class="modal-body">
                <div class="modal-content">
                    <form action="" id="registJob">
                        <div class="modal-option" data-target="tab-new-job">
                            <ul>
                                <li class="form-data-list">
                                    <label for="">📚 업무 제목</label>
                                    <input type="text" name="" id="" placeholder="업무 제목을 입력하세요.">
                                </li>
                                <li class="form-data-list">
                                    <label for="">✅ 업무 내용</label>
                                    <input type="text" name="" id="" placeholder="업무 내용을 입력하세요.">
                                </li>
                                <li class="form-data-list">
                                    <label for="">📅 업무 기간</label>
                                    <div class="input-date">
                                        <input type="date" name="" id="" placeholder="시작 날짜">
                                        ~
                                        <input type="date" name="" id="" placeholder="끝 날짜">
                                    </div>
                                </li>
                                <li class="form-data-list">
                                    <label for="">💭 업무 분류</label>
                                    <div class="input-data">
                                        <input type="radio" name="" id="">
                                        <label for="">회의</label>
                                        <input type="radio" name="" id="">
                                        <label for="">팀</label>
                                        <input type="radio" name="" id="">
                                        <label for="">개인</label>
                                        <input type="radio" name="" id="">
                                        <label for="">교육</label>
                                        <input type="radio" name="" id="">
                                        <label for="">기타</label>
                                    </div>
                                </li>
                                <li class="form-data-list">
                                    <label for="">🔥 업무 상태</label>
                                    <div class="input-data">
                                        <input type="radio" name="" id="">
                                        <label for="">업무 전</label>
                                        <input type="radio" name="" id="">
                                        <label for="">업무 중</label>
                                        <input type="radio" name="" id="">
                                        <label for="">업무 완료</label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="modal-option on" data-target="tab-new-request">
                            <div class="request-list-wrap">
                                <ul>
                                    <li class="request-list">
                                        <span class="name">이혜진 | </span>
                                        <span class="content">스마트 홈 시스템 확장,인공지능 비서가 집안 생활을 편리하게 지원</span>
                                        <span class="requestDate">2023년 03월 05일</span>
                                    </li>
                                    <li class="request-list">
                                        <span class="name">강서주 | </span>
                                        <span class="content">스마트 홈 시스템 확장,인공지능 비서가 집안 생활을 편리하게 지원</span>
                                        <span class="requestDate">2023년 03월 05일</span>
                                    </li>
                                </ul>
                            </div>
                            <ul>
                                <li class="form-data-list">
                                    <label for="">📚 업무 제목</label>
                                    <input type="text" name="" id="" placeholder="업무 제목을 입력하세요.">
                                </li>
                                <li class="form-data-list">
                                    <label for="">✅ 업무 내용</label>
                                    <input type="text" name="" id="" placeholder="업무 내용을 입력하세요.">
                                </li>
                                <li class="form-data-list">
                                    <label for="">📅 업무 기간</label>
                                    <div class="input-date">
                                        <input type="date" name="" id="" placeholder="시작 날짜">
                                        ~
                                        <input type="date" name="" id="" placeholder="끝 날짜">
                                    </div>
                                </li>
                                <li class="form-data-list">
                                    <label for="">💭 업무 분류</label>
                                    <div class="input-data">
                                        <input type="radio" name="" id="">
                                        <label for="">회의</label>
                                        <input type="radio" name="" id="">
                                        <label for="">팀</label>
                                        <input type="radio" name="" id="">
                                        <label for="">개인</label>
                                        <input type="radio" name="" id="">
                                        <label for="">교육</label>
                                        <input type="radio" name="" id="">
                                        <label for="">기타</label>
                                    </div>
                                </li>
                                <li class="form-data-list">
                                    <label for="">🔥 업무 상태</label>
                                    <div class="input-data">
                                        <input type="radio" name="" id="">
                                        <label for="">업무 전</label>
                                        <input type="radio" name="" id="">
                                        <label for="">업무 중</label>
                                        <input type="radio" name="" id="">
                                        <label for="">업무 완료</label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button class="close">취소</button>
                <button class="regist">등록</button>
            </div>

        </div>
        <div id="modal-job-detail" class="modal-common" >
            <div class="modal-header">
                <h4><i class="icon icon-idea"></i>업무 상세</h4>
                <button class="close">&times;</button>
            </div>
            <div class="modal-body">
                <ul>
                    <li class="form-data-list">
                        <h5>📚 업무 제목</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5>✅ 업무 내용</h5>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5>📅 업무 기간</h5>
                        <div class="date">
                            <div class="data-box">
                                <p></p>
                            </div>
                            <div class="data-box">
                                <p></p>
                            </div>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">💭 업무 분류</h5>
                        <div class="input-data">
                            <input type="radio" name="" id="">
                            <label for="">회의</label>
                            <input type="radio" name="" id="">
                            <label for="">팀</label>
                            <input type="radio" name="" id="">
                            <label for="">개인</label>
                            <input type="radio" name="" id="">
                            <label for="">교육</label>
                            <input type="radio" name="" id="">
                            <label for="">기타</label>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <h5 for="">🔥 업무 상태</h5>
                        <div class="input-data">
                            <input type="radio" name="" id="">
                            <label for="">업무 전</label>
                            <input type="radio" name="" id="">
                            <label for="">업무 중</label>
                            <input type="radio" name="" id="">
                            <label for="">업무 완료</label>
                        </div>
                    </li>
                    <li class="form-data-list">
                        <div class="head">
                            <h5>💌 보낸 사람</h5>
                        </div>
                        <div class="data-box">
                            <p></p>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="modal-footer">
                <button class="modify">수정 </button>
                <button class="close">확인</button>
            </div>
        </div>
    </div>
</div>
<script src="/resources/js/orgChart.js"></script>
<script src="/resources/js/job.js"></script>