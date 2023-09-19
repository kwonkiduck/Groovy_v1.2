<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<a href="/pdf">문서 다운로드</a>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <div id="formCard">
        <div class="formHeader">
            <div class="btnWrap">
                <div id="myLine">
                    <hr>
                    <p>기안</p>
                    <p>${sanction.emplNm}</p>
                    <p><img src="/uploads/sign/${sanction.uploadFileStreNm}"/></p>
                    <p>${sanction.elctrnSanctnRecomDate}</p>
                    <p>${sanction.commonCodeSanctProgrs}</p>
                    <p>${sanction.commonCodeClsf}</p>
                    <hr>
                </div>
                <div id="approvalLine">
                    <p>결재선</p>

                    <c:forEach var="lineVO" items="${lineList}" varStatus="stat">
                        <c:choose>
                            <c:when test="${lineVO.commonCodeSanctProgrs == '반려'}">
                                <p>반려</p>
                            </c:when>
                            <c:when test="${lineVO.commonCodeSanctProgrs == '승인' }">
                                <p><img src="/uploads/sign/${lineVO.uploadFileStreNm}"/></p>
                            </c:when>
                            <c:otherwise>
                                <p>${lineVO.emplNm}</p>
                            </c:otherwise>
                        </c:choose>
                        <p>${lineVO.sanctnLineDate}</p>
                        <p>${lineVO.commonCodeSanctProgrs}</p>
                        <p>${lineVO.commonCodeClsf}</p>
                        <hr>
                    </c:forEach>

                    <c:forEach var="refrnVO" items="${refrnList}" varStatus="stat">
                        <p>참조</p>
                        <p>${refrnVO.emplNm} ${refrnVO.commonCodeDept} ${refrnVO.commonCodeClsf}</p>
                        <hr>
                    </c:forEach>
                </div>
            </div>
            <br/>
            <div class="formTitle">
                    ${sanction.elctrnSanctnSj}${sanction.elctrnSanctnAfterPrcs}
            </div>
        </div>
        <div class="formContent">
                ${sanction.elctrnSanctnDc}
        </div>
        <div class="formFile">
            <c:if test="${file != null}">
                <p><a href="/file/download/sanction?uploadFileSn=${file.uploadFileSn}">${file.uploadFileOrginlNm}</a>
                    <fmt:formatNumber value="${file.uploadFileSize / 1024.0}"
                                      type="number" minFractionDigits="1" maxFractionDigits="1"/> KB</p>
            </c:if>
        </div>
        <div id="returnResn">
            <c:forEach var="lineVO" items="${lineList}" varStatus="stat">
                <c:if test="${lineVO.sanctnLineReturnResn != null }">
                    <p>반려사유</p>
                    <p>${lineVO.emplNm}${lineVO.commonCodeClsf}</p>
                    <p>${lineVO.sanctnLineReturnResn}</p>
                </c:if>
            </c:forEach>
        </div>
        <div id="rejectModal" hidden="hidden">
            <textarea cols="50" rows="5" id="rejectReason"></textarea>
            <button type="button" id="confirmReject" onclick="submitReject()">확인</button>
        </div>

            <%-- 세션에 담긴 사번이 문서의 기안자 사번과 같고 결재 코드가 최초 상신 상태일 때--%>
        <c:if test="${CustomUser.employeeVO.emplId == sanction.elctrnSanctnDrftEmplId && sanction.commonCodeSanctProgrs == '상신' }">
            <button type="button" onclick="collect()">회수</button>
        </c:if>
        <c:forEach var="lineVO" items="${lineList}" varStatus="stat">
            <%-- 세션에 담긴 사번이 문서의 결재자 사번과 같고 결재 상태가 대기이며 결재의 상태가 반려가 아닌 경우--%>
            <c:if test="${ (CustomUser.employeeVO.emplId == lineVO.elctrnSanctnemplId)
                        && (lineVO.commonCodeSanctProgrs == '대기')
                        && (sanction.commonCodeSanctProgrs != '반려')
                        && (lineVO.elctrnSanctnFinalAt == 'N')}">
                <button type="button" onclick="approve(${lineVO.elctrnSanctnemplId})">승인</button>
                <button type="button" onclick="reject(${lineVO.elctrnSanctnemplId})">반려</button>
            </c:if>
            <c:if test="${ (CustomUser.employeeVO.emplId == lineVO.elctrnSanctnemplId)
                        && (lineVO.commonCodeSanctProgrs == '대기')
                        && (sanction.commonCodeSanctProgrs != '반려')
                        && (lineVO.elctrnSanctnFinalAt == 'Y')}">
                <button type="button" onclick="finalApprove(${lineVO.elctrnSanctnemplId})">최종승인</button>
                <button type="button" onclick="reject(${lineVO.elctrnSanctnemplId})">반려</button>
            </c:if>
        </c:forEach>
        <br><br>
        <button type="button" onclick="closeWindow()">닫기</button>
    </div>
    <script>
        let rejectReason;
        let rejectId;
        let etprCode = '${sanction.elctrnSanctnEtprCode}';
        let afterPrcs = '${sanction.elctrnSanctnAfterPrcs}'
        $(function () {

            console.log(afterPrcs);
        })

        function closeWindow() {
            window.close();
        }

        /* 승인 처리 */
        function approve(id) {
            console.log(id);
            $.ajax({
                url: `/sanction/api/approval/\${id}/\${etprCode}`,
                type: 'PUT',
                success: function (data) {
                    alert('승인 처리 성공')
                },
                error: function (xhr) {
                    alert('승인 처리 실패')
                }
            });
        }

        /* 최종 승인 처리 */
        function finalApprove(id) {
            console.log(id);
            $.ajax({
                url: `/sanction/api/final/approval/\${id}/\${etprCode}`,
                type: 'PUT',
                success: function (data) {
                    alert('최종 승인 처리 성공')
                    if (afterPrcs != null) {
                        afterFinalApprove();
                    }
                },
                error: function (xhr) {
                    alert('최종 승인 처리 실패')
                }
            });
        }

        /* 후처리 실행 */
        function afterFinalApprove() {
            $.ajax({
                url: `/sanction/api/reflection`,
                type: "POST",
                data: afterPrcs,
                contentType: "application/json",
                success: function (data) {
                    alert("후처리 실행(리플랙션) 성공");
                },
                error: function (xhr) {
                    alert("후처리 실행(리플랙션) 실패");
                }
            });
        }

        /* 반려 처리 */
        function reject(id) {
            rejectId = id;
            openRejectModal()
        }

        function openRejectModal() {
            $("#rejectModal").prop("hidden", false);
        }

        function submitReject() {
            rejectReason = $("#rejectReason").val()
            $.ajax({
                url: '/sanction/api/reject',
                type: 'PUT',
                data: {
                    elctrnSanctnemplId: rejectId,
                    sanctnLineReturnResn: rejectReason,
                    elctrnSanctnEtprCode: etprCode
                },
                success: function (data) {
                    alert('반려 처리 성공')
                },
                error: function (xhr) {
                    alert('반려 처리 실패')
                }
            });
        }

        /* 회수 처리 */
        function collect() {
            console.log(etprCode);
            $.ajax({
                url: `/sanction/api/collect/\${etprCode}`,
                type: 'PUT',
                success: function (data) {
                    alert('회수 처리 성공')
                },
                error: function (xhr) {
                    alert('회수 처리 실패')
                }
            });
        }
    </script>
</sec:authorize>