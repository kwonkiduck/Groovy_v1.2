<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <header>
        <ul>
            <li><a href="#">내 휴가</a></li>
            <li><a href="#">내 급여</a></li>
            <li><a href="#">휴가 기록</a></li>
        </ul>
    </header>
    <main>
        <h1>휴가 신청</h1>
        <div>
            <form action="/vacation/inputVacation" method="post">
                <table border="1">
                    <input type="hidden" name="yrycUseDtlsEmplId" value="${CustomUser.employeeVO.emplId}"/>
                        <%--                <tr>--%>
                        <%--                    <th>제목</th>--%>
                        <%--                    <td>--%>
                        <%--                        <input type="text" name="title" id="title" placeholder="제목">--%>
                        <%--                    </td>--%>
                        <%--                </tr>--%>
                    <tr>
                        <th>휴가 구분</th>
                        <td>
                            <input type="radio" name="commonCodeYrycUseKind" value="YRYC010" id="vacation1">
                            <label for="vacation1">연차</label>

                            <input type="radio" name="commonCodeYrycUseKind" value="YRYC011" id="vacation2">
                            <label for="vacation2">공가</label>

<%--                            <input type="radio" name="commonCodeYrycUseKind" value="YRYC011" id="vacation3">--%>
<%--                            <label for="vacation3">여름휴가</label>--%>

<%--                            <input type="radio" name="commonCodeYrycUseKind" value="YRYC011" id="vacation4">--%>
<%--                            <label for="vacation4">경사</label>--%>

<%--                            <input type="radio" name="commonCodeYrycUseKind" value="YRYC011" id="vacation5">--%>
<%--                            <label for="vacation5">조사</label>--%>

<%--                            <input type="radio" name="commonCodeYrycUseKind" value="YRYC011" id="vacation6">--%>
<%--                            <label for="vacation6">병가</label>--%>
                        </td>
                    </tr>
                    <tr>
                        <th>종류</th>
                        <td>
                            <input type="radio" name="commonCodeYrycUseSe" id="morning" value="YRYC020">
                            <label for="morning">오전 반차</label>
                            <input type="radio" name="commonCodeYrycUseSe" id="afternoon" value="YRYC021">
                            <label for="afternoon">오후 반차</label>
                            <input type="radio" name="commonCodeYrycUseSe" id="allDay" value="YRYC022">
                            <label for="allDay">종일</label>
                        </td>
                    </tr>
                    <tr>
                        <th>기간</th>
                        <td>
                            <input type="date" name="yrycUseDtlsBeginDate" id="startDay" placeholder="시작 날짜"> ~
                            <input type="date" name="yrycUseDtlsEndDate" id="endDay" placeholder="끝 날짜">
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                            <textarea name="yrycUseDtlsRm" id="content" cols="30" rows="10" placeholder="내용"></textarea>
                        </td>
                    </tr>
                </table>
                <button type="submit" id="save">저장하기</button>
            </form>
        </div>
    </main>
</sec:authorize>