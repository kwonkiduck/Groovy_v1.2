package kr.co.groovy.salary.manage;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/salary")
public class SalaryManageController {
	
	@Autowired
	private SalaryManageService service;
	
	//급여 정산 페이지 이동
	@GetMapping("/admin")
	public String getSalary() {
		return "admin/hrt/manageSalarySis";
	}
	
	//연봉 등록 메소드
}

