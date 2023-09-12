package kr.co.groovy.chat;

import kr.co.groovy.vo.ChatRoomVO;
import kr.co.groovy.vo.ChatVO;
import kr.co.groovy.vo.EmployeeVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChatMapper {

    List<EmployeeVO> loadEmpListForChat(String emplId);

    int inputChatRoom(Map<String, Object> data);

    int inputChatMember(String emplId);

    List<ChatRoomVO> loadChatRooms(String emplId);

    int inputMessage(ChatVO message);

    List<ChatVO> loadRoomMessages(int chttRoomNo);

}