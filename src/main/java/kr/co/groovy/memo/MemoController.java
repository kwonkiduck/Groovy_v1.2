package kr.co.groovy.memo;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.groovy.vo.MemoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/memo")
public class MemoController {
	
	final
	MemoService memoService;
	
	public MemoController(MemoService memoService) {
		this.memoService = memoService;
	}
	
	@GetMapping("/memoMain")
	public String memoMain(Model model) {
		List<MemoVO> list = memoService.getMemo();
		model.addAttribute("memoList", list);
	
		return "memo/memo";
	}
	
	@PostMapping("/memoMain")
	@ResponseBody
	public String insertMemo(MemoVO memoVO, Principal principal) {
		String emplId = principal.getName();
		memoVO.setMemoEmplId(emplId);
		
		memoService.inputMemo(memoVO);
		return "memo/memo";
	}
	
	

}
