<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    private int cprCardResveSn;
    private Date cprCardResveBeginDate;
    private Date cprCardResveClosDate;


    private String cprCardNo;
    private String cprCardNm;
    private String cprCardResveEmplId;


    private String commonCodeResveAt;
    private String cprCardResveRturnAt;
    private String cprCardResveEmplNm;

    <main>
        <h1>법인카드 신청</h1>
        <div>
            <form action="${pageContext.request.contextPath}/card/request" method="post">
                <table border="1">
                    <input type="hidden" name="cprCardResveEmplId" value="${CustomUser.employeeVO.emplId}"/>
                    <input type="hidden" name="commonCodeResveAt" value="RESVE010"/>
                    <tr>
                        <th>기간</th>
                        <td>
                            <input type="date" name="cprCardResveBeginDate" id="startDay" placeholder="시작 날짜"> ~
                            <input type="date" name="cprCardResveClosDate" id="endDay" placeholder="끝 날짜">
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