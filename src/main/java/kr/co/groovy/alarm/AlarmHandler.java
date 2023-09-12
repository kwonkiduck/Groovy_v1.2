package kr.co.groovy.alarm;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
public class AlarmHandler extends TextWebSocketHandler {
    //로그인 한 전체
    List<WebSocketSession> sessions = new ArrayList<>();

    //1:1
    Map<String, WebSocketSession> userSessionMap = new HashMap<>();

    final EmployeeService service;

    public AlarmHandler(EmployeeService service) {
        this.service = service;
    }

    //서버 접속성공
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("Socket 연결");
        sessions.add(session);
        log.info("현재 접속한 사원 id: {}", currentUserId(session));
        String senderId = currentUserId(session);
        userSessionMap.put(senderId, session);
    }
    //현재 접속 사원
    private String currentUserId(WebSocketSession session) {
        String loginUserId;
        if (session.getPrincipal() == null) {
            loginUserId = null;
        } else {
            loginUserId = session.getPrincipal().getName();
        }
        return loginUserId;
    }

    //소켓에 메시지 보냈을 때
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String msg = message.getPayload(); //javascript 넘어온 message
        log.info("msg: {}", msg);

        if (msg!=null) {
            String[] msgs = msg.split(",");

            if (msgs!=null && msgs.length == 3) {
                String seq = msgs[0];
                String category = msgs[1];
                String url = msgs[2];
                if (category.equals("noti")) {
                    for (WebSocketSession webSocketSession : sessions) {
                        String userId = currentUserId(webSocketSession);
                        NotificationVO noticeAt = service.getNoticeAt(userId);
                        String companyNotice = noticeAt.getCompanyNotice();

                        if (webSocketSession.isOpen() && companyNotice.equals("NTCN_AT010")) {
                            String notificationHtml = String.format(
                                    "<a href=\"%s\" data-seq=\"%s\" id=\"fATag\">" +
                                            "    <p>[전체공지] 관리자로부터 전체 공지사항이 등록되었습니다.</p>" +
                                            "</a>"
                                    ,
                                    url, seq
                            );
                            webSocketSession.sendMessage(new TextMessage(notificationHtml));
                        }
                    }
                } //공지사항 알림 끝
            }
        }
    }

    //연결 해제될 때
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.info("socket END");
        sessions.remove(session);
        userSessionMap.remove(currentUserId(session), session);
    }
}
