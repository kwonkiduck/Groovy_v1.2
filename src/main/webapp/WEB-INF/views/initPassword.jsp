<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>초기 비밀번호 설정</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/resources/favicon.svg">
</head>
<body>
<h1>Welcome! 입사를 축하합니다</h1>
<h2>비밀번호를 설정해주세요</h2>

<form action="${pageContext.request.contextPath}/employee/initPassword" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <%--@declare id="memid"--%>
    <%--@declare id="mempassword"--%>
    <%--@declare id="passwordchk"--%>
    <label for="emplId">아이디</label>
    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.username" var="emplId"/>
        <input type="hidden" name="emplId" id="emplId" readonly value="${emplId}"><br/></sec:authorize>
    <br/>
    <label for="empPass">비밀번호</label>
    <input type="password" name="emplPassword" id="empPass"> <br/>
    <label for="passwordchk">비밀번호 확인</label>
    <input type="password" name="passwordchk" id="passwordchk"> <br/> <br/>
    <div class="skysky"></div>
    <button type="submit">비밀번호 설정하기</button>
</form>

</body>
</html>