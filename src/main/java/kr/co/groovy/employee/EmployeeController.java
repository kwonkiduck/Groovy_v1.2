package kr.co.groovy.employee;

import kr.co.groovy.vo.ConnectionLogVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.NotificationVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RequestMapping("/employee")
@Controller
public class EmployeeController {
    private static final Logger log = LoggerFactory.getLogger(EmployeeController.class);
    final EmployeeService service;

    public EmployeeController(EmployeeService service) {
        this.service = service;
    }


    /* 사원 로그인 */
    @GetMapping("/signIn")
    public String singInForm(Authentication auth) {
        return auth != null ? "main/home" : "signIn";
    }

    @GetMapping("/signInFail")
    public ModelAndView signInFail(ModelAndView mav, String exception) {
        mav.addObject("message", exception);
        mav.setViewName("signIn");
        return mav;
    }
    /* 사원 - 비밀번호 수정*/
    @GetMapping("/initPassword")
    public String initPasswordForm() {
        return "initPassword";
    }
    @PostMapping("/initPassword")
    public String initPassword(@RequestParam("emplId") String emplId, @RequestParam("emplPassword") String emplPassword) {
        this.service.initPassword(emplId, emplPassword);
        return "main/home";
    }

    @GetMapping("/myInfo")
    public String myInfo() {
        return "employee/myInfo";
    }

    @PostMapping("/modifyProfile")
    @ResponseBody
    public String modifyProfile(String emplId, @RequestPart(value = "profileFile") MultipartFile profileFile) {
        log.info("modifyProfile");
        return service.modifyProfile(emplId, profileFile);
    }

    @PostMapping("/modifyPassword")
    @ResponseBody
    public void modifyPassword(String emplId, String emplPassword) {
        service.modifyPassword(emplId, emplPassword);
    }

    @PostMapping("/modifySign")
    @ResponseBody
    public String modifySign(String emplId, MultipartFile signPhotoFile) {
        return service.modifySign(emplId, signPhotoFile);
    }

    @PostMapping("/modifyNoticeAt/{emplId}")
    @ResponseBody
    public void modifyNoticeAt(@RequestBody NotificationVO notificationVO, @PathVariable("emplId") String emplId) {
        service.modifyNoticeAt(notificationVO, emplId);
    }

    /* 관리자 - 사원 관리 */

    @GetMapping("/manageEmp")
    public String manageEmp() {
        return "admin/hrt/employee/manage";
    }

    @ResponseBody
    @GetMapping("/countEmp")
    public String countEmp() {
        int result = this.service.countEmp();
        return Integer.toString(this.service.countEmp());
    }

    @PostMapping("/inputEmp")
    public String inputEmp(EmployeeVO vo) {
        this.service.inputEmp(vo);
        return "redirect:/employee/manageEmp";
    }

    @ResponseBody
    @GetMapping("/loadEmpList")
    public List<EmployeeVO> loadEmpList() {
        return service.loadEmpList();
    }

    @ResponseBody
    @GetMapping("/findEmp")
    public List<EmployeeVO> findEmp(String depCode, String emplNm, String sortBy) {
        return service.findEmp(depCode, emplNm, sortBy);
    }

    @GetMapping("/loadEmp/{emplId}")
    public ModelAndView loadEmp(ModelAndView mav, @PathVariable String emplId) {
        EmployeeVO vo = this.service.loadEmp(emplId);
        mav.addObject("empVO", vo);
        mav.setViewName("admin/hrt/employee/detail");
        return mav;
    }

    @PostMapping("/modifyEmp")
    @ResponseBody
    public void modifyEmp(EmployeeVO vo) {
        service.modifyEmp(vo);
    }

    // 연결 로그 로드
    @GetMapping("/loadLog")
    ModelAndView loadConnectionLog(ModelAndView mav, String today) {
        List<ConnectionLogVO> list = service.loadConnectionLog(today);
        mav.addObject("logList", list);
        mav.setViewName("admin/hrt/employee/connectionLog");
        return mav;
    }




    /* 다시 매핑~ */

    @ResponseBody
    @GetMapping("/loadBirthday")
    public List<EmployeeVO> loadBirthday() {
        return service.loadBirthday();
    }

}

