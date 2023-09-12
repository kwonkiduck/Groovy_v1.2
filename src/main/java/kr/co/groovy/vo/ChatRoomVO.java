package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.socket.WebSocketSession;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@ToString
public class ChatRoomVO {
    private int chttRoomNo;
    private String chttRoomNm;
    private String chttRoomTy;
    private int chttRoomNmpr;
    private Date chttRoomCreatDe;

    private String latestChttCn;
    private Date latestInputDate;
    private String chttRoomThumbnail;

    private final Set<WebSocketSession> sessions = new HashSet<>();

}
