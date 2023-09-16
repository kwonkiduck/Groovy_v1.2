package kr.co.groovy.salary;

import kr.co.groovy.vo.AnnualSalaryVO;
import kr.co.groovy.vo.TariffVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
@Slf4j
@Controller
@RequestMapping("/salary")
public class SalaryController {
    final
    SalaryService service;

    public SalaryController(SalaryService service) {
        this.service = service;
    }

    @GetMapping("")
    public String loadSalary(Model model) {
        List<AnnualSalaryVO> salaryList =service.loadSalary();
        List<AnnualSalaryVO> bonusList =service.loadBonus();
        List<TariffVO> tariffVOList = service.loadTariff();
        model.addAttribute("salary", salaryList);
        model.addAttribute("bonus", bonusList);
        model.addAttribute("tariffList", tariffVOList);
        return "admin/at/salary/manage";
    }
}
