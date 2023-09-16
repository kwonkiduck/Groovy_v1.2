package kr.co.groovy.diet;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.groovy.vo.DietVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/diet")
public class DietController {
	final DietService dietService;
	final String uploadSuin;
	
	public DietController(DietService dietService, String uploadSuin) {
		this.dietService = dietService;
		this.uploadSuin = uploadSuin;
	}

	
	@RequestMapping("/dietMain")
	public String dietMain() {
		return "diet/diet";
	}
	
	
	@PostMapping("/dietMain")
	public String dietUpload(@ModelAttribute DietVO dietVO, 
							RedirectAttributes redirectAttributes,
							MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
		
		ExcelRequest excelRequest = new ExcelRequest(uploadSuin);
		final Map<String, MultipartFile> files = multipartHttpServletRequest.getFileMap();
		List<HashMap<String, String>> apply = null;
		
		apply = excelRequest.parseExcelMultiPart(files, "diet", 0, "", "");
		
		for(int i=0; i<apply.size(); i++) {
			//date 타입이라서 변환해줌 이래도 되나? db에서 타입을 string으로 안 해도 되려나?
			String dateString = apply.get(i).get("cell_0");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = dateFormat.parse(dateString);
			
			dietVO.setDietDate(date);
			dietVO.setDietRice(apply.get(i).get("cell_1"));
			dietVO.setDietSoup(apply.get(i).get("cell_2"));
			dietVO.setDietDish1(apply.get(i).get("cell_3"));
			dietVO.setDietDish2(apply.get(i).get("cell_4"));
			dietVO.setDietDish3(apply.get(i).get("cell_5"));
			dietVO.setDietDessert(apply.get(i).get("cell_6"));
			
			log.info(""+dietVO);
			
			dietService.insertDiert(dietVO);
		
		} 
		map.put("res", "ok");
		map.put("msg", "txt.success");
		
		} catch(Exception e){
			System.out.println(e.toString());
			map.put("res", "error");
			map.put("msg", "txt.fail");
		}
		
		redirectAttributes.addFlashAttribute("map", map);
		
		return "redirect:dietMain";
	}
}
