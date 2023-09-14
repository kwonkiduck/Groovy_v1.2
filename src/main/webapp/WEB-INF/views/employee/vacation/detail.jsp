<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <h2>휴가 기록</h2>
    <table border="1">
        <tr>
            <td id="vacationId">${detailVO.yrycUseDtlsSn}</td>
            <td>${detailVO.yrycUseDtlsBeginDate} - ${detailVO.yrycUseDtlsEndDate}</td>
            <td>${detailVO.yrycUseDtlsRm}</td>
            <td>${detailVO.commonCodeYrycUseKind}</td>
            <td>${detailVO.commonCodeYrycUseSe}</td>
        </tr>
    </table>
    <c:choose>
        <c:when test="${empty detailVO.elctrnSanctnEtprCode}">
            <button type="button" id="modifyVacation">수정하기</button>
            <button type="button" id="startSanction">결재하기</button>
        </c:when>
        <c:otherwise>
            <!-- 결재 했을 때 옵션 추가 (목록으로 이런 거) -->
        </c:otherwise>
    </c:choose>
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
        window.open(`/sanction/write/DEPT010?format=\${param}`, "결재", "width = 1200, height = 1200")
    })

    function refreshParent() {
        window.location.reload(); // 새로고침
    }
</script>