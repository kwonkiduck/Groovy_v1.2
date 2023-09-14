<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>메일 | 전체 메일</title>
</head>
<style>
    ul {
        list-style: none;
        padding-left: 0;
    }

    .mailnavWrap, .serviceWrap {
        display: flex;
        gap: 50px;
        align-items: center
    }

    .mailnavWrap ul {
        display: flex;
        justify-content: space-between;
        gap: 10px
    }

    .contentWrap {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: 50px;
    }
</style>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="contentWrap">
    <div class="serviceWrap">
        <div class="serviceWrap">
            <div class="writeWrap">
                <a href="#">메일 쓰기</a>
                <a href="#">내게 쓰기</a>
            </div>
            <div class="filterWrap">
                <label>필터</label>
                <select name="sortMail">
                    <option value="최신순">인사팀</option>
                    <option value="오래된순">회계팀</option>
                </select>
            </div>
        </div>
    </div>
    <table border="1" style="width: 80%; text-align: center">
        <thead>
        <tr>
            <th style="width: 100px">
                <input type="checkbox" id="selectAll" onclick="checkAll()">
            </th>
            <th style="width: 100px">
                읽음표시
                <button onclick="modifyRedngAtByBtn()"><span>읽음</span></button>
            </th>
            <th style="width: 100px">
                중요
                <button><span>삭제</span></button>
            </th>
            <th style="width: 100px">파일여부</th>
            <th>보낸이</th>
            <th>제목</th>
            <th>날짜</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="emailVO" items="${list}">
            <tr>
                <td><input type="checkbox" class="selectMail"></td>
                <td onclick="modifyTableAt(this)" data-id="${emailVO.emailEtprCode}"
                    data-type="redng">${emailVO.emailRedngAt}</td>
                <td onclick="modifyTableAt(this)"
                    data-id="${emailVO.emailEtprCode}" data-type="imprtnc">${emailVO.emailImprtncAt}</td>
                <td>파일존재여부</td>

                <td>${emailVO.emailFromAddr}</td>
                <td><span>[${emailVO.emailBoxName}] </span><a href="#">${emailVO.emailFromSj}</a></td>
                <c:set var="sendDateStr" value="${emailVO.emailFromSendDate}"/>
                <fmt:formatDate var="sendDate" value="${sendDateStr}" pattern="yy.MM.dd"/>
                <td>${sendDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    const allCheck = document.querySelector("#selectAll");
    let checkboxes = document.querySelectorAll('.selectMail:checked');

    function checkAll() {
        let allCheckboxes = document.querySelectorAll(".selectmail");
        allCheckboxes.forEach(function (checkbox) {
            checkbox.checked = allCheck.checked;
        });
    }

    function modifyAt(code, td) {
        let at = td.innerText;
        let emailEtprCode = td.getAttribute("data-id");
        $.ajax({
            url: `/email/\${code}/\${emailEtprCode}`,
            type: 'put',
            data: at,
            success: function (result) {
                at = result;
                td.innerText = at;
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status);
                console.log("message: " + xhr.responseText);
                console.log("error: " + xhr.error);
            }
        });
    }

    function modifyTableAt(td) {
        let code = td.getAttribute("data-type");
        modifyAt(code, td);
    }

    function modifyRedngAtByBtn() {
        checkboxes = document.querySelectorAll(".selectmail:checked");
        checkboxes.forEach(function (checkbox) {
            let td = checkbox.parentNode.nextElementSibling;
            modifyTableAt(td);
            checkbox.checked = false;
            allCheck.checked = false;
        });
    }

</script>
</body>
</html>