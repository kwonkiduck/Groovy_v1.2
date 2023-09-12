package kr.co.groovy.teamcommunity;

import kr.co.groovy.common.CommonService;
import kr.co.groovy.vo.AnswerVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.RecomendVO;
import kr.co.groovy.vo.SntncVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RequestMapping("/teamCommunity")
@Slf4j
@Controller
public class CommunityController {
    final CommunityService service;
    final
    CommonService commonService;

    final
    String uploadPath;

    String emplId;

    public CommunityController(CommunityService service, CommonService commonService, String uploadPath) {
        this.service = service;
        this.commonService = commonService;
        this.uploadPath = uploadPath;
    }

    @GetMapping("")
    public ModelAndView teamComminity(Principal principal, ModelAndView mav) {
        emplId = principal.getName();
        List<SntncVO> sntncList = service.loadPost(emplId);
        List<EmployeeVO> employeeList = service.loadEmpl(emplId);
        Map<String, Integer> recomendPostCnt = new HashMap<>();
        Map<String, Integer> recomendedEmpleChk = new HashMap<>();
        Map<String, Integer> answerPostCnt = new HashMap<>();
        HashMap<String, Object> map = new HashMap<>();

        for (SntncVO post : sntncList) {
            String sntncEtprCode = post.getSntncEtprCode();

            int recomendCnt = service.loadRecomend(sntncEtprCode);
            recomendPostCnt.put(sntncEtprCode, recomendCnt);

            map.put("sntncEtprCode", sntncEtprCode);
            map.put("recomendEmplId", emplId);

            int recomendedChk = service.findRecomend(map);
            recomendedEmpleChk.put(sntncEtprCode, recomendedChk);

            int answerCnt = service.loadAnswerCnt(sntncEtprCode);
            answerPostCnt.put(sntncEtprCode, answerCnt);

        }
        mav.addObject("sntncList", sntncList);
        mav.addObject("employeeList", employeeList);
        mav.addObject("recomendPostCnt", recomendPostCnt);
        mav.addObject("recomendedEmpleChk", recomendedEmpleChk);
        mav.addObject("answerPostCnt", answerPostCnt);
        mav.setViewName("community/teamCommunity");
        return mav;
    }

    @PostMapping("/inputPost")
    public String postWrite(String sntncCn, MultipartFile postFile) throws IOException {
        /*String sntncWritingEmplId = principal.getName();*/
        SntncVO vo = new SntncVO();
        vo.setSntncWrtingEmplId(emplId);
        vo.setSntncCn(sntncCn);
        service.inputPost(vo, postFile);
        return "redirect:/teamCommunity";
    }
    @ResponseBody
    @PutMapping("/modifyPost")
    public String modifyPost(@RequestBody Map<String, Object> map){
        return Integer.toString(service.modifyPost(map));
    }
    /*  포스트 삭제 */
    @ResponseBody
    @DeleteMapping("/deletePost")
    public void deletePost(@RequestBody Map<String, Object> map){
        map.put("sntncWrtingEmplId", emplId);
        log.info("map ====> " + map);
        service.deletePost(map);
    }
    /* 좋아요 구현 */
    @ResponseBody
    @PostMapping("/inputRecomend")
    public int inputRecomend(RecomendVO vo){
        service.inputRecomend(vo);
        String sntncEtprCode = vo.getSntncEtprCode();
        int recomendCnt = service.loadRecomend(sntncEtprCode);
        return recomendCnt;
    }
    @ResponseBody
    @PostMapping("/deleteRecomend")
    public int deleteRecomend(RecomendVO vo){
        service.deleteRecomend(vo);
        String sntncEtprCode = vo.getSntncEtprCode();
        int recomendCnt = service.loadRecomend(sntncEtprCode);
        return recomendCnt;
    }

    @ResponseBody
    @PostMapping("/inputAnswer")
    public int inputAnswer(@RequestBody Map<String, Object> map){
        map.put("answerWrtingEmplId",emplId);
        String sntncEtprCode = (String) map.get("sntncEtprCode");
        service.inputAnswer(map);
        int answerCnt = service.loadAnswerCnt(sntncEtprCode);
        return answerCnt;
    }
    @ResponseBody
    @PostMapping("/loadAnswer")
    public List<AnswerVO> loadAnswer(String sntncEtprCode){
        List<AnswerVO> answerList = service.loadAnswer(sntncEtprCode);
        return answerList;
    }

    @ResponseBody
    @PostMapping("/inputTeamNoti")
    public String inputTeamNoti(@RequestBody Map<String, Object> map){
        map.put("sntncWrtingEmplId",emplId);
        service.inputTeamNoti(map);
        return "success";
    }

    @ResponseBody
    @PostMapping("/loadTeamNoti")
    public List<SntncVO> loadTeamNoti(){
        return service.loadTeamNoti(emplId);
    }
    @ResponseBody
    @PutMapping("/modifyTeamNoti")
    public String loadTeamNoti(@RequestBody Map<String, Object> map){
        map.put("sntncWrtingEmplId",emplId);
        service.modifyTeamNoti(map);
        return "success";
    }


}
