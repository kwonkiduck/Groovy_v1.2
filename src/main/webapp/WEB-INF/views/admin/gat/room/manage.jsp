<%--
  Created by IntelliJ IDEA.
  User: Ha-Neul Yun
  Date: 2023-09-08
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    ul {
        list-style: none;
        padding-left: 0;
    }

    .wrap ul {
        display: flex;
        gap: 10px
    }

    .header, .titleWrap {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    table tr {
        display: flex;
    }

    table tr td, table tr th {
        flex: 1;
    }
    .roomInfoList, .fxrpsList {
        display: flex; align-items: center; gap: 24px;
    }
    .content > ul {
        display: flex;
        flex-direction: column;
    }
    .roomInfo {
        display: grid;
        grid-template-rows: repeat(2,1fr);
        grid-template-columns: repeat(2,1fr)
    }
</style>
<div class="wrap">
    <ul>
        <li><a href="#" class="tab">시설 관리</a></li>
        <li><a href="#" class="tab">예약 현황</a></li>
    </ul>
</div>
<div class="cardWrap">
    <div class="card">
        <div class="header">
            <h3>오늘 예약 현황</h3>
            <p><a href="#" class="totalResve">0</a>건</p>
            <a href="#">더보기</a>
        </div>
        <div class="content">
            <table border=1 style="width: 100%" >
                <thead>
                <tr>
                    <th>순번</th>
                    <th>시설 종류 구분</th>
                    <th>시설 이름</th>
                    <th>시작 시간</th>
                    <th>끝 시간</th>
                    <th>예약 사원(사번)</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>회의실</td>
                    <td>A101</td>
                    <td>09:00</td>
                    <td>13:00</td>
                    <td>강서주(202308001)</td>
                    <td>
                        <button>예약 취소</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card">
        <div class="header">
            <div class="titleWrap" style="display: block">
                <h3> 시설 관리</h3>
                <ul>
                    <li>회의실 | <span class="totalConf">10</span>개</li>
                    <li>휴게실 | <span class="totalRest">10</span>개</li>
                </ul>
            </div>
        </div>
        <div class="content">
            <div class="roomInfo">
                <ul id="conference">
                    <li class="roomInfoList">
                        <h4 class="roomId">A101</h4>
                        <span class="roomType">회의실</span>
                        <h5>비품</h5>
                        <ul class="fxrpsList">
                            <li>프로젝터</li>
                            <li>스크린</li>
                            <li>의자</li>
                            <li>책상</li>
                            <li>소화기</li>
                        </ul>
                    </li>
                    <li class="roomInfoList">
                        <h4 class="roomId">A101</h4>
                        <span class="roomType">회의실</span>
                        <h5>비품</h5>
                        <ul class="fxrpsList">
                            <li>프로젝터</li>
                            <li>스크린</li>
                            <li>의자</li>
                            <li>책상</li>
                            <li>소화기</li>
                        </ul>
                    </li>

                </ul>
                <ul id="rest">
                    <li class="roomInfoList">
                        <h4 class="roomId">R101</h4>
                        <span class="roomType">휴게실</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
