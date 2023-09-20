<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
    #myGrid {
        width: 100%;
        height: calc((360 / 1080) * 100vh);
    }
</style>
<div class="content-container">
    <h1 class="tab">기본 급여 및 공제 관리</h1>
    <br/><br/>
    <h2>급여 기본 설정</h2>
    <button id="saveSalary">저장하기</button>
    <%--<div id="myGrid" class="ag-theme-alpine"></div>--%>

    <%--<br/>--%>
    <table border=" 1">
        <tr>
            <td>(만원)</td>
            <td>사원</td>
            <td>대리</td>
            <td>과장</td>
            <td>차장</td>
            <td>팀장</td>
            <td>부장</td>
        </tr>
        <c:forEach var="salaryItem" items="${salary}" varStatus="salaryStat">
            <tr>
                <td>${salaryItem.commonCodeDeptCrsf}</td>
                <c:forEach var="bonusItem" items="${bonus}">
                    <c:set var="total" value="${salaryItem.anslryAllwnc + bonusItem.anslryAllwnc}"/>
                    <td>${total.toString().substring(0, 4)}</td>
                </c:forEach>
            </tr>
        </c:forEach>
    </table>
    <hr/>
    <br/>


    <h2>소득세 설정</h2>
    <form action="#">
        <button id="saveIncmtax" type="button">저장하기</button>
        <table border=" 1">
            <c:forEach var="tariffVO" items="${tariffList}" varStatus="stat">
                <c:if test="${tariffVO.taratStdrNm == '소득세' || tariffVO.taratStdrNm == '지방소득세'}">
                    <tr>
                        <th>${tariffVO.taratStdrNm}</th>
                        <td>
                            <input type="text" class="taxes" name="${tariffVO.taratStdrCode}"
                                   value="${tariffVO.taratStdrValue}">%
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </form>

    <h2>공제 기본 설정</h2>
    <form action="#">
        <button id="saveSis" type="button">저장하기</button>
        <table border=" 1">
            <%--        </c:forEach>--%>
            <c:forEach var="tariffVO" items="${tariffList}" varStatus="stat">
                <c:if test="${tariffVO.taratStdrNm != '소득세' && tariffVO.taratStdrNm != '지방소득세'}">
                    <tr>
                        <th>${tariffVO.taratStdrNm}</th>
                        <td>
                            개인부담분 :
                            <input type="text" class="taxes" name="${tariffVO.taratStdrCode}"
                                   value="${tariffVO.taratStdrValue}">%
                            회사부담분 :
                            <input type="text" name="${tariffVO.taratStdrCode}"
                                   value="${tariffVO.taratStdrValue}" readonly>%
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </form>
</div>
<script>

    $(document).ready(function () {






        /* 세율 기준 수정 */
        let previousValues = {};
        $("input.taxes").each(function () {
            let code = $(this).attr("name");
            let value = $(this).val();
            previousValues[code] = value;
        });

        $("#saveIncmtax, #saveSis").on("click", function () {
            $("input.taxes").each(function () {
                let code = $(this).attr("name");
                let currentValue = $(this).val();

                if (previousValues[code] !== currentValue) {
                    saveData(code, currentValue);
                    previousValues[code] = currentValue;
                }
            });
        });

        function saveData(code, value) {
            $.ajax({
                url: '/salary/modify/taxes',
                type: 'POST',
                data: {
                    code: code,
                    value: value
                },
                success: function (data) {
                    console.log("소득세 업데이트 성공");
                },
                error: function (request, status, error) {
                    console.log("소득세 업데이트 실패: " + error);
                }
            });
        }
    });
</script>