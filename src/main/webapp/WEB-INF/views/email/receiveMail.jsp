<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>메일 | 받은메일함</title>
</head>
<style>
  ul {list-style: none; padding-left: 0; }
  .mailnavWrap,.serviceWrap {display: flex; gap: 50px; align-items: center}
  .mailnavWrap ul {display: flex; justify-content: space-between; gap:10px}
  .contentWrap {display: flex; flex-direction: column;gap: 10px; margin-top: 50px;}
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
                    <input type="checkbox" id="selectAll">
                </th>
                <th style="width: 100px">
                    읽음표시
                    <button><span>읽음</span></button>
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
            <tr>
                    <td><input type="checkbox" class="selectmail"></td>
                    <td>읽음</td>
                    <td>안중요</td>
                    <td>파일없음</td>

                    <td>조수인</td>
                    <td> <a href="#">개인정보 이용내역 안내 드립니다. </a></td>
                    <td>23.08.20</td>
            </tr>
            <tr>
                    <td><input type="checkbox" class="selectmail"></td>
                    <td>읽음</td>
                    <td>안중요</td>
                    <td>파일없음</td>

                    <td>조수인</td>
                    <td> <a href="#">개인정보 이용내역 안내 드립니다. </a></td>
                    <td>23.08.20</td>
            </tr>
            </tbody>
        </table>
    </div>


</body>
</html>