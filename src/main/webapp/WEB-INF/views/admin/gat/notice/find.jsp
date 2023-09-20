<%--
  Created by IntelliJ IDEA.
  User: Ha-Neul Yun
  Date: 2023-09-04
  Time: 오후 4:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="content-container">
    <table border="1" style="width: 70%">
        <tr>
            <th>공지사항 번호</th>
            <td></td>
        </tr>
        <tr>
            <th>공지사항 제목</th>
            <td></td>
        </tr>
        <tr>
            <th>공지사항 내용</th>
            <td></td>
        </tr>
        <tr>
            <th>공지사항 날짜</th>
            <td></td>
        </tr>
        <tr>
            <th>공지사항 조회수</th>
            <td></td>
        </tr>
    </table>
    <button id="listBtn">목록으로</button>
</div>
<script>
    const listBtn = document.querySelector("#listBtn");
    listBtn.addEventListener(() => {
        location.href = "generalAffairs/manageNotice";
    })
</script>