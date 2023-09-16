<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<h2>급여 상세</h2>
<div>
    <table border=" 1">
        <c:forEach var="emplVO" items="${empList}" varStatus="stat">
            <tr>
                <td><a href="#" onclick="getPaymentList(${emplVO.emplId})"> ${emplVO.emplId}</a></td>
                <td>${emplVO.emplNm}</td>
                <td>${emplVO.commonCodeDept}팀</td>
                <td>${emplVO.commonCodeClsf}</td>
            </tr>
        </c:forEach>
    </table>
    <select id="salaryYear">
        <option value="2023">2023</option>
        <option value="2022">2022</option>
        <option value="2021">2021</option>
    </select>
</div>
<div id="paymentList">
</div>
<div id="paymentDetail">
</div>
<script>
    function getPaymentList(id) {
        let year = $("#salaryYear").val();
        $.ajax({
            url: `/salary/payment/list/\${id}/\${year}`,
            type: 'GET',
            success: function (data) {
                console.log(data)
                let code = "<table border=1>";
                if (data.length === 0) {
                    code += "<td>검색 결과가 없습니다</td>";
                } else {
                    for (let i = 0; i < data.length; i++) {
                        code += `<td>\${data[i].salaryPymntDate}</td>`;
                        code += `<td><a href="#" onclick="getPaymentDetail(\${data[i].salaryEmplId})">급여명세서 보기</td>`;
                        code += "</tr>";
                    }
                }
                code += "</tbody></table>";
                $("#paymentList").html(code);
            },
            error: function (xhr) {
                console.log(xhr.status)
            }
        })
    }

</script>