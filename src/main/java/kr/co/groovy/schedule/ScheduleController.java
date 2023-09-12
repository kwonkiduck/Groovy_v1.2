package kr.co.groovy.schedule;


import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import freemarker.core.ParseException;
import kr.co.groovy.vo.ScheduleVO;


@Controller
@RequestMapping("/calendar")
public class ScheduleController {
	
		final ScheduleService scheduleService;
	
		public ScheduleController(ScheduleService scheduleService) {
			this.scheduleService = scheduleService;
		}
		
		
		@RequestMapping("/emplScheduleMain") 
		public String emplScheduleMain() {
			return "schedule/emplCalendar";
		}
		
	
		@RequestMapping("/scheduleMain")
		public String scheduleMain() {
			return "schedule/calendar";
		}
	
		@GetMapping("/schedule")
		@ResponseBody
		public List<Map<String, Object>> findAllSchedule() throws Exception {
	
			JSONObject jsonObj = new JSONObject();
			JSONArray jsonArr = new JSONArray();
	
			HashMap<String, Object> hash = new HashMap<>();
	
			List<ScheduleVO> list = scheduleService.getSchedule();
	
			for (ScheduleVO schedule : list) {
				hash.put("id", schedule.getSchdulSn());
				hash.put("title", schedule.getSchdulNm());
				hash.put("start", schedule.getSchdulBeginDate());
				hash.put("end", schedule.getSchdulClosDate());
	
				jsonObj = new JSONObject(hash);
				jsonArr.add(jsonObj);
	
			}
			return jsonArr;
		}
	
		@GetMapping("/schedule/{schdulSn}")
		public ResponseEntity<ScheduleVO> findOneSchedule(@PathVariable int schdulSn) {
			ScheduleVO scheduleVO = scheduleService.getOneSchedule(schdulSn);
	
			if (scheduleVO != null) {
				return new ResponseEntity<>(scheduleVO, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
	
		}
	
		@PostMapping("/schedule")
		@ResponseBody
		public String insertSchedule(@RequestBody List<Map<String, Object>> param) throws ParseException, Exception {
	
			DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);
	
			for (Map<String, Object> list : param) {
	
				String title = (String) list.get("title");
				String start = (String) list.get("start");
				String end = (String) list.get("end");
	
				LocalDateTime startDateUTC = LocalDateTime.parse(start, dateTimeFormatter);
				LocalDateTime endDateUTC = LocalDateTime.parse(end, dateTimeFormatter);
	
				LocalDateTime startDate = startDateUTC.plusHours(9);
	
				ScheduleVO scheduleVO = new ScheduleVO();
	
				scheduleVO.setSchdulNm(title);
	
				Date startDateAsDate = Date.from(startDate.atZone(ZoneId.systemDefault()).toInstant());
				scheduleVO.setSchdulBeginDate(startDateAsDate);
				Date endDateAsDate = Date.from(endDateUTC.atZone(ZoneId.systemDefault()).toInstant());
				scheduleVO.setSchdulClosDate(endDateAsDate);
	
				scheduleService.inputSchedule(scheduleVO);
			}
	
			return "/calendar/scheduleMain";
		}
	
		@PutMapping("/schedule/{schdulSn}")
		@ResponseBody
		public String modifySchedule(@RequestBody List<Map<String, Object>> list, @PathVariable int schdulSn) throws ParseException, Exception {
			int result = 0;
	
			for (Map<String, Object> map : list) {
	
				String id = (String) map.get("id");
				String title = (String) map.get("title");
				String start = (String) map.get("start");
				String end = (String) map.get("end");
	
				ScheduleVO scheduleVO = new ScheduleVO();
				
				Integer idInt = Integer.valueOf(id);
				scheduleVO.setSchdulSn(idInt);
	
				scheduleVO.setSchdulNm(title);
	
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
				Date startdate = dateFormat.parse(start);
				Date enddate = dateFormat.parse(end);
	
				scheduleVO.setSchdulBeginDate(startdate);
				scheduleVO.setSchdulClosDate(enddate);
				
				result = scheduleService.modifySchedule(scheduleVO);
			}
	
			if (result == 1) {
				return "success";
			} else 
				return "fail";
			}
		
		
		@DeleteMapping("/schedule")
		@ResponseBody
		public String deleteSchedule(@RequestBody List<Map<String, Object>> list) {
			
			int result = 0;
			
			for(Map<String, Object> map : list) {
				String id = (String) map.get("id");
				
				ScheduleVO scheduleVO = new ScheduleVO();
				
				Integer idInt = Integer.valueOf(id);
				scheduleVO.setSchdulSn(idInt);
				
				result = scheduleService.deleteSchedule(idInt);
			}
			
			if (result == 1) {
				return "success";
			} else 
				return "fail";
			
		}
		
	
	
}
	
