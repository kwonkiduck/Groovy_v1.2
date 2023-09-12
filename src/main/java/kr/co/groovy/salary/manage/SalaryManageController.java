package kr.co.groovy.salary.manage;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.groovy.vo.AnslryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/salary")
public class SalaryManageController {
	
	@Autowired
	private SalaryManageService service;
	
	
	//vo에 있는 enum값 불러오는 메소드
	@GetMapping(value = "/admin", produces="application/json;charset=UTF-8")
	public String getDeptName(Model model) {
	    AnslryVO.DeptBslryCommonCode[] code = AnslryVO.DeptBslryCommonCode.values();
	    List<String> deptNames = new ArrayList<>();
	    for (AnslryVO.DeptBslryCommonCode deptCode : code) {
	        deptNames.add(deptCode.getDeptDescription());
	    }
	    model.addAttribute(deptNames);
	    log.info("(컨트롤러)값이 나오니?" + deptNames);
	    return "admin/hrt/manageSalarySis";
	}
}

