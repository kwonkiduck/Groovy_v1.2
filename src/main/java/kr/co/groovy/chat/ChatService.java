package kr.co.groovy.chat;

import kr.co.groovy.vo.ChatRoomVO;
import kr.co.groovy.vo.ChatVO;
import kr.co.groovy.vo.EmployeeVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ChatService {

    private final ChatMapper chatMapper;

    public ChatService(ChatMapper chatMapper) {
        this.chatMapper = chatMapper;
    }

    public List<EmployeeVO> loadEmpListForChat(String emplId) {
        return chatMapper.loadEmpListForChat(emplId);
    }

    public int inputChatRoom(Map<String, Object> roomData) {
        return chatMapper.inputChatRoom(roomData);
    }

    public int inputChatMember(String emplId) {
        return chatMapper.inputChatMember(emplId);
    }

    public List<ChatRoomVO> loadChatRooms(String emplId) {
        return chatMapper.loadChatRooms(emplId);
    }

    public int inputMessage(ChatVO message) {
        return chatMapper.inputMessage(message);
    }

    public List<ChatVO> loadRoomMessages(int chttRoomNo) {
        return chatMapper.loadRoomMessages(chttRoomNo);
    }

}
