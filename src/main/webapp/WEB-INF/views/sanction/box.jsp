<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <div class="content-container">
        <h2>
            <a href="${pageContext.request.contextPath}/sanction/box">결재 요청</a>
            <a href="${pageContext.request.contextPath}/sanction/document">결재 문서</a>
        </h2> <br/><br/>

        <ul id="sanctionStatus">
            <li><span>기안한 결재</span> <a href="#"></a>건</li>
            <li><span>완료된 결재</span> <a href="#"></a>건</li>
            <li><span>반려된 결재</span> <a href="#"></a>건</li>
        </ul>
        <hr/>
        <br/>
        <h3>결재 목록</h3>
        <ul>
            <li><a href="${pageContext.request.contextPath}/sanction/write/DEPT010?format=SANCTN_FORMAT011">연차</a></li>

            <li><a href="${pageContext.request.contextPath}/sanction/write/DEPT010?format=SANCTN_FORMAT013">여름 휴가</a>
            </li>
            <li><a href="${pageContext.request.contextPath}/sanction/write/DEPT010?format=SANCTN_FORMAT013">생일</a></li>
            <li><a href="${pageContext.request.contextPath}/sanction/write/DEPT010?format=SANCTN_FORMAT013">결혼 -
                신혼여행</a>
            </li>
            <li><a href="${pageContext.request.contextPath}/sanction/write/DEPT010?format=SANCTN_FORMAT013">경조사</a></li>
            <li><a href="${pageContext.request.contextPath}/sanction/write/DEPT010?format=SANCTN_FORMAT013">병가</a></li>

            <li><a href="${pageContext.request.contextPath}/card/request">법인카드 신청</a></li>
        </ul>
    </div>
    <script>
        $(document).ready(function () {
            let commonCodeSanctProgrsValues = ["SANCTN010", "SANCTN016", "SANCTN015"];
            let results = [];

            function sendAjaxRequest(index) {
                $.ajax({
                    url: "/sanction/api/status",
                    type: "GET",
                    data: {
                        emplId: "${CustomUser.employeeVO.emplId}",
                        progrs: commonCodeSanctProgrsValues[index]
                    },
                    success: function (data) {
                        results.push(data);
                        if (index < commonCodeSanctProgrsValues.length - 1) {
                            sendAjaxRequest(index + 1);
                        } else {
                            handleResults(results);
                        }
                    }
                });
            }

            sendAjaxRequest(0);

            function handleResults(results) {
                let status = $("#sanctionStatus");
                for (let i = 0; i < 3; i++) { //
                    let $li = status.find("li:eq(" + i + ")");
                    let result = results[i]
                    $li.find("a").text(result);
                }
            }
        });
    </script>
</sec:authorize>