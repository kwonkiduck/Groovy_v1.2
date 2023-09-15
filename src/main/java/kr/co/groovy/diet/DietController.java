package kr.co.groovy.diet;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/diet")
public class DietController {
	final DietService dietService;
	
	public DietController(DietService dietService) {
		this.dietService = dietService;
	}
	
	@RequestMapping("/dietMain")
	public String dietMain() {
		return "diet/diet";
	}
	
}
