package kr.co.groovy.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.groovy.vo.FacilityVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/fmanage")
public class FacilityManageController {
	
	@Autowired
	private FacilityManageService service;
	
	//시설 예약현황 정보을 담은 메소드
	@GetMapping(value = "/room")
	public String getAllReservedRooms(Model model) {
		List<FacilityVO> reservedRooms = service.getAllReservedRooms();
		// 시설 이름을 등록하고, VO를 jsp로 전달
		for(FacilityVO room : reservedRooms) {
			service.addFcilityName(room);
		}
		model.addAttribute("reservedRooms",reservedRooms);
		log.info("(컨트롤러)값이 들어가니?" + reservedRooms);
		return "admin/gat/room/manage";
	}
	
	//삭제 버튼 메소드
	@GetMapping("/deleteReserved")
	@ResponseBody 
	public String deleteReserved(@RequestParam int fcltyResveSn) {
		log.info("값이 나오니?"+fcltyResveSn);
	    try {
	        service.delResved(fcltyResveSn);
	        return "success"; // 삭제 성공 시 "success" 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "failure"; // 삭제 실패 시 "failure" 반환
	    }
	}
	
	//회의실 갯수 메소드
	@ResponseBody
	@GetMapping("/countMeeting")
	public String countingMeeting(@RequestParam int meetingCount) {
		log.info("회의실 수가 나오니? " + meetingCount);
		try {
			service.getMeetingRoom(meetingCount);
			return "success";
		}catch (Exception e) {
			e.getMessage();
			return "failure";
		}
	}
	
	//휴게실 갯수 메소드
	@ResponseBody
	@GetMapping("/countRetiring")
	public String countingretiring(@RequestParam int retiringCount) {
		log.info("휴게실 수가 나오니? " + retiringCount);
		try {
			service.getMeetingRoom(retiringCount);
			return "success";
		}catch (Exception e) {
			e.getMessage();
			return "failure";
		}
	}
	
}
