<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <a href="#"><p>내 휴가</p></a>
    <a href="/employee/salary"><p>내 급여</p></a>
</div>

<div>
    <div>
        <table>
            <tr>
                <th>발생 연차</th>
                <th>사용 연차</th>
                <th>잔여 연차</th>
            </tr>
            <tr>
                <th>${totalVacationCnt}</th>
                <th>${usedVacationCnt}</th>
                <th>${nowVacationCnt}</th>
            </tr>
        </table>
    </div>
    <div>
        <div>
            <div>
                <div><p>휴가 기록</p></div>
                <div><a href="${pageContext.request.contextPath}/vacation/record">더보기</a></div>
                <div><a href="${pageContext.request.contextPath}/vacation/request">휴가 신청</a></div>
            </div>
            <div>
                <table>
                    <tr>
                        <td>연차 | 20XX년 XX월 XX일</td>
                    </tr>
                    <tr>
                        <td>연차 | 20XX년 XX월 XX일</td>
                    </tr>
                    <tr>
                        <td>연차 | 20XX년 XX월 XX일</td>
                    </tr>
                    <tr>
                        <td>연차 | 20XX년 XX월 XX일</td>
                    </tr>
                </table>
            </div>
        </div>
        <div>
            <p>구성원의 휴가(연락금지)</p>
            <table>
                <tr>
                    <td>이혜진 | 연차 20XX년 XX월 XX일</td>
                </tr>
            </table>
        </div>
    </div>
</div>