<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <h1>동호회</h1>
    <h2>그루비 사내 동호회를 소개합니다.&#x1F64C;</h2>
    <button id="proposalClb">동호회 제안하기</button>
    <div id="modal-proposal">
        <h3>동호회 제안하기</h3>
        <form action="#" method="post">
            <table border="1">
                <tr>
                    <th>동호회 번호</th>
                    <td><input type="text" name="clbNo" id="clbNo"></td>
                </tr>
                <tr>
                    <th>희망 동호회 종류</th>
                    <td><input type="text" name="commonCodeClbKind" id="commonCodeClbKind"></td>
                </tr>
                <tr>
                    <th>동호회 이름</th>
                    <td><input type="text" name="clbNm" id="clbNm"></td>
                </tr>
                <tr>
                    <th>동호회 설명</th>
                    <td>
                        <textarea name="clbDc" id="clbDc"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>동호회 날짜</th>
                    <td><input type="text" name="clbDate" id="clbDate"></td>
                </tr>
                <tr>
                    <th>동호회 정원</th>
                    <td><input type="text" name="clbPsncpa" id="clbPsncpa"></td>
                </tr>
                <tr>
                    <th>동호회 회장 사원 아이디</th>
                    <td><input type="text" name="clbChirmnEmplId" id="clbChirmnEmplId"></td>
                </tr>
            </table>
            <button type="submit">제안하기</button>
        </form>
    </div>
    <br /><hr /><br />
    <h3>등록된 동호회 리스트 불러오기</h3>
    <table border="1">
        <thead>
        <tr>
            <th>동호회 번호</th>
            <th>동호회 종류</th>
            <th>동호회 이름</th>
            <th>동호회 설명</th>
        </tr>
        </thead>
        <tr>
            <td>clbNo</td>
            <td>등산</td>
            <td>숨참고 Mountain Dive~</td>
            <td>
                주말에 모여서 전국으로 등산다니는 모임입니다~ <br />
                숨가빠도 책임 안져요 	&#x1F64B;
            </td>
    </table>
    <br /><hr /><br />
    <h3>동호회 상세정보 보기</h3>
    <table border="1">
        <thead>
        <tr>
            <th>동호회 번호</th>
            <th>동호회 종류</th>
            <th>동호회 이름</th>
            <th>동호회 설명</th>
            <th>동호회 날짜</th>
            <th>동호회 정원</th>
            <th>동호회 회장 사원 아이디</th>
            <th>동호회 멤버</th>
        </tr>
        </thead>
        <tr>
            <td>clbNo</td>
            <td>등산</td>
            <td>숨참고 Mountain Dive~</td>
            <td>
                주말에 모여서 전국으로 등산다니는 모임입니다~ <br />
                숨가빠도 책임 안져요 	&#x1F64B;
            </td>
            <td>2023-08-30</td>
            <td>30</td>
            <td>202308001</td>
            <td>
                <ul>
                    <li>202308001</li>
                    <li>202308002</li>
                    <li>202308003</li>
                </ul></td>
    </table>
</body>
</html>