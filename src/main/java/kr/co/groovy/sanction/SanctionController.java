package kr.co.groovy.sanction;

import kr.co.groovy.common.CommonService;
import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/sanction")
public class SanctionController {
    final
    SanctionService service;
    final
    CommonService commonService;


    public SanctionController(SanctionService service, CommonService commonService, WebApplicationContext context) {
        this.service = service;
        this.commonService = commonService;
    }

    @GetMapping("/template")
    public String getTemplate() {
        return "sanction/template/write";

    }

    @PostMapping("/approve")
    @ResponseBody
    public void approve(String elctrnSanctnemplId) {
        service.approve(elctrnSanctnemplId);
    }

    @PostMapping("/reject")
    @ResponseBody
    public void reject(String elctrnSanctnemplId, String sanctnLineReturnResn) {
        service.reject(elctrnSanctnemplId, sanctnLineReturnResn);
    }

    @PostMapping("/collect")
    @ResponseBody
    public void collect(String elctrnSanctnEtprCode) {
        service.collect(elctrnSanctnEtprCode);
    }

    @PostMapping("/startApprove")
    @ResponseBody
    public void startApprove(@RequestBody Map<String, Object> request) {
        service.startApprove(request);
    }


    @GetMapping("/read/{sanctionNo}")
    public String loadSanction(@PathVariable String sanctionNo, Model model) {
        List<SanctionLineVO> lineList = service.loadLine(sanctionNo);
        List<ReferenceVO> refrnList = service.loadRefrn(sanctionNo);
        SanctionVO sanction = service.loadSanction(sanctionNo);
        UploadFileVO file = service.loadSanctionFile(sanctionNo);

        model.addAttribute("lineList", lineList);
        model.addAttribute("refrnList", refrnList);
        model.addAttribute("sanction", sanction);
        if (file != null) {
            model.addAttribute("file", file);
        }
        return "sanction/template/read";
    }

    // 양식 불러오기
    @GetMapping("/write/{formatSanctnKnd}")
    public String writeSanction(
            @RequestParam("format") String format,
            @PathVariable String formatSanctnKnd, Model model) {
        String etprCode = service.getSeq(Department.valueOf(formatSanctnKnd).label());
        SanctionFormatVO vo = service.loadFormat(format);
        String template = vo.getFormatCn();
        model.addAttribute("template", vo);
        model.addAttribute("etprCode", etprCode);
        return "sanction/template/write";
    }


    @PostMapping("/inputSanction")
    @ResponseBody
    public void inputSanction(@RequestBody ParamMap requestData) {
        service.inputSanction(requestData);
    }


    // --------------------------------------------------------------------------------------------------------------------
    @GetMapping("/getStatus")
    @ResponseBody
    public String getStatus(@RequestParam("elctrnSanctnDrftEmplId") String elctrnSanctnDrftEmplId,
                            @RequestParam("commonCodeSanctProgrs") String commonCodeSanctProgrs) {
        return String.valueOf(service.getStatus(elctrnSanctnDrftEmplId, commonCodeSanctProgrs));
    }

    @GetMapping("/loadAllLine")
    @ResponseBody
    public List<EmployeeVO> loadAllLine(@RequestParam("emplId")String emplId, ModelAndView mav) {
        log.info( "loadLine" + emplId);
        List<String> departmentCodes = Arrays.asList("DEPT010", "DEPT011", "DEPT012", "DEPT013", "DEPT014", "DEPT015");
        List<EmployeeVO> allEmployees = new ArrayList<>();
        for (String deptCode : departmentCodes) {
            List<EmployeeVO> deptEmployees = service.loadAllLine(deptCode, emplId);
            for (EmployeeVO vo : deptEmployees) {
                vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
                vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
            }
            allEmployees.addAll(deptEmployees);
        }
        return allEmployees;
    }

    // --------------------------------------------------------------------------------------------------------------------

    @GetMapping("/box")
    public String getSanctionBox() {
        return "sanction/box";
    }

    @GetMapping("/document")
    public String getInProgress() {
        return "sanction/document";
    }

    @GetMapping("/loadRequest")
    @ResponseBody
    public List<SanctionVO> loadRequest(String emplId) {
        return service.loadRequest(emplId);
    }

    @GetMapping("/loadAwaiting")
    @ResponseBody
    public List<SanctionLineVO> loadAwaiting(String emplId) {
        return service.loadAwaiting(emplId);
    }


}

