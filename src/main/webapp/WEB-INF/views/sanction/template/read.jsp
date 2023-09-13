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
<button>문서 다운로드</button>
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
                            <c:when test="${lineVO.commonCodeSanctProgrs != '반려' && lineVO.commonCodeSanctProgrs != '승인' }">
                                <p>${lineVO.emplNm}</p>
                            </c:when>
                            <c:otherwise>
                                <p><img src="/uploads/sign/${lineVO.uploadFileStreNm}"/></p>
                            </c:otherwise>
                        </c:choose>
                        <p><img src="/uploads/sign/${lineVO.uploadFileStreNm}"/></p>
                        <p>${lineVO.sanctnLineDate}</p>
                        <p>${lineVO.commonCodeSanctProgrs}</p>
                        <p>${lineVO.commonCodeClsf}</p>
                        <p>${lineVO.elctrnSanctnemplId}</p>
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
                    ${sanction.elctrnSanctnSj}
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
            <button type="button" onclick="collect(${sanction.elctrnSanctnEtprCode})">회수</button>
        </c:if>
        <c:forEach var="lineVO" items="${lineList}" varStatus="stat">
            <%-- 세션에 담긴 사번이 문서의 결재자 사번과 같고 결재 상태가 대기이며 결재의 상태가 반려가 아닌 경우--%>
            <c:if test="${ (CustomUser.employeeVO.emplId == lineVO.elctrnSanctnemplId)
                        && (lineVO.commonCodeSanctProgrs == '대기')
                        && (sanction.commonCodeSanctProgrs != '반려')}">
                <button type="button" onclick="approve(${lineVO.elctrnSanctnemplId})">승인</button>
                <button type="button" onclick="reject(${lineVO.elctrnSanctnemplId})">반려</button>
            </c:if>
        </c:forEach>
<br><br>
        <button type="button" onclick="closeWindow()">닫기</button>
    </div>
    <script>
        let rejectReason;
        let rejectId;

        function closeWindow(){
            window.close();
        }

        /* 승인 처리 */
        function approve(id) {
            console.log(id);
            $.ajax({
                url: "/sanction/approve",
                type: "POST",
                data: {elctrnSanctnemplId: id},
                success: function (data) {
                    console.log('승인 처리 성공')
                },
                error: function (xhr) {
                    console.log('승인 처리 실패')
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
                url: "/sanction/reject",
                type: "POST",
                data: {
                    elctrnSanctnemplId: rejectId,
                    sanctnLineReturnResn: rejectReason
                },
                success: function (data) {
                    console.log('반려 처리 성공')
                },
                error: function (xhr) {
                    console.log('반려 처리 실패')
                }
            });
        }

        /* 회수 처리 */
        function collect(code) {
            console.log(code);
            $.ajax({
                url: "/sanction/collect",
                type: "POST",
                data: {elctrnSanctnEtprCode: code},
                success: function (data) {
                    console.log('회수 처리 성공')
                },
                error: function (xhr) {
                    console.log('회수 처리 실패')
                }
            });
        }
    </script>
</sec:authorize>