package kr.co.groovy.alarm;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.enums.Department;
import kr.co.groovy.vo.AlarmVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/alarm")
public class AlarmController {
    final EmployeeService employeeService;
    final AlarmService service;

    public AlarmController(EmployeeService employeeService, AlarmService service) {
        this.employeeService = employeeService;
        this.service = service;
    }

    //전체한테 보내기
    @PostMapping("/insertAlarm")
    @ResponseBody
    public void insertAlarm(AlarmVO alarmVO, String dept, Principal principal) {
        List<EmployeeVO> emplList = employeeService.loadEmpList();
        for (EmployeeVO employeeVO : emplList) {
            String emplId = employeeVO.getEmplId();
            NotificationVO noticeAt = employeeService.getNoticeAt(emplId);
            System.out.println("**^^noticeAt = " + noticeAt);
            System.out.println("employeeVO = " + employeeVO);
            if (alarmVO.getCommonCodeNtcnKind().equals("NTCN013")) { //사내 공지사항
                if (noticeAt.getAnswer().equals("NTCN_AT010")) {
                    alarmVO.setNtcnEmplId(emplId);
                    service.insertAlarm(alarmVO);
                }
            }

            if(alarmVO.getCommonCodeNtcnKind().equals("NTCN012")) { //팀 공지사항
                System.out.println("emplId = " + emplId);
                String deptValue = Department.getValueByLabel(employeeVO.getCommonCodeDept());
                if (noticeAt.getCompanyNotice().equals("NTCN_AT010")
                        && deptValue.equals(dept)
                        && !emplId.equals(principal.getName())) {
                    System.out.println("emplId = " + emplId);
                    alarmVO.setNtcnEmplId(emplId);
                    service.insertAlarm(alarmVO);
                }
            }

        }
    }

    //특정인에게 알람 보내기
    @PostMapping("/insertAlarmTarget")
    @ResponseBody
    public void insertAlarmTarger(AlarmVO alarmVO) {
        NotificationVO noticeAt = employeeService.getNoticeAt(alarmVO.getNtcnEmplId());
        if (noticeAt.getAnswer().equals("NTCN_AT010")) {
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
