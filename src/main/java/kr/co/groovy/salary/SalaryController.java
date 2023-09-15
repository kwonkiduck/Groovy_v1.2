package kr.co.groovy.salary;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/salary")
public class SalaryController {

    @GetMapping("")
    public String loadSalary(Model model){
        return "admin/at/salary/manage";
    }
}
