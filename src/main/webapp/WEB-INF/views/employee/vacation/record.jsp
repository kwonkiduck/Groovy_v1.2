<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <h2>휴가 기록</h2>
    <table border="1">
        <c:forEach var="recodeVO" items="${vacationRecord}" varStatus="stat">
            <tr>
                <td>${stat.count}</td>
                <td><a href="/vacation/detail/${recodeVO.yrycUseDtlsSn}">휴가 번호${recodeVO.yrycUseDtlsSn}</a></td>
                <td>${recodeVO.yrycUseDtlsBeginDate} - ${recodeVO.yrycUseDtlsEndDate}</td>
                <td>${recodeVO.commonCodeYrycUseKind}</td>
                <td>${recodeVO.commonCodeYrycUseSe}</td>
                <td>${recodeVO.elctrnSanctnEtprCode == null ? '미상신' : '상신'}</td>

            </tr>
        </c:forEach>
    </table>
</div>