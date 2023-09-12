<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <a href="/employee/vacation"><p>내 휴가</p></a>
    <a href="#"><p>내 급여</p></a>
</div>

<div>
    <div>
        <p>8월 급여명세서</p>
        <p>실 수령액</p>
        <p>000000원</p>
        <table>
            <!-- 급여명세서 상세 내역 -->
        </table>
    </div>

    <div>
        <div>
            <p>지급 내역</p>
            <label><input type="checkbox"/>금액 숨기기</label>
            <select id="yearSelect">
                <option value="all">전체</option>
                <option value="2023" selected>2023</option>
                <option value="2022">2022</option>
            </select>
        </div>
        <div>
            <!--  지급 내역 목록 보여줄 곳  -->
        </div>
    </div>

    <!-- 비밀번호 확인 pop -->
    <div>
        <div>
            <p>비밀번호 확인</p>
            <i></i>
        </div>
        <form>
            <input type="password" placeholder="PASSWORD">
            <input type="submit" value="확인">
        </form>
    </div>
</div>