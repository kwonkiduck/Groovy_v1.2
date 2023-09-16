<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">--%>
<style>
    .recomend-icon-btn {
        width: calc((48 / 1920) * 100vw);
        height: calc((48 / 1920) * 100vw);
        background-color: transparent;
        border: 0;
        cursor: pointer;
    }

    .recomendBtn {
        background: url("/resources/images/icon/heart-on.svg") 100% center / cover;
    }

    .unRecomendBtn {
        background: url("/resources/images/icon/heart-off.svg") 100% center / cover;
    }
    .options {
        display: flex;
    }
    .option-btn.on {
        background-color: var(--color-main);
        color: white;
    }
</style>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <h1>팀 커뮤니티</h1>
    <h4>인사팀만을 위한 공간입니다.</h4>

    <h2>포스트 등록</h2>
    <form action="${pageContext.request.contextPath}/teamCommunity/inputPost" method="post"
          enctype="multipart/form-data">
        <table border="1">
            <tr>
                <th>글 내용</th>
                <td><textarea name="sntncCn" id="sntncCn" cols="50" rows="10"></textarea></td>
            </tr>
            <tr>
                <th>글 파일첨부</th>
                <td><input type="file" name="postFile" id="postFile"><br/></td>
            </tr>
        </table>
        <button id="insertPostBtn">등록</button>
    </form>
    <hr/>
    <br/>
    <h2>포스트 불러오기</h2>
    <form>
        <table border="1" style="width: 90%;">
            <tr>
                <th>글번호</th>
                <th>사원 이름</th>
                <th>등록일</th>
                <th>포스트 내용</th>
                <th>좋아요</th>
                <th>수정/삭제</th>
                <th>파일</th>
                <th>수정/삭제</th>
                <th>좋아요/좋아요수</th>
                <th>댓글/댓글수</th>
            </tr>
            <c:forEach var="sntncVO" items="${sntncList}">

                <tr data-idx="${sntncVO.sntncEtprCode}" class="post">
                    <td class="sntncEtprCode">${sntncVO.sntncEtprCode}</td>
                    <td class="postWriter">
                                <img src="/uploads/profile/${sntncVO.proflPhotoFileStreNm}" width="50px;"/>
                                ${sntncVO.sntncWrtingEmplNm}
                                <span class="postWriterInfo" data-id="${sntncVO.sntncWrtingEmplId}" style="display: none"></span>
                    </td>
                    <td>${sntncVO.sntncWrtingDate}</td>
                    <td class="sntncCn">${sntncVO.sntncCn}</td>
                    <td>${sntncVO.recomendCnt}</td>
                    <td>${sntncVO.sntncWrtingEmplId}</td>
                    <td>
                        <c:choose>
                            <c:when test="${sntncVO.uploadFileSn != null && sntncVO.uploadFileSn != 0.0}">
                                <a href="/file/download/teamCommunity?uploadFileSn=${sntncVO.uploadFileSn}">
                                        ${sntncVO.uploadFileOrginlNm}
                                </a>
                                <fmt:formatNumber value="${sntncVO.uploadFileSize / 1024.0}" type="number"
                                                  minFractionDigits="1" maxFractionDigits="1"/> KB
                            </c:when>
                            <c:otherwise>
                                파일없음
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:if test="${CustomUser.employeeVO.emplId == sntncVO.sntncWrtingEmplId}">
                            <button type="button" class="modifyBtn">수정</button>
                            <button type="button" class="deleteBtn">삭제</button>
                        </c:if>
                    </td>

                    <td>
                        <c:forEach var="recomendedChk" items="${recomendedEmpleChk}">
                            <c:if test="${recomendedChk.key == sntncVO.sntncEtprCode}">
                                <c:choose>
                                    <c:when test="${recomendedChk.value == 0}">
                                        <button class="recomend-icon-btn unRecomendBtn"
                                                data-idx="${sntncVO.sntncEtprCode}"></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="recomend-icon-btn recomendBtn"
                                                data-idx="${sntncVO.sntncEtprCode}"></button>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                        <c:forEach var="recomendCnt" items="${recomendPostCnt}">
                            <c:if test="${recomendCnt.key == sntncVO.sntncEtprCode}">
                                <span class="recomentCnt">${recomendCnt.value}</span>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach var="answerPostCnt" items="${answerPostCnt}">
                            <c:if test="${answerPostCnt.key == sntncVO.sntncEtprCode}">
                                <span class="answerCnt">${answerPostCnt.value}</span>
                            </c:if>
                        </c:forEach>
                        <img src="/uploads/profile/${CustomUser.employeeVO.proflPhotoFileStreNm}" alt="profileImage"
                             style="width: 50px; height: 50px;"/>
                        <textarea class="answerCn"></textarea>
                        <button class="inputAnswer">댓글 등록</button>
                        <button class="loadAnswer">댓글 보기</button>
                    </td>
                    <td class="answerBox"></td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <hr/>
    <br/>
    <hr/>
    <h2>팀 공지</h2>
    <div id="modal-insert-notice" style="display: none;">
        <label for="notisntncSj">공지 제목</label> <br/>
        <input type="text" name="notisntncSj" id="notisntncSj"> <br/>
        <label for="notisntncCn">공지 내용</label><br/>
        <textarea name="notisntncCn" id="notisntncCn" cols="30" rows="10"></textarea><br/>
        <button type="button" id="insertNotice">등록</button>
        <button type="button" id="modifyNotice" style="display: none;">수정</button>
    </div>
    <button type="button" id="teamVote" class="on">진행중인 투표</button>
    <button type="button" id="teamNotice">팀 공지 보기</button>
    <section class="team-enter">
    </section>

    <br/>
    <hr/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="/resources/js/teamCommunity.js"></script>
</sec:authorize>
