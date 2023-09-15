<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 동작 위한 스타일 외엔(예: display:none 등) 전부 제가 작업하면서 편하게 보려고 임시로 먹인겁니다 ! --%>

<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<header>
    <h1><a href="${pageContext.request.contextPath}/card/manage">회사 카드 관리</a></h1>
    <h1><a href="${pageContext.request.contextPath}/card/reservationRecords">대여 내역 관리</a></h1>
</header>
<main>
    <div id="reservationRecords">
        <div id="recordGrid" class="ag-theme-alpine"></div>
    </div>
</main>
<script>

</script>