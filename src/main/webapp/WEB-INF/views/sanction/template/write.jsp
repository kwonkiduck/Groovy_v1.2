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
<h2>
    <a href="#">결재 요청</a>
    <a href="#">결재 진행함</a>
    <a href="#">개인 문서함</a>
</h2> <br/><br/>

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
                    ${template.formatSj}
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
                ${template.formatCn}
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

        const etprCode = "${etprCode}";
        const formatCode = "${template.commonCodeSanctnFormat}";
        const writer = "${CustomUser.employeeVO.emplId}"
        const today = year + '-' + month + '-' + day;
        const title = "${template.formatSj}";
        let content;
        let file = $('#sanctionFile')[0].files[0];
        let vacationId = opener.$("#vacationId").text();


        $(document).ready(function () {
            $("#sanctionNo").html(etprCode);
            $("#writeDate").html(today);
            $("#writer").html(writer)

            $.ajax({
                url: `/vacation/loadData/\${vacationId}`,
                type: "GET",
                success: function (data) {
                    console.log(data)
                    for (var key in data) {
                        if (data.hasOwnProperty(key)) {
                            var value = data[key];
                            var element = document.getElementById(key);
                            if (element) {
                                element.textContent = value;
                            }
                        }
                    }
                }
            })
        });
        $(".submitLine").on("click", function () {
            approver = $("#sanctionLine input[type=hidden]").map(function () {
                return $(this).val();
            }).get().reverse();
            referrer = $("#refrnLine input[type=hidden]").map(function () {
                return $(this).val();
            }).get();
            console.log(file);
            if (approver.length > 0) {
                $("#sanctionSubmit").prop("disabled", false);
            } else {
                $("#sanctionSubmit").prop("disabled", true);
            }
        })
        $("#sanctionSubmit").on("click", function () {

            updateVacation()
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
                vacationId: vacationId
            };

            $.ajax({
                url: "/sanction/inputSanction",
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

        // 연차 테이블 updatq & 결재 테이블 insert 후 첨부 파일 있다면 업로드 실행
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

        function updateVacation() {
            let data = {
                approvalType: 'kr.co.groovy.sanction.AnnualLeaveService',
                methodName: 'afterApprove',
                parameters: {
                    approveId: vacationId,
                    elctrnSanctnEtprCode: etprCode
                }
            };
            $.ajax({
                url: `/sanction/startApprove`,
                type: "POST",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function (data) {
                    console.log("연차 테이블 업데이트 성공");
                },
                error: function (xhr) {
                    console.log("연차 테이블 업데이트 실패");
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
