package kr.co.groovy.chat;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.vo.ChatRoomVO;
import kr.co.groovy.vo.ChatVO;
import kr.co.groovy.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {

    private final ChatService chatService;
    private final EmployeeService employeeService;

    public ChatController(ChatService chatService, EmployeeService employeeService) {
        this.chatService = chatService;
        this.employeeService = employeeService;
    }

    @GetMapping("")
    public String chat(Model model, Principal principal) {
        String emplId = principal.getName();
        List<EmployeeVO> empListForChat = chatService.loadEmpListForChat(emplId);
        model.addAttribute("empListForChat", empListForChat);
        return "chat/chat";
    }

    @GetMapping("/loadRooms")
    @ResponseBody
    public List<ChatRoomVO> loadRooms(Principal principal) {
        String emplId = principal.getName();
        List<ChatRoomVO> rooms = chatService.loadChatRooms(emplId);
        return rooms;
    }

    @PostMapping("/createRoom")
    @ResponseBody
    public void createRoom(@RequestBody List<EmployeeVO> roomMemList, Principal principal) {
        String hostEmplId = principal.getName();
        EmployeeVO hostEmpl = employeeService.loadEmp(hostEmplId);

        roomMemList.add(0, hostEmpl);

        int chttRoomNmpr = roomMemList.size();

        String chttRoomTy = null;
        String chttRoomNm = null;
        if (chttRoomNmpr == 2) {
            chttRoomTy = "0";
            chttRoomNm = roomMemList.stream().map(EmployeeVO::getEmplNm).collect(Collectors.joining(", "));
        } else if (chttRoomNmpr > 2) {
            chttRoomTy = "1";
            chttRoomNm = hostEmpl.getEmplNm() + " 외 " + (chttRoomNmpr - 1) + "인";
        }

        Map<String, Object> roomData = new HashMap<>();
        roomData.put("chttRoomNm", chttRoomNm);
        roomData.put("chttRoomTy", chttRoomTy);
        roomData.put("chttRoomNmpr", chttRoomNmpr);
        chatService.inputChatRoom(roomData);

        for (EmployeeVO employeeVO : roomMemList) {
            String chttMbrEmplId = employeeVO.getEmplId();
            chatService.inputChatMember(chttMbrEmplId);
        }
    }

    @PostMapping("/inputMessage")
    @ResponseBody
    public int inputMessage(@RequestBody ChatVO chatVO) {
        return chatService.inputMessage(chatVO);
    }

    @GetMapping("/loadRoomMessages/{chttRoomNo}")
    @ResponseBody
    public List<ChatVO> loadRoomMessages(@PathVariable int chttRoomNo) {
        return chatService.loadRoomMessages(chttRoomNo);
    }
}
