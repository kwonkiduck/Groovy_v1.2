package kr.co.groovy.reservation;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String deleteReserved(HttpServletRequest request) {
        try {
            int fcltyResveSn = Integer.parseInt(request.getParameter("fcltyResveSn"));
            service.delResved(fcltyResveSn);
            log.info("(컨트롤러) 값이 나오니?" + fcltyResveSn);
        } catch (Exception e) {
            // 예외 처리: 예외 발생 시 로그 기록 및 예외 처리 로직 추가
            log.error("예약 삭제 중 오류 발생: " + e.getMessage(), e);
            // 추가적인 예외 처리 로직을 여기에 추가하세요.
        }
        return "redirect:/admin/gat/room/manage";
    }
	
	//예약현황 증가 값
	@GetMapping(value = "reserveCount")
	public String getFcltyResveCn(Model model) {
		int fcltyResveCn = service.incountResved();
		model.addAttribute("fcltyResveCn",fcltyResveCn);
		log.info("(컨트롤러)값이 나오니?" + fcltyResveCn);
		return "admin/gat/room/manage";
	}
	
}
