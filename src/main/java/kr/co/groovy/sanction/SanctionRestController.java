package kr.co.groovy.sanction;

import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.SanctionBookmarkVO;
import kr.co.groovy.vo.SanctionLineVO;
import kr.co.groovy.vo.SanctionVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/sanction/api")
public class SanctionRestController {
    final
    SanctionService service;

    public SanctionRestController(SanctionService service) {
        this.service = service;
    }

    /**
     * 전자 결재 승인 처리
     */

    @PutMapping("/approval/{emplId}/{etprCode}")
    public void approve(@PathVariable String emplId, @PathVariable String etprCode) {
        service.approve(emplId, etprCode);
    }

    @PutMapping("/final/approval/{emplId}/{etprCode}")
    public void finalApprove(@PathVariable String emplId, @PathVariable String etprCode) {
        service.finalApprove(emplId, etprCode);
    }

    @PutMapping("/reject")
    public void reject(String elctrnSanctnemplId, String sanctnLineReturnResn, String elctrnSanctnEtprCode) {
        service.reject(elctrnSanctnemplId, sanctnLineReturnResn, elctrnSanctnEtprCode);
    }

    @PutMapping("/collect/{etprCode}")
    public void collect(@PathVariable String etprCode) {
        service.collect(etprCode);
    }


    /**
     * 전자 결재 시작
     */

    /* (현재는 연차만) 결재 문서 제출 (리플랙션) */
    @PostMapping("/reflection")
    public void startApprove(@RequestBody Map<String, Object> request) {
        log.info("startApprove" + request);
        service.startApprove(request);
    }

    /* 결재선 포함 결재 문서 내용 insert */
    @PostMapping("/sanction")
    public void inputSanction(@RequestBody ParamMap requestData) {
        service.inputSanction(requestData);
    }

    /**
     * 결재함 결재 문서 리스트
     */

    @GetMapping("/status")
    public String getStatus(String emplId, String progrs) {
        return String.valueOf(service.getStatus(emplId, progrs));
    }

    @GetMapping("/request/{emplId}")
    public List<SanctionVO> loadRequest(@PathVariable String emplId) {
        return service.loadRequest(emplId);
    }

    @GetMapping("/awaiting/{emplId}")
    public List<SanctionLineVO> loadAwaiting(@PathVariable String emplId) {
        return service.loadAwaiting(emplId);
    }

    @GetMapping("/reference/{emplId}")
    public List<SanctionVO> loadReference(@PathVariable String emplId) {
        return service.loadReference(emplId);
    }


    /**
     * 결재선 지정 및 즐겨찾기
     */

    @GetMapping("/line/{emplId}")
    public List<EmployeeVO> loadAllLine(@PathVariable String emplId) {
        return service.loadAllLine(emplId);
    }

    @PostMapping("/bookmark")
    public void inputBookmark(@RequestBody SanctionBookmarkVO vo) {
        service.inputBookmark(vo);
    }

    @GetMapping("/bookmark/{emplId}")
    public List<Map<String, String>> loadBookmark(@PathVariable String emplId) {
        return service.loadBookmark(emplId);
    }

    @DeleteMapping("/bookmark/{name}")
    public void deleteBookmark(@PathVariable String name) {
        service.deleteBookmark(name);
    }

}
