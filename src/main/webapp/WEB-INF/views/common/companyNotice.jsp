<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .box-sort-search {
        margin-top: calc((18 / var(--vh)) * 100vh);
        margin-bottom: calc((32 / var(--vh)) * 100vh);
        display: flex;
        justify-content: flex-end;
        align-items: center;
    }

    select {
        margin-right: calc((24 / var(--vw)) * 100vw);
        width: calc((148 / var(--vw)) * 100vw);
        height: var(--vh-32);
        border: 1px solid var(--color-stroke);
    }

    .box-search {
        width: calc((560 / var(--vw)) * 100vw);
        height: var(--vh-64);
        padding-left: var(--vw-24);
        padding-right: var(--vw-24);
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: 1px solid var(--color-stroke);
    }

    .icon-search-24 {
        width: var(--vw-18);
        height: var(--vw-18);
    }

    .input-search {
        border: none;
    }

    .btn-search {
        width: calc((87 / var(--vw)) * 100vw);
        height: calc((37 / var(--vh)) * 100vh);
    }

    .box-notices {
        display: grid;
        grid-template-columns: repeat(3, calc((476 / var(--vw)) * 100vw));
        grid-gap: var(--vw-24) var(--vh-24);
    }

    .box-notice {
        width: calc((476 / var(--vw)) * 100vw);
        height: calc((346 / var(--vh)) * 100vh);

    }


</style>
<h1 class="font-36 font-md color-font-high">공지사항</h1>
<div class="box-sort-search">
    <form action="/common/findNotice" method="get">
        <select name="sortBy" id="" class="stroke">
            <option value="DESC">최신순</option>
            <option value="ASC">오래된순</option>
        </select>
        <div class="box-search border-radius-24 stroke">
            <i class="icon icon-search-24"></i>
            <input type="text" name="keyword" placeholder="검색어를 입력하세요." size="50" class="input-search"
                   value="${param.keyword}"/>
            <button type="submit" value="검색" class="btn-free-blue btn-search"></button>
        </div>
    </form>

</div>
<div class="box-notices">
    <c:forEach var="noticeVO" items="${noticeList}" varStatus="stat"> <!-- 12: 공지사항 개수(length) -->

        <div class="box-notice card-df">
            <a href="/common/noticeDetail?notiEtprCode=${noticeVO.notiEtprCode}">
                <p><img src="/resources/images/${noticeVO.notiCtgryIconFileStreNm}"></p>
                <p>${noticeVO.notiTitle}</p>
                <p>${noticeVO.notiContent}</p>
                <div class="box-view-date">
                    <div class="box-view">
                        <i class="icon icon-view-24"></i>
                        <span class="text-view-count">${noticeVO.notiRdcnt}</span> view
                    </div>
                    <div class="box-date">
                            ${noticeVO.notiDate}
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
</div>