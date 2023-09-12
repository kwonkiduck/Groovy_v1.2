<%--
  Created by IntelliJ IDEA.
  User: Ha-Neul Yun
  Date: 2023-08-30
  Time: 오후 3:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header id="mailheader" class="tab">
    <ul>
        <li><a href="#">메일</a></li>
    </ul>
</header>
<div class="mailnavWrap">
    <nav>
        <ul>
            <li class="mail"><a href="mail/allMail">전체메일</a></li>
            <li class="mail"><a href="mail/receiveMail">받은메일함</a></li>
            <li class="mail"><a href="#">보낸메일함</a></li>
            <li class="mail"><a href="#">내게쓴메일함</a></li>
            <li class="mail"><a href="#">중요메일함</a></li>
            <li class="mail"><a href="#">임시저장함</a></li>
            <li class="mail"><a href="#">휴지통</a></li>
        </ul>
    </nav>
    <form action="#" method="get">
        <div class="search">
            <input type="text" name="searchName">
            <button id="findMail">검색</button>
        </div>
    </form>
</div>
