<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <a href="#"><p>내 휴가</p></a>
    <a href="/employee/salary"><p>내 급여</p></a>
</div>

<div>
    <p>휴가 기록</p>
    <label><input type="checkbox"/>반려 기록만 보기</label>
    <select id="yearSelect">
        <option value="all">전체</option>
        <option value="2023" selected>2023</option>
        <option value="2022">2022</option>
    </select>
</div>

<div>
    <c:choose>
        <c:when test="${empty vacationRecord}">
            <p>(휴가 내역이 존재하지 않습니다)</p>
        </c:when>
        <c:otherwise>
            <c:forEach items="${vacationRecord}" var="record">
                <p>${record}</p>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
