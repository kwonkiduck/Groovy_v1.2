package kr.co.groovy.club;

import kr.co.groovy.vo.ClubVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequestMapping("/club")
@Controller
public class ClubController {
    final ClubService service;
    String emplId;

    public ClubController(ClubService service) {this.service = service;}

    @GetMapping("")
    public String loadClub(Model model, Principal principal){
        emplId = principal.getName();
        List<ClubVO> loadAllClub = service.loadAllClub("1");
        model.addAttribute("clubList",loadAllClub);
        log.info("loadAllClub ===> " + loadAllClub);
        return "common/club";
    }
    @ResponseBody
    @GetMapping("/{clbEtprCode}")
    public List<ClubVO> loadClub(@PathVariable String clbEtprCode){
        Map<String, Object> map = new HashMap<>();
        map.put("clbEtprCode",clbEtprCode);
        map.put("clbMbrEmplId",emplId);
        List<ClubVO> clubDetail = service.loadClub(map);
        return clubDetail;
    }
    @PostMapping("/inputClub")
    public String inputClub(@RequestParam Map<String, Object> map){
        map.put("clbChirmnEmplId",emplId);
        map.put("clbMbrEmplId",emplId);
        service.inputClub(map);
        log.info("map ==> " + map);
        return "redirect:/club";
    }
    @ResponseBody
    @PostMapping("/inputClubMbr")
    public String inputClubMbr(@RequestBody Map<String, Object> map){
        map.put("clbMbrEmplId",emplId);
        service.inputClubMbr(map);
        return "가입 성공~";
    };
    @ResponseBody
    @DeleteMapping("/deleteClubMbr")
    public String deleteClubMbr(@RequestBody Map<String, Object> map){
        map.put("clbMbrEmplId",emplId);
        log.info("map ==> " + map);
        service.deleteClubMbr(map);
        return "탈퇴 성공~~";
    };

}
