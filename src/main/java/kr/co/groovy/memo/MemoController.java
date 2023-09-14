package kr.co.groovy.memo;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@ResponseBody
	@GetMapping("/memoMain/{memoSn}")
	public String memoSelectOne(@PathVariable int memoSn) {
	    memoService.getOneMemo(memoSn);
		return "success";
	}
	
	@ResponseBody
	@PostMapping("/memoMain")
	public String insertMemo(@RequestBody MemoVO memoVO, Principal principal) {
		String emplId = principal.getName();
		memoVO.setMemoEmplId(emplId);
		log.info(emplId);
		memoService.inputMemo(memoVO);
		log.info(""+memoVO);
		return "success";
	}
	
	
	@ResponseBody
	@PutMapping("/memoMain/{memoSn}")
	public String modifyMemo(@RequestBody MemoVO memoVO, @PathVariable int memoSn) {
		log.info(""+memoSn);
		log.info(""+memoVO);
		memoService.modifyMemo(memoVO);
		return "success";
	}
	
	
	@ResponseBody
	@DeleteMapping("/memoMain/{memoSn}")
	public String deleteMemoString(@RequestBody MemoVO memoVO, @PathVariable int memoSn) {
		memoService.deleteMemo(memoSn);
		return "success";
	}

}
