package kr.co.groovy.reservation;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.groovy.vo.FacilityVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reservation")
public class FacilityManageController {
	
	@Autowired
	private FacilityManageService service;
	
	//시설 예약현황 정보을 담은 메소드, 회의실, 휴게실 갯수를 
	@GetMapping(value = "/room")
	public String getAllReservedRooms(Model model) {
		List<FacilityVO> reservedRooms = service.getAllReservedRooms();
		List<FacilityVO> equipmentList = service.findEquipmentList();
		// 시설 이름, 구분코드를 등록하고, VO를 jsp로 전달
		for(FacilityVO room : reservedRooms) {
			service.addFcilityName(room);
			service.addFcilityCode(room);
		}
		for(FacilityVO room : equipmentList) {
			service.addFcilityName(room);
			service.addFcilityCode(room);
		}
		int meetingCount = service.getRoomCount("FCLTY010");
		int retiringCount = service.getRoomCount("FCLTY011");
		
		model.addAttribute("meetingCount", meetingCount);
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("retiringCount", retiringCount);
		model.addAttribute("reservedRooms",reservedRooms);
		
		log.info("(컨트롤러)값이 들어가니?" + reservedRooms);
		log.info("갯수가 찍히니? " + meetingCount);
		log.info("비품목록 출력이 되니? " + equipmentList);
		return "admin/gat/room/manage";
	}
	
	//삭제 버튼 메소드
	@GetMapping("/deleteReserved")
	@ResponseBody 
	public String deleteReserved(@RequestParam int fcltyResveSn) {
	    try {
	        service.delResved(fcltyResveSn);
	        log.info("값이 나오니?"+fcltyResveSn);
	        return "success"; // 삭제 성공 시 "success" 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "failure"; // 삭제 실패 시 "failure" 반환
	    }
	}
	
	//당일 예약 리스트
	@GetMapping("/list")
	public String loadTodayReseve(Model model) {
		List<FacilityVO> toDayList = service.findTodayResve(); 
		model.addAttribute("toDayList",toDayList);
		for(FacilityVO room : toDayList) {
			service.addFcilityName(room);
			service.addFcilityCode(room);
		}
		log.info("리스트가 나오니??" + toDayList);
		return"admin/gat/room/list";
	}
	

}
