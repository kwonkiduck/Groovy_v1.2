<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<style>
    .file_box {
        border: 2px solid rgb(13 110 253 / 25%);
        border-radius: 10px;
        margin-top: 20px;
        padding: 40px;
        text-align: center;
    }
</style>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <div id="formCard">
        <div class="formHeader">
            <div class="btnWrap">
                <button id="getLine">결재선 지정</button>
                <div id="approvalLine">
                    <%@include file="../line/line.jsp" %>
                </div>
            </div>
            <br/>
            <div class="formTitle">
                    ${format.formatSj}
            </div>
        </div>
        <div class="approvalWrap">
            <div class="approval">
                <!--결재선 들어오는 영역-->

            </div>
            <div>

            </div>
        </div>
        <div class="formContent">
                ${format.formatCn}
        </div>
        <div>
            <input type="file" id="sanctionFile" style="width: 99%"/>
        </div>

        <button type="button" id="sanctionSubmit" disabled>결재 제출</button>
    </div>

    <script>
        let before = new Date();
        let year = before.getFullYear();
        let month = String(before.getMonth() + 1).padStart(2, '0');
        let day = String(before.getDate()).padStart(2, '0');

        let approver;
        let receiver;
        let referrer;

        const dept = "${dept}" // 문서 구분용

        const etprCode = "${etprCode}";
        const formatCode = "${format.commonCodeSanctnFormat}";
        const writer = "${CustomUser.employeeVO.emplId}"
        const today = year + '-' + month + '-' + day;
        const title = "${format.formatSj}";
        let content;
        let file = $('#sanctionFile')[0].files[0];
        let num = opener.$("#sanctionNum").text();

        $(document).ready(function () {
            $("#sanctionNo").html(etprCode);
            $("#writeDate").html(today);
            $("#writer").html("${CustomUser.employeeVO.emplNm}")
            console.log(dept)

            if (dept == 'DEPT011') {
                loadCardData()
            } else {
                loadVacationData()
            }
        });

        function loadVacationData() {
            $.ajax({
                url: `/vacation/loadData/\${num}`,
                type: "GET",
                success: function (data) {
                    console.log(data)
                    for (let key in data) {
                        if (data.hasOwnProperty(key)) {
                            let value = data[key];
                            let element = document.getElementById(key);
                            if (element) {
                                element.textContent = value;
                            }
                        }
                    }
                }
            })
        }

        function loadCardData() {
            $.ajax({
                url: `/card/data/\${num}`,
                type: "GET",
                success: function (data) {
                    console.log(data)
                    for (let key in data) {
                        if (data.hasOwnProperty(key)) {
                            let value = data[key];
                            let element = document.getElementById(key);
                            if (element) {
                                if (key === "cprCardUseExpectAmount") {
                                    value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원";
                                }
                                element.textContent = value;
                            }
                        }
                    }
                }
            })
        }

        $(".submitLine").on("click", function () {
            approver = $("#sanctionLine input[type=hidden]").map(function () {
                return $(this).val();
            }).get().reverse();
            referrer = $("#refrnLine input[type=hidden]").map(function () {
                return $(this).val();
            }).get();
            if (approver.length > 0) {
                $("#sanctionSubmit").prop("disabled", false);
            } else {
                $("#sanctionSubmit").prop("disabled", true);
            }
        })
        $("#sanctionSubmit").on("click", function () {
            updateStatus()
            content = $(".formContent").html();
            const jsonData = {
                approver: approver,
                receiver: receiver,
                referrer: referrer,
                etprCode: etprCode,
                formatCode: formatCode,
                writer: writer,
                today: today,
                title: title,
                content: content,
                vacationId: num,
            };

            if (dept === 'DEPT010') {
                const param = {
                    vacationId: num
                };
                const afterProcess = {
                    className: "kr.co.groovy.commute.CommuteService",
                    methodName: "insertCommuteByVacation",
                    parameters: param
                };
                jsonData.afterProcess = JSON.stringify(afterProcess);
            } else {
                const param = {
                    approveId: num,
                    state: 'YRYC032'
                };
                const afterProcess = {
                    className: "kr.co.groovy.card.CardService",
                    methodName: "modifyStatus",
                    parameters: param
                };
                jsonData.afterProcess = JSON.stringify(afterProcess);
            }
            $.ajax({
                url: "/sanction/api/sanction",
                type: "POST",
                data: JSON.stringify(jsonData),
                contentType: "application/json",
                success: function (data) {
                    console.log("결재 업로드 성공");

                    if (file != null) {
                        uploadFile();

                    } else {
                        closeWindow()
                    }
                },
                error: function (xhr) {
                    console.log("결재 업로드 실패");
                }
            });
        });

        // 결재 테이블 insert 후 첨부 파일 있다면 업로드 실행
        function uploadFile() {
            let form = $('#sanctionFile')[0].files[0];
            let formData = new FormData();
            formData.append('file', form);

            $.ajax({
                url: `/file/upload/sanction/\${etprCode}`,
                type: "POST",
                data: formData,
                contentType: false,
                processData: false,
                success: function (data) {
                    console.log("결재 파일 업로드 성공");
                    closeWindow()
                },
                error: function (xhr) {
                    console.log("결재 파일 업로드 실패");
                }
            });
        }

        // 문서의 결재 상태 변경
        function updateStatus() {
            let className;
            if (dept === 'DEPT011') {
                className = 'kr.co.groovy.card.CardService'
            } else {
                className = 'kr.co.groovy.vacation.VacationService'
            }
            let data = {
                className: className,
                methodName: 'modifyStatus',
                parameters: {
                    approveId: num,
                    state: 'YRYC031'
                }
            };
            $.ajax({
                url: `/sanction/api/reflection`,
                type: "POST",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function (data) {
                    alert("결재 상태 업데이트 성공");
                },
                error: function (xhr) {
                    alert("결재 상태 업데이트 실패");
                }
            });
        }

        function closeWindow() {
            alert("결재 상신이 완료되었습니다.")
            window.opener.refreshParent();
            window.close();
        }
    </script>
</sec:authorize>
