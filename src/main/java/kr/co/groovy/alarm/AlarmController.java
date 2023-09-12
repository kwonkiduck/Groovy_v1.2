package kr.co.groovy.alarm;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.vo.AlarmVO;
import kr.co.groovy.vo.EmployeeVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/alarm")
public class AlarmController {
    final EmployeeService employeeService;
    final AlarmService service;

    public AlarmController(EmployeeService employeeService, AlarmService service) {
        this.employeeService = employeeService;
        this.service = service;
    }

    @PostMapping("/insertAlarm")
    @ResponseBody
    public void insertAlarm(AlarmVO alarmVO) {
        List<EmployeeVO> emplList = employeeService.loadEmpList();
        System.out.println("alarmVO = " + alarmVO);
        for (EmployeeVO employeeVO : emplList) {
            alarmVO.setNtcnEmplId(employeeVO.getEmplId());
            service.insertAlarm(alarmVO);
        }
    }

    @GetMapping("/all")
    public String all() {
        return "common/allAlarm";
    }

    @GetMapping("/getAllAlarm")
    @ResponseBody
    public List<AlarmVO> alarmList(Principal principal) {
        String emplId = principal.getName();
        List<AlarmVO> alarmList = service.getAlarmList(emplId);
        return alarmList;
    }

    @DeleteMapping("/deleteAlarm")
    @ResponseBody
    public void deleteAlarm(Principal principal, AlarmVO alarmVO) {
        System.out.println("alarmVO = " + alarmVO);
        String emplId = principal.getName();
        alarmVO.setNtcnEmplId(emplId);
        service.deleteAlarm(alarmVO);
    }

    @GetMapping("/getMaxAlarm")
    @ResponseBody
    public int getMaxAlarm() {
        return service.getMaxAlarm();
    }
}
