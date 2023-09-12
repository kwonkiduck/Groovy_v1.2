<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
  <sec:authentication property="principal" var="CustomUser"/>
<div id="sideBar">
  <header id="header">
    <div id="profile">

      <img src="/uploads/profile/${CustomUser.employeeVO.proflPhotoFileStreNm}" alt="profileImage" id="asideProfile"/>
    </div>
    <div class="user">
      <div class="user-info">
        <span id="userName" class="font-24 font-md" >${CustomUser.employeeVO.emplNm}</span>
        <span id="userHierarchy" class="font-14 font-md">${CustomUser.employeeVO.commonCodeClsf}</span>
      </div>
      <div class="user-service">
        <ul class="font-11 font-reg">
          <li><i class="icon i-mail"></i><span>메일</span><a href="${pageContext.request.contextPath}/email/allMails" id="linkMail">8</a></li>
          <li><a href="${pageContext.request.contextPath}/employee/myInfo" id="settingMyinfo">내 정보 관리</a></li>
        </ul>
      </div>
      <div class="btn-wrap">
        <button id = "logout" class="font-11 btn-free-white"><a href="${pageContext.request.contextPath}/signOut" style="color: black;" >로그아웃<i class="icon i-signOut"></i></a></button>
        <button id="videoConference" class="font-11 btn-free-white"><a href="${pageContext.request.contextPath}/employee/manageEmp"><span class="btn-detail">사원관리</span></a></button>
        <button id="reservation" class="font-11 btn-free-white"><a href="${pageContext.request.contextPath}/facility/meeting"><span class="btn-detail">예약</span></a></button>
      </div>
    </div>
  </header>
  <nav id="nav">
    <div class="personal">
      <span class="nav-cate">개인</span>
      <ul>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/main/home" class="active"><i class="icon i-home"></i>홈</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/employee/commute"><i class="icon i-job"></i>출 · 퇴근</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/vacation/vacation"><i class="icon i-vacation"></i>휴가 · 급여</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/employee/job"><i class="icon i-todo"></i>내 할 일</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/sanction/box"><i class="icon i-sanction"></i>결재함</a></li>
      </ul>
    </div>
    <div class="team">
      <span class="nav-cate">팀</span>
      <ul>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/schedule/scheduleMain"><i class="icon i-org"></i>캘린더</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/teamCommunity"><i class="icon i-community"></i>팀 커뮤니티</a></li>
      </ul>
    </div>
    <div class="company">
      <span class="nav-cate">회사</span>
      <ul>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/notice/loadNoticeList"><i class="icon i-notice"></i>공지사항 (완료)</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/common/club"><i class="icon i-share"></i>동호회</a></li>
        <li class="nav-list"><a href="${pageContext.request.contextPath}/common/loadOrgChart"><i class="icon i-org"></i>조직도 (완료)</a></li>
      </ul>
    </div>
  </nav>

</div>
</sec:authorize>