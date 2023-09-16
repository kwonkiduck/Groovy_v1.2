<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <ul>
        <li><a href="${pageContext.request.contextPath}/vacation">내 휴가</a></li>
        <li><a href="${pageContext.request.contextPath}/salary">내 급여</a></li>
        <li><a href="${pageContext.request.contextPath}/vacation/record">휴가 기록</a></li>
    </ul>
</header>

<div>
    <div>
        <table>
            <tr>
                <th>발생 연차</th>
                <th>사용 연차</th>
                <th>잔여 연차</th>
            </tr>
            <tr>
                <th>${totalVacationCnt}</th>
                <th>${usedVacationCnt}</th>
                <th>${nowVacationCnt}</th>
            </tr>
        </table>
    </div>
    <div>
        <div>
            <div>
                <div><p>휴가 기록</p></div>
                <div><a href="${pageContext.request.contextPath}/vacation/request">휴가 신청</a></div>
            </div>
            <div id="myVacation">
                <ul>

                </ul>
            </div>
        </div>
        <div>
            <div><p>구성원의 휴가(연락금지)</p></div>
            <div id="memVacation">
                <ul>
                    <c:forEach items="${teamMemVacationList}" var="vacation">
                        <c:choose>
                            <c:when test="${vacation.yrycUseDtlsBeginDate == vacation.yrycUseDtlsEndDate}">
                                <li>
                                    <img src="${vacation.profileFileName}"/>
                                        ${vacation.yrycUseDtlsEmplNm} | ${vacation.commonCodeYrycUseKind} ${vacation.yrycUseDtlsBeginDate}
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li>
                                    <img src="${vacation.profileFileName}"/>
                                        ${vacation.yrycUseDtlsEmplNm} | ${vacation.commonCodeYrycUseKind} ${vacation.yrycUseDtlsBeginDate} ~ ${vacation.yrycUseDtlsEndDate}
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>