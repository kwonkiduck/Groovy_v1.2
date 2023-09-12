package kr.co.groovy.vacation;

import kr.co.groovy.vo.VacationUseVO;
import kr.co.groovy.vo.VacationVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/vacation")
public class VacationController {

    private final VacationService service;

    public VacationController(VacationService vacationService) {
        this.service = vacationService;
    }


    /* 내 휴가 관련 */
    @GetMapping("/vacation")
    public String vacation(Model model, Principal principal) {
        String emplId = principal.getName();
        VacationVO vacationVO = service.loadVacationCnt(emplId);
        if (vacationVO != null) {
            int usedVacationCnt = vacationVO.getYrycUseCo();
            int nowVacationCnt = vacationVO.getYrycNowCo();
            int totalVacationCnt = usedVacationCnt + nowVacationCnt;
            model.addAttribute("usedVacationCnt", usedVacationCnt);
            model.addAttribute("nowVacationCnt", nowVacationCnt);
            model.addAttribute("totalVacationCnt", totalVacationCnt);
        }
        return "employee/myVacation";
    }

    @GetMapping("/record")
    public String vacationRecord(Model model, Principal principal) {
        String emplId = principal.getName();
        List<VacationUseVO> vacationRecord = service.loadVacationRecord(emplId);
        model.addAttribute("vacationRecord", vacationRecord);
        return "employee/vacation/record";
    }

    @GetMapping("/detail/{yrycUseDtlsSn}")
    public String vacationDetail(@PathVariable int yrycUseDtlsSn, Model model) {
        VacationUseVO vo = service.loadVacationDetail(yrycUseDtlsSn);
        model.addAttribute("detailVO", vo);
        return "employee/vacation/detail";
    }

    @GetMapping("/loadData/{yrycUseDtlsSn}")
    @ResponseBody
    public ResponseEntity<VacationUseVO> loadVacationData(@PathVariable int yrycUseDtlsSn) {
        VacationUseVO vo = service.loadVacationDetail(yrycUseDtlsSn);
        return ResponseEntity.ok(vo);
    }

    @PostMapping("/inputVacation")
    public String inputVacation(VacationUseVO vo) {
        service.inputVacation(vo);
        int generatedKey = vo.getYrycUseDtlsSn();
        return "redirect:/vacation/detail/" + generatedKey;
    }


    /* 휴가 신청 폼 */
    @GetMapping("/request")
    public String requestVacation() {
        return "employee/vacation/request";
    }


}
