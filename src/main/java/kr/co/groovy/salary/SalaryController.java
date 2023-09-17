package kr.co.groovy.salary;

import kr.co.groovy.vo.AnnualSalaryVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.SalaryVO;
import kr.co.groovy.vo.TariffVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/salary")
public class SalaryController {
    final
    SalaryService service;

    public SalaryController(SalaryService service) {
        this.service = service;
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
}
