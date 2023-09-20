<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content-container">
    <div>
        <h2>휴가 기록</h2>
        <table border="1">
            <tr>
                <td id="sanctionNum">${detailVO.yrycUseDtlsSn}</td>
                <td>${detailVO.yrycUseDtlsBeginDate} - ${detailVO.yrycUseDtlsEndDate}</td>
                <td>${detailVO.yrycUseDtlsRm}</td>
                <td>${detailVO.commonCodeYrycUseKind}</td>
                <td>${detailVO.commonCodeYrycUseSe}</td>
                <td>${detailVO.commonCodeYrycState}</td>
            </tr>
        </table>
        <c:choose>
            <c:when test="${detailVO.commonCodeYrycState == '미상신'}">
                <button type="button" id="modifyVacation">수정하기</button>
                <button type="button" id="startSanction">결재하기</button>
            </c:when>
            <%--    결재 했을 때     --%>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/vacation/record">목록으로</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script>
    let param;
    let vacationKind = '${detailVO.commonCodeYrycUseKind}';
    if (vacationKind === '연차') {
        param = 'SANCTN_FORMAT011'
    } else {
        param = 'SANCTN_FORMAT012'
    }
    $("#startSanction").on("click", function () {
        $("#modifyVacation").prop("disabled", true)
        window.open(`/sanction/format/DEPT010/\${param}`, "결재", "width = 1200, height = 1200")
    })

    function refreshParent() {
        window.location.reload(); // 새로고침
    }
</script>