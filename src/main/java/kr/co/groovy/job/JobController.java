package kr.co.groovy.job;

import kr.co.groovy.common.CommonService;
import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.enums.DutyProgress;
import kr.co.groovy.enums.DutyStatus;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.JobDiaryVO;
import kr.co.groovy.vo.JobProgressVO;
import kr.co.groovy.vo.JobVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/job")
public class JobController {
    final JobService service;
    final CommonService commonService;

    public JobController(JobService service, CommonService commonService) {
        this.service = service;
        this.commonService = commonService;
    }

    //업무일지
    @GetMapping("/write")
    public String jobDiaryWrite() {
        return "employee/job/jobDiaryWrite";
    }

    @GetMapping("/read")
    public String jobDiaryRead(String date, String id, JobDiaryVO jobDiaryVO, Model model) {
        jobDiaryVO.setJobDiaryReportDate(date);
        jobDiaryVO.setJobDiaryWrtingEmplId(id);
        jobDiaryVO = service.getDiaryByDateAndId(jobDiaryVO);
        jobDiaryVO.setJobDiaryReportDate(date);
        model.addAttribute("vo", jobDiaryVO);
        return "employee/job/jobDiaryRead";
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
                list= service.getDiaryByDept(employeeVO.getCommonCodeDept());
            } else {
                list= service.getDiaryByInfo(employeeVO);
            }
        } catch (Exception e) {

        }
        model.addAttribute("list", list);
        return "employee/job/jobDiary";
    }

    //조직도
    @GetMapping("/jobOrgChart")
    public String jobOrgChart(Model model) {
        List<String> departmentCodes = Arrays.asList("DEPT010", "DEPT011", "DEPT012", "DEPT013", "DEPT014", "DEPT015");
        for (String deptCode : departmentCodes) {
            List<EmployeeVO> deptEmployees = commonService.loadOrgChart(deptCode);
            for (EmployeeVO vo : deptEmployees) {
                vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
                vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
            }
            model.addAttribute(deptCode + "List", deptEmployees);
        }
        return "/employee/job/jobOrgChart";
    }

    //내 할 일
    @GetMapping("/main")
    public String jobMain(Principal principal, Model model) {
        String emplId = principal.getName();
        List<JobVO> requestJobList = service.getAllJobById(emplId);
        model.addAttribute("requestJobList", requestJobList);
        return "employee/job/job";
    }

    @PostMapping("/insertJob")
    @ResponseBody
    public void insertJob(JobVO jobVO, JobProgressVO jobProgressVO, Principal principal) {
        int maxJobNo = service.getMaxJobNo() + 1;
        jobVO.setJobNo(maxJobNo);
        jobVO.setJobRequstEmplId(principal.getName());
        service.insertJob(jobVO);

        jobProgressVO.setJobNo(maxJobNo);
        List<String> selectedEmplIds = jobVO.getSelectedEmplIds();
        for (String selectedEmplId : selectedEmplIds) {
            jobProgressVO.setJobNo(maxJobNo);
            jobProgressVO.setJobRecptnEmplId(selectedEmplId);
            jobProgressVO.setCommonCodeDutySttus(DutyStatus.getValueOfByLabel("대기"));
            service.insertJobProgress(jobProgressVO);
        }
    }

    @GetMapping("/getJobByNo")
    @ResponseBody
    public JobVO getJobByNo(int jobNo) {
        JobVO jobVO = service.getJobByNo(jobNo);
        List<JobProgressVO> jobProgressVOList = jobVO.getJobProgressVOList();
        for (JobProgressVO jobProgressVO : jobProgressVOList) {
            String dutyStatus = DutyStatus.getLabelByValue(jobProgressVO.getCommonCodeDutySttus());
            String dutyProgress = DutyProgress.getLabelByValue(jobProgressVO.getCommonCodeDutyProgrs());
            jobProgressVO.setCommonCodeDutySttus(dutyStatus);
            jobProgressVO.setCommonCodeDutyProgrs(dutyProgress);
        }
        return jobVO;
    }
}
