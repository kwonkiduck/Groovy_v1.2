package kr.co.groovy.salary;

import kr.co.groovy.security.CustomUser;
import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/salary")
public class SalaryController {
    final
    SalaryService service;
    final
    PasswordEncoder encoder;

    public SalaryController(SalaryService service, PasswordEncoder encoder) {
        this.service = service;
        this.encoder = encoder;
    }

    // 인사팀의 사원 연봉, 수당 및 세율 관리
    @GetMapping("")
    public String loadSalary(Model model) {
        List<AnnualSalaryVO> salaryList = service.loadSalary();
        List<AnnualSalaryVO> bonusList = service.loadBonus();
        List<TariffVO> tariffVOList = service.loadTariff("");
        model.addAttribute("salary", salaryList);
        model.addAttribute("bonus", bonusList);
        model.addAttribute("tariffList", tariffVOList);
        return "admin/hrt/employee/salary";
    }

    // 인사팀의 세율 기준 수정
    @PostMapping("/modify/taxes")
    @ResponseBody
    public void modifyIncmtax( String code,  double value){
        service.modifyIncmtax(code, value);
    }

    @PostMapping("/modify/salary")
    @ResponseBody
    public void modifySalary( String code,  int value){
        service.modifySalary(code, value);
    }


    // 회계팀의 급여 상세
    @GetMapping("/list")
    public String loadEmpList(Model model) {
        List<EmployeeVO> list = service.loadEmpList();
        model.addAttribute("empList", list);
        return "admin/at/salary/detail";
    }

    @GetMapping("/taxes/{year}")
    @ResponseBody
    public List<TariffVO> loadTaxes(@PathVariable String year) {
        return service.loadTariff(year);
    }

    @GetMapping("/payment/list/{emplId}/{year}")
    @ResponseBody
    public Map<String, Object> loadPaymentList(@PathVariable String emplId, @PathVariable String year) {
        List<SalaryVO> salaryVOList = service.loadPaymentList(emplId, year);
        List<TariffVO> tariffVOList = service.loadTariff(year);
        Map<String, Object> map = new HashMap<>();
        map.put("salaryList", salaryVOList);
        map.put("tariffList", tariffVOList);
        return map;
    }

    @GetMapping("/paystub")
    public String loadPaystub(Principal principal, Model model) {
        String emplId = principal.getName();
        PaystubVO recentPaystub = service.loadRecentPaystub(emplId);
        List<Integer> years = service.loadYearsForSortPaystub(emplId);
        model.addAttribute("recentPaystub", recentPaystub);
        model.addAttribute("years", years);
        log.info("recentPaystub:{}",recentPaystub);
        log.info("years:{}",years);
        return "employee/mySalary";
    }

    @GetMapping("/paystub/checkPassword")
    public String checkPassword() {
        return "employee/checkPassword";
    }

    @PostMapping("/paystub/checkPassword")
    @ResponseBody
    public String checkPassword(Authentication auth, @RequestBody String password) {
        CustomUser user = (CustomUser) auth.getPrincipal();
        String emplPassword = user.getEmployeeVO().getEmplPassword();
        if (encoder.matches(password, emplPassword)) {
            return "success";
        } else {
            return "fail";
        }
    }

    @GetMapping("/paystub/{year}")
    @ResponseBody
    public List<PaystubVO> loadPaystubList(Principal principal, @PathVariable String year) {
        log.info("year : {}", year);
        String emplId = principal.getName();
        return service.loadPaystubList(emplId, year);
    }
}
