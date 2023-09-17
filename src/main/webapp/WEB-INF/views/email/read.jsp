<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .content-header {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .mail-option {
        display: flex;
        gap: 24px;
    }
    .file-attachment-title,.file-attachment-inner {
        display: flex;
        align-items: center;
        gap: 24px;
    }
    .mail-list-item, .mail-list-title,.toggle-mail-chk {
        display: flex;
        align-items: center;
        gap: 12px;
    }
</style>
<jsp:include page="header.jsp"></jsp:include>
<div class="cotentWrap">
    <div class="content-header">
        <button class="button-back">뒤로</button>
        <h2 class="mail-title">
            <a href="#">받은 메일함</a>
            <a href="#" class="unread">30</a>
            <a href="#" class="readed">135</a>
        </h2>
        <div class="button-wrap">
            <button class="reply">답장</button>
            <button class="forward">전달</button>
        </div>
        <div class="button-wrap">
            <button class="delete">삭제</button>
        </div>
    </div>
    <div class="content-body">
        <div class="mail-view">
            <div class="mail-header">
                <h3 class="mail-title">
                    <span class="title">[의견 요청] 사업 기획 1, 2안에 대한 의견 요청 드립니다.</span>
                    <p class="mail-date">2023년 8월 20일 (일) 오후 6:45</p>
                </h3>
                <div class="mail-options">
                    <div class="mail-option-sender mail-option">
                        <div class="title">보낸 사람</div>
                        <div class="content">
                            <button class="button-sender button-option">강서주 	&lt;seoju@groovy.ac.kr	&gt;</button>
                        </div>
                    </div>
                    <div class="mail-option-receiver mail-option">
                        <div class="title">받은 사람</div>
                        <div class="content">
                            <button class="button-receiver button-option">최서연 &lt;seoyeon@groovy.ac.kr&gt;</button>
                            <button class="button-receiver button-option">이혜진 &lt;hyejin@groovy.ac.kr&gt;</button>
                        </div>
                    </div>
                    <div class="mail-option-carbonCopy mail-option">
                        <div class="title">참조</div>
                        <div class="content">
                            <button class="button-carbonCopy button-option">이소연 	&lt;soyeon@groovy.ac.kr	&gt;</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mail-body">
                <div class="mail-view">
                    <div class="file-attachment">
                        <div class="file-attachment-title">
                            <div class="file-attachment-inner">
                                <p class="total">첨부 <span>3</span>개</p>
                                <p class="size">4MB</p>
                                <button class="all-download">모두 저장</button>
                            </div>
                            &#94;
                        </div>
                        <div class="file-attachment-body">
                            <ul class="file-list">
                                <li class="file-list-item">
                                    <a href="#">
                                        <span>hello-world_20230820.pdf</span>
                                        <span class="file-size">2.1MB</span>
                                    </a>
                                </li>
                                <li class="file-list-item">
                                    <a href="#">
                                        <span>GROOVY-LOGO_V1</span>
                                        <span class="file-size">1.9MB</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="mail-content">
                        <p>· 본 메일은 2023년 8월 16일 기준 가입된 회원을 대상으로 발송되며, 이후 탈퇴 시에도 본 메일을 수신할 수 있으니 이점 양지 부탁드립니다.
                            · 본 메일은 법령에 따른 통지 의무 사항으로 메일 수신동의 여부와 관계없이 발송되는 메일입니다.
                            · 본 메일은 발신전용으로 회신하실 경우 답변이 되지 않습니다. 문의사항은 그루비 고객센터를 이용해 주십시오.
                            (주)GROOVY는 고객님의 소중한 개인 정보를 보호하기 위하여 최선을 다하겠습니다.
                            감사합니다.</p>
                    </div>
                </div>
            </div>
            <div class="mail-footer">
                <ul class="mail-list">
                    <li class="mail-list-item">
                        <div class="mail-list-title">
                            <i class="icon">위로</i>
                            <div class="toggle-mail-chk">
                                <input type="checkbox">
                                <label for="#">
                                    <i class="icon">읽은 메일</i>
                                </label>
                            </div>
                            <button class="mail-sender">GROOVY</button>
                        </div>
                        <div class="mail-list-content">
                            <a href="#">개인정보 이용내역 안내 드립니다.</a>
                            <span class="mail-date">23.08.23</span>
                        </div>
                    </li>
                    <li class="mail-list-item">
                        <div class="mail-list-title">
                            <i class="icon">아래로</i>
                            <div class="toggle-mail-chk">
                                <input type="checkbox">
                                <label for="#">
                                    <i class="icon">읽은 메일</i>
                                </label>
                            </div>
                            <button class="mail-sender">최서연</button>
                        </div>
                        <div class="mail-list-content">
                            <a href="#">[일정 공지] 금일 8시 30분 인사팀 회의 안내 드립니다. 확인 부탁 드립니다.</a>
                            <span class="mail-date">23.08.23</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>
