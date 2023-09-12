<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>조직도</h1>
<div>
    <h2>CEO</h2>
    <div>
        <i></i> <!-- 프로필 자리 -->
        <div>
            <h3>최서연</h3>
            <p>대표이사</p>
        </div>
    </div>
    <hr>

    <div>
        <h2>인사팀</h2>
        <ol>
            <c:forEach var="dept010" items="${DEPT010List}" varStatus="stat">
                <li>
                    <img src="/resources/images/${dept010.proflPhotoFileStreNm}" width="50px;">
                    <div>
                        <h3>${dept010.emplNm}</h3> <span>${dept010.commonCodeClsf}</span>
                    </div>
                    <a href="#${dept010.emplId}">채팅<i></i></a> <!-- 채팅 아이콘/각 태그에 링킹 -->
                    <a href="#${dept010.emplId}">메일<i></i></a> <!-- 메일 아이콘/각 태그에 링킹 -->
                </li>
            </c:forEach>
        </ol>
    </div>
    <hr>


    <div>
        <h2>회계팀</h2>
        <ol>
            <c:forEach var="dept011" items="${DEPT011List}" varStatus="stat">
                <li>
                    <img src="/resources/images/${dept011.proflPhotoFileStreNm}" width="50px;">
                    <div>
                        <h3>${dept011.emplNm}</h3> <span>${dept011.commonCodeClsf}</span>
                    </div>
                    <a href="#${dept011.emplId}">채팅<i></i></a>
                    <a href="#${dept011.emplId}">메일<i></i></a>
                </li>
            </c:forEach>
        </ol>
    </div>
    <hr>

    <div>
        <h2>영업팀</h2>
        <ol>
            <c:forEach var="dept012" items="${DEPT012List}" varStatus="stat">
                <li>
                    <div>
                        <h3>${dept012.emplNm}</h3> <span>${dept012.commonCodeClsf}</span>
                    </div>
                    <a href="#${dept012.emplId}">채팅<i></i></a>
                    <a href="#${dept012.emplId}">메일<i></i></a>
                </li>
            </c:forEach>
        </ol>
    </div>
    <hr>

    <div>
        <h2>홍보팀</h2>
        <ol>
            <c:forEach var="dept013" items="${DEPT013List}" varStatus="stat">
                <li>
                    <div>
                        <h3>${dept013.emplNm}</h3> <span>${dept013.commonCodeClsf}</span>
                    </div>
                    <a href="#${dept013.emplId}">채팅<i></i></a>
                    <a href="#${dept013.emplId}">메일<i></i></a>
                </li>
            </c:forEach>
        </ol>
    </div>
    <hr>

    <div>
        <h2>총무팀</h2>
        <ol>
            <c:forEach var="dept014" items="${DEPT014List}" varStatus="stat">
                <li>
                    <div>
                        <h3>${dept014.emplNm}</h3> <span>${dept014.commonCodeClsf}</span>
                    </div>
                    <a href="#${dept014.emplId}">채팅<i></i></a>
                    <a href="#${dept014.emplId}">메일<i></i></a>
                </li>
            </c:forEach>
        </ol>
    </div>


</div>