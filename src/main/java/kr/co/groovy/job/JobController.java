package kr.co.groovy.job;

import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.JobDiaryVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/job")
public class JobController {
    final JobService service;

    public JobController(JobService service) {
        this.service = service;
    }

    @GetMapping("/write")
    public String jobDiaryWrite() {
        return "employee/jobDiaryWrite";
    }

    @GetMapping("/read")
    public String jobDiaryRead(String date, String id, JobDiaryVO jobDiaryVO, Model model) {
        jobDiaryVO.setJobDiaryReportDate(date);
        jobDiaryVO.setJobDiaryWrtingEmplId(id);
        jobDiaryVO = service.getDiaryByDateAndId(jobDiaryVO);
        jobDiaryVO.setJobDiaryReportDate(date);
        System.out.println("date = " + date);
        model.addAttribute("vo", jobDiaryVO);
        return "employee/jobDiaryRead";
    }

    @PostMapping("/insertDiary")
    public String insertDiary(@ModelAttribute JobDiaryVO jobDiaryVO, Principal principal, Model model) {
        String emplId = principal.getName();
        jobDiaryVO.setJobDiaryWrtingEmplId(emplId);

        try {
            String recptnEmplId = service.getLeader(emplId);
            jobDiaryVO.setJobDiaryRecptnEmplId(recptnEmplId);
            service.insertDiary(jobDiaryVO);
            return "redirect:/job/jobDiary";
        } catch (Exception e) {
            return "redirect:/job/jobDiary";
        }
    }

    @GetMapping("/jobDiary")
    public String jobDiary(EmployeeVO employeeVO, Principal principal, Model model) {
        List<JobDiaryVO> list = new ArrayList<>();
        String emplId = principal.getName();
        employeeVO = service.getInfoById(emplId);
        employeeVO.setEmplId(emplId);
        try {
            if (employeeVO.getCommonCodeClsf().equals(ClassOfPosition.CLSF012.name())) {
                //팀장일 경우, 본인 팀의 모든 팀원의 업무 일지 조회
                list= service.getDiaryByDept(employeeVO.getCommonCodeDept());
            } else { //팀장이 아닐 경우, 본인의 업무 일지만 조회
                list= service.getDiaryByInfo(employeeVO);
            }
        } catch (Exception e) {

        }
        model.addAttribute("list", list);
        return "employee/jobDiary";
    }
}
