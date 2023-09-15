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
        model.addAttribute("template", vo);
        model.addAttribute("etprCode", etprCode);
        return "sanction/template/write";
    }
}

