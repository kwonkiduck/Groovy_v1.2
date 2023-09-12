<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .toggle {
        position: relative;
        display: inline-block;
        width: 60px;
        height: 34px;
    }

    .toggle input {
        display: none;
    }

    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        transition: 0.4s;
        border-radius: 34px;
    }

    .slider:before {
        position: absolute;
        content: "";
        height: 26px;
        width: 26px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        transition: 0.4s;
        border-radius: 50%;
    }

    input:checked + .slider {
        background-color: #2196F3;
    }

    input:checked + .slider:before {
        transform: translateX(26px);
    }
</style>

<h2>내 정보 관리</h2>
<h3>프로필 변경</h3>
<p>프로필 사진을 변경합니다.</p>
<label for="empProflPhotoFile">사진</label> <!-- 톱니 모양 -->
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <p>${CustomUser.employeeVO.notificationVO.dutyRequest}</p>
    <img id="profileImage"
         src="${pageContext.request.contextPath}/uploads/profile/${CustomUser.employeeVO.proflPhotoFileStreNm}"
         alt="profileImage"/>


    <form id="profileForm" method="POST" enctype="multipart/form-data">
            <%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>
        <input type="text" name="emplId" id="emplId" readonly
               value="${CustomUser.employeeVO.emplId}"><br/>
            <%--style="display: none;"--%>
        <input type="file" name="profileFile" id="empProflPhotoFile"/>
        <button type="reset" id="pCancel">취소</button>
        <button type="button" id="pSave">저장</button>
    </form>


    <hr/>
    <h2>내 정보 관리</h2>
    <h3>비밀번호 변경</h3>
    <form method="post" id="passForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <label for="emplPassword">현재 비밀번호 입력</label>
        <input type="password" name="currentPassword" id="emplPassword" placeholder="현재 비밀번호를 입력하세요."/>
        <label for="emplPasswordCheck1">새로운 비밀번호 입력</label>
        <input type="password" name="emplPassword" id="emplPasswordCheck1" placeholder="새로운 비밀번호를 입력하세요."/>
        <input type="password" name="reEmplPassword" placeholder="새로운 비밀번호를 입력하세요."/>
        <input type="hidden" name="emplId" readonly value="${CustomUser.employeeVO.emplId}"><br/>
        <button type="reset" id="iCancel">취소</button>
        <button type="button" id="iSave">저장</button>
    </form>


    <hr/>
    <h2>내 정보 관리</h2>
    <h3>서명 설정/변경</h3>
    <p>전자결재에 필요한 서명을 설정 · 변경합니다.</p>
    <div id="emplSignFilePreview"></div>
    <!-- 미리보기 -->
    <img id="userSignProfile"
         src="${pageContext.request.contextPath}/uploads/sign/${CustomUser.employeeVO.signPhotoFileStreNm}"
         alt="signImage"/>
    <p>서명</p>
    <label for="emplSignFile">등록</label> <!-- 등록 버튼 -->

    <form id="signForm" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="text" name="emplId" readonly
               value="${CustomUser.employeeVO.emplId}"><br/>
        <input type="file" name="signPhotoFile" id="emplSignFile"/>
        <button type="button">삭제</button>
        <button type="reset" id="sCancel">취소</button>
        <button type="button" id="sSave">저장</button>
    </form>
    <hr/>

    <form action="#">
        <h3>알림 설정</h3>
        <p>알림 범위를 설정합니다.</p>
        <!-- 각 요소의 id, for 임시로 넣어 놓음 -->
        <div>
            <p>업무 요청</p>
            <label class="toggle" for="dutyRequest">
                <input type="checkbox" id="dutyRequest" name="dutyRequest"
                       value="${CustomUser.employeeVO.notificationVO.dutyRequest}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>댓글</p>
            <label class="toggle" for="answer">
                <input type="checkbox" id="answer" name="answer" value="${CustomUser.employeeVO.notificationVO.answer}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>팀 커뮤니티</p>
            <label class="toggle" for="teamNotice">
                <input type="checkbox" id="teamNotice" name="teamNotice"
                       value="${CustomUser.employeeVO.notificationVO.teamNotice}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>공지사항</p>
            <label class="toggle" for="companyNotice">
                <input type="checkbox" id="companyNotice" name="companyNotice"
                       value="${CustomUser.employeeVO.notificationVO.companyNotice}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>일정</p>
            <label class="toggle" for="schedule">
                <input type="checkbox" id="schedule" name="schedule"
                       value="${CustomUser.employeeVO.notificationVO.schedule}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>채팅 방 개설 알림</p>
            <label class="toggle" for="newChattingRoom">
                <input type="checkbox" id="newChattingRoom" name="newChattingRoom"
                       value="${CustomUser.employeeVO.notificationVO.newChattingRoom}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>메일 수신 알림</p>
            <label class="toggle" for="emailReception">
                <input type="checkbox" id="emailReception" name="emailReception"
                       value="${CustomUser.employeeVO.notificationVO.emailReception}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>전자결재수신</p>
            <label class="toggle" for="electronSanctionReception">
                <input type="checkbox" id="electronSanctionReception" name="electronSanctionReception"
                       value="${CustomUser.employeeVO.notificationVO.electronSanctionReception}">
                <span class="slider"></span>
            </label>
        </div>
        <div>
            <p>전자결재결과</p>
            <label class="toggle" for="electronSanctionResult">
                <input type="checkbox" id="electronSanctionResult" name="electronSanctionResult"
                       value="${CustomUser.employeeVO.notificationVO.electronSanctionResult}">
                <span class="slider"></span>
            </label>
        </div>


        <button type="button">취소</button>
        <button type="button" onclick="saveNotificationSettings()">저장</button>
    </form>
</sec:authorize>
<script>
    $(document).ready(function () {
        initializeCheckboxes();

        // 프로필 사진 수정
        $("#pSave").on("click", function () {
            var formData = new FormData($("#profileForm")[0]);
            $.ajax({
                type: "POST",
                url: "/employee/modifyProfile",
                data: formData,
                contentType: false,
                processData: false,
                cache: false,
                success: function (response) {
                    console.log("프로필 사진 수정 성공", response);
                    var newImageUrl = "/uploads/profile/" + response;
                    $("#profileImage").attr("src", newImageUrl)
                    $("#asideProfile").attr("src", newImageUrl)
                },
                error: function (xhr, textStatus, error) {
                    console.log("AJAX 오류:", error);
                }
            });
        });
        // 패스워드 변경
        $("#iSave").on("click", function () {
            var formData = new FormData($("#passForm")[0]);
            $.ajax({
                type: "POST",
                url: "/employee/modifyPassword",
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    console.log("비밀번호 수정 성공");
                },
                error: function (xhr, textStatus, error) {
                    console.log("AJAX 오류:", error);
                }
            });
        });

        // 서명 사진 수정
        $("#sSave").on("click", function () {
            var formData = new FormData($("#signForm")[0]);
            $.ajax({
                type: "POST",
                url: "/employee/modifySign",
                data: formData,
                contentType: false,
                processData: false,
                cache: false,
                success: function (response) {
                    console.log("서명 사진 수정 성공");
                    var newImageUrl = "/uploads/sign/" + response;
                    $("#userSignProfile").attr("src", newImageUrl)
                },
                error: function (xhr, textStatus, error) {
                    console.log("AJAX 오류:", error);
                }
            });
        });
    });


    // 초기 체크 상태 설정
    function initializeCheckboxes() {
        const checkboxIds = ["dutyRequest", "answer", "teamNotice", "companyNotice", "schedule", "newChattingRoom", "emailReception", "electronSanctionReception", "electronSanctionResult"];

        checkboxIds.forEach(function (checkboxId) {
            const checkbox = document.getElementById(checkboxId);
            const value = checkbox.value;
            if (value === "NTCN_AT010") {
                checkbox.checked = true;
            } else {
                checkbox.checked = false;
            }
        });
    }

    function saveNotificationSettings() {
        const notificationSettings = {};
        const checkboxIds = ["dutyRequest", "answer", "teamNotice", "companyNotice", "schedule", "newChattingRoom", "emailReception", "electronSanctionReception", "electronSanctionResult"];

        checkboxIds.forEach(function (checkboxId) {
            const checkbox = document.getElementById(checkboxId);
            notificationSettings[checkboxId] = checkbox.checked ? "NTCN_AT010" : "NTCN_AT011";
        });

        $.ajax({
            url: `/employee/modifyNoticeAt/${CustomUser.employeeVO.emplId}`,
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(notificationSettings),
            success: function (data) {
                console.log("알림 설정 성공");
            },
            error: function (xhr, textStatus, error) {
                console.log("AJAX 오류:", error);
            }
        });
    }
</script>
