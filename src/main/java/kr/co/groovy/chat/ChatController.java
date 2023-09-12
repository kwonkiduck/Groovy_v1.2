package kr.co.groovy.chat;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.vo.ChatMemberVO;
import kr.co.groovy.vo.ChatRoomVO;
import kr.co.groovy.vo.ChatVO;
import kr.co.groovy.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
        List<EmployeeVO> emplListForChat = chatService.loadEmpListForChat(emplId);
        model.addAttribute("emplListForChat", emplListForChat);
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
    public int createRoom(@RequestBody List<EmployeeVO> roomMemList, Principal principal) {
        String hostEmplId = principal.getName();
        EmployeeVO hostEmpl = employeeService.loadEmp(hostEmplId);

        roomMemList.add(0, hostEmpl);

        int chttRoomNmpr = roomMemList.size();

        int checkDuplication = 0;
        int result = 0;

        String chttRoomTy = null;
        String chttRoomNm = null;
        if (chttRoomNmpr == 2) {
            chttRoomTy = "0";
            chttRoomNm = roomMemList.stream().map(EmployeeVO::getEmplNm).collect(Collectors.joining(", "));

            Map<String, String> mbrData = new HashMap<>();
            int count = 1;
            for (EmployeeVO employeeVO : roomMemList) {
                String chttMbrEmplId = employeeVO.getEmplId();
                mbrData.put("emplId" + count, chttMbrEmplId);
                count++;
            }
            checkDuplication = chatService.checkDuplication(mbrData);

        } else if (chttRoomNmpr > 2) {
            chttRoomTy = "1";
            chttRoomNm = hostEmpl.getEmplNm() + " 외 " + (chttRoomNmpr - 1) + "인";
        }

        if(checkDuplication == 0) {
            Map<String, Object> roomData = new HashMap<>();
            roomData.put("chttRoomNm", chttRoomNm);
            roomData.put("chttRoomTy", chttRoomTy);
            roomData.put("chttRoomNmpr", chttRoomNmpr);
            result = chatService.inputChatRoom(roomData);
            if (result == 1) {
                for (EmployeeVO employeeVO : roomMemList) {
                    String chttMbrEmplId = employeeVO.getEmplId();
                    result = chatService.inputChatMember(chttMbrEmplId);
                }
            }
        }
        return result;
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

    @PostMapping("/inviteEmpls")
    @ResponseBody
    public int inviteEmpls(@RequestBody Map<String, Object> newMem) {
        int chttRoomNo = Integer.parseInt(newMem.get("chttRoomNo").toString());
        String chttRoomNm = (String) newMem.get("chttRoomNm");
        List<String> newMemIdList = (List<String>) newMem.get("employees");
        int newMemCnt = newMemIdList.size();
        int result = 0;
        for(String emplId : newMemIdList) {
            ChatMemberVO chatMemberVO = new ChatMemberVO();
            chatMemberVO.setChttRoomNo(chttRoomNo);
            chatMemberVO.setChttMbrEmplId(emplId);
            result = chatService.inviteEmpl(chatMemberVO);
        }
        if(result == 1) {
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(chttRoomNm);
            while(matcher.find()) {
                int currentNum = Integer.parseInt(matcher.group());
                int newNum = currentNum + newMemCnt;
                String newName = chttRoomNm.replace(Integer.toString(currentNum), Integer.toString(newNum));
                ChatRoomVO chatRoomVO = new ChatRoomVO();
                chatRoomVO.setChttRoomNo(chttRoomNo);
                chatRoomVO.setChttRoomNm(newName);
                result = chatService.modifyRoomNm(chatRoomVO);
            }
        }
        return result;
    }

    @GetMapping("/loadRoomMembers/{chttRoomNo}")
    @ResponseBody
    public List<String> loadRoomMembers(@PathVariable int chttRoomNo) {
        return chatService.loadRoomMembers(chttRoomNo);
    }
}
