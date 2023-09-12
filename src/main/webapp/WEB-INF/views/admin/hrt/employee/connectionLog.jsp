<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
<table border="1">
    <tr>
        <td>사번</td>
        <td>접속시간</td>
        <td>접속아이피</td>
        <td>맥addr일치여부</td>
    </tr>
    <c:forEach var="logVO" items="${logList}" varStatus="stat">
        <tr>
            <td>${logVO.emplId}</td>
            <td>${logVO.conectLogDate}</td>
            <td>${logVO.conectLogIp}</td>
            <td>${logVO.conectLogMacadrs == logVO.emplMacadrs ? "일치" : "불일치"}</td>
        </tr>
    </c:forEach>
</table>
</div>