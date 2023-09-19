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

import java.util.*;

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

    @GetMapping("/box")
    public String getSanctionBox() {
        return "sanction/box";
    }

    @GetMapping("/document")
    public String getInProgress() {
        return "sanction/document";
    }

    @GetMapping("/read/{sanctionNo}")
    public String loadSanction(@PathVariable String sanctionNo, Model model) {
        List<SanctionLineVO> lineList = service.loadLine(sanctionNo);
        List<ReferenceVO> refrnList = service.loadRefrn(sanctionNo);
        SanctionVO sanction = service.loadSanction(sanctionNo);
        UploadFileVO file = service.loadSanctionFile(sanctionNo);
        log.info(sanction + "");
        model.addAttribute("lineList", lineList);
        model.addAttribute("refrnList", refrnList);
        model.addAttribute("sanction", sanction);
        if (file != null) {
            model.addAttribute("file", file);
        }
        return "sanction/template/read";
    }

    /**
     * 양식 불러오기
     *
     * @param kind 양식 종류(부서)
     * @param code 양식 코드
     */
    @GetMapping("/format/{kind}/{code}")
    public String writeSanction(@PathVariable String kind, @PathVariable String code, Model model) {
        String etprCode = service.getSeq(Department.valueOf(kind).label());
        SanctionFormatVO vo = service.loadFormat(code);
        model.addAttribute("format", vo);
        model.addAttribute("etprCode", etprCode);
        model.addAttribute("dept", kind);
        return "sanction/template/write";
    }
}

