<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set value="${recentPaystub}" var="paystub" />
<fmt:formatDate value="${paystub.salaryDtsmtIssuDate}" var="month" pattern="M" />
<fmt:formatNumber var= "salaryDtsmtDdcTotamt" value="${paystub.salaryDtsmtDdcTotamt}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtPymntTotamt" value="${paystub.salaryDtsmtPymntTotamt}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtNetPay" value="${paystub.salaryDtsmtNetPay}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtSisNp" value="${paystub.salaryDtsmtSisNp}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtSisHi" value="${paystub.salaryDtsmtSisHi}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtSisEi" value="${paystub.salaryDtsmtSisEi}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtSisWci" value="${paystub.salaryDtsmtSisWci}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtIncmtax" value="${paystub.salaryDtsmtIncmtax}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryDtsmtLocalityIncmtax" value="${paystub.salaryDtsmtLocalityIncmtax}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryBslry" value="${paystub.salaryBslry}" type="number" maxFractionDigits="3" />
<fmt:formatNumber var= "salaryOvtimeAllwnc" value="${paystub.salaryOvtimeAllwnc}" type="number" maxFractionDigits="3" />

<header>
    <ul>
        <li><a href="${pageContext.request.contextPath}/vacation">내 휴가</a></li>
        <li><a href="${pageContext.request.contextPath}/salary/paystub/checkPassword">내 급여</a></li>
        <li><a href="${pageContext.request.contextPath}/vacation/record">휴가 기록</a></li>
    </ul>
</header>

<main>
    <div>
        <table border="1">
            <tr>
                <td colspan="2">${month}월 급여명세서</td>
            </tr>
            <tr>
                <td colspan="2">실 수령액</td>
            </tr>
            <tr>
                <td colspan="2">${salaryDtsmtNetPay} 원</td>
            </tr>
            <tr>
                <td>지급</td>
                <td>${salaryDtsmtPymntTotamt} 원</td>
            </tr>
            <tr>
                <td>통상 임금</td>
                <td>${salaryBslry} 원</td>
            </tr>
            <tr>
                <td>시간 외 수당</td>
                <td>${salaryOvtimeAllwnc} 원</td>
            </tr>
            <tr>
                <td>공제</td>
                <td>${salaryDtsmtDdcTotamt} 원</td>
            </tr>
            <tr>
                <td>국민연금</td>
                <td>${salaryDtsmtSisNp} 원</td>
            </tr>
            <tr>
                <td>건강보험</td>
                <td>${salaryDtsmtSisHi} 원</td>
            </tr>
            <tr>
                <td>고용보험</td>
                <td>${salaryDtsmtSisEi} 원</td>
            </tr>
            <tr>
                <td>산재보험</td>
                <td>${salaryDtsmtSisWci} 원</td>
            </tr>
            <tr>
                <td>소득세</td>
                <td>${salaryDtsmtIncmtax} 원</td>
            </tr>
            <tr>
                <td>지방소득세</td>
                <td>${salaryDtsmtLocalityIncmtax} 원</td>
            </tr>
        </table>

    </div>

    <div>
        <div>
            <p>지급 내역</p>
            <label><input type="checkbox" id="hideAmount"/>금액 숨기기</label>
            <select name="selectedYear" id="selectedYear">
                <c:forEach items="${years}" var="year">
                    <option value="${year}">${year}</option>
                </c:forEach>
            </select>
        </div>
        <div>
            <table id="paystubList" border="1">

            </table>
        </div>
    </div>
</main>

<script>
    let year = $("#selectedYear").val();
    if(year != null) {
        loadPaystubList(year);
    }

    $("#selectedYear").on("change", function (event) {
        year = event.target.value;
        loadPaystubList(year);
    })

    $("#hideAmount").on("change", function() {
        if (this.checked) {
            $("#totalStr, #total").css("visibility", "hidden");
        } else {
            $("#totalStr, #total").css("visibility", "visible");
        }
    });

    function loadPaystubList(year) {
        $.ajax({
            url : `/salary/paystub/\${year}`,
            type: "get",
            success : function (result) {
                console.log(result);
                code = "";
                $.each(result, function(idx, obj) {
                    let date = new Date(obj.salaryDtsmtIssuDate);
                    let months = date.getMonth() + 1;
                    let formatedDate = date.getFullYear() + "년 " +
                        (months < 10 ? "0" : "") + months + "월 " +
                        (date.getDate() < 10 ? "0" : "") + date.getDate() + "일";
                    let netPay = obj.salaryDtsmtNetPay.toLocaleString();
                    console.log(obj);
                    code += `<tr id="\${obj.salaryDtsmtEtprCode}">
                             <td>\${months}월</td>
                             <td>\${formatedDate} 지급</td>
                             <td id="totalStr">실수령액</td>
                             <td id="total">\${netPay} 원</td>
                          </tr>`
                });
                $("#paystubList").html(code);
            },
            error : function (xhr) {
                console.log(xhr);
            }
        })
    }
</script>

