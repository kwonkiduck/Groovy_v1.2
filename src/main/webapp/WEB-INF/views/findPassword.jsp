<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 초기화</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/resources/favicon.svg">
</head>
<body>
<h1>비밀번호 초기화</h1>
<h2>사번을 입력해주세요</h2>

<form action="${pageContext.request.contextPath}/employee/findPassword" method="post">
    <label for="emplId">사번 <input type="text" name="emplId" id="emplId" ></label>
    <button>확인</button>
</form>

</body>
</html>