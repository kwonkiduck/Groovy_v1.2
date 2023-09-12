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
                <div id="myLine">
                    <p>${sanction.emplNm}</p>
                    <p><img src="/uploads/sign/${sanction.uploadFileStreNm}"/></p>
                    <p>${sanction.elctrnSanctnRecomDate}</p>
                    <p>${sanction.commonCodeSanctProgrs}</p>
                    <p>${sanction.commonCodeClsf}</p>
                    <hr>
                </div>
                <div id="approvalLine">
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
        <br/><br/>

        <div id="rejectModal" hidden="hidden">
            <textarea cols="50" rows="50" id="rejectReason"></textarea>
            <button type="button">확인</button>
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

        <button type="button">닫기</button>
    </div>
    <script>
        let rejectReason;

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

        function reject(id) {
            openRejectModal()
            rejectReason = ("#rejectReason").var()
            $.ajax({
                url: "/sanction/reject",
                type: "POST",
                data: {
                    elctrnSanctnemplId: id,
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

        function openRejectModal() {
            $("#rejectModal").prop("hidden", false);
        }

    </script>
</sec:authorize>


<%--            &lt;%&ndash; 세션에 담긴 사번이 문서의 결재자 사번과 같고 결재 상태가 대기이며 결재자가 최종 승인자인 경우&ndash;%&gt;--%>
<%--            <c:if test="${ (CustomUser.employeeVO.emplId == lineVO.elctrnSanctnemplId)--%>
<%--                        && (lineVO.commonCodeSanctProgrs == '대기')--%>
<%--                        && (sanction.commonCodeSanctProgrs != '반려')}">--%>
<%--                <button type="button" onclick="finalApprove()">승인</button>--%>
<%--                <button type="button" onclick="reject()">반려</button>--%>
<%--            </c:if>--%>
<%--            &lt;%&ndash; 세션에 담긴 사번이 문서의 결재자 사번과 같고 결재 상태가 예정인 경우&ndash;%&gt;--%>
<%--            <c:if test="${CustomUser.employeeVO.emplId == lineVO.elctrnSanctnemplId && lineVO.commonCodeSanctProgrs == '예정' }">--%>
<%--                <button type="button">닫기</button>--%>
<%--            </c:if>--%>
<%--            &lt;%&ndash; 세션에 담긴 사번이 문서의 기안자 사번과 같고 결재가 이미 진행된 경우&ndash;%&gt;--%>
<%--        <c:if test="${CustomUser.employeeVO.emplId == sanction.elctrnSanctnDrftEmplId && sanction.commonCodeSanctProgrs != '상신' }">--%>
<%--            <button type="button">회수</button>--%>
<%--        </c:if>--%>