package kr.co.groovy.commute;

import kr.co.groovy.vo.CommuteVO;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/commute")
public class CommuteController {
    final CommuteService commuteService;

    public CommuteController(CommuteService commuteService) {
        this.commuteService = commuteService;
    }

    @GetMapping("/getCommute/{dclzEmplId}")
    public CommuteVO getCommute(@PathVariable String dclzEmplId) {

        CommuteVO commuteVO = commuteService.getCommute(dclzEmplId);
        if (commuteVO==null) {
            commuteVO = new CommuteVO();
        }
        return commuteVO;
    }

    @GetMapping("/getMaxWeeklyWorkTime/{dclzEmplId}")
    public String getMaxWeeklyWorkTime(@PathVariable String dclzEmplId) {
        return Integer.toString(commuteService.getMaxWeeklyWorkTime(dclzEmplId));
    }

    @PostMapping("/insertAttend")
    public String insertAttend(CommuteVO commuteVO) {
        return Integer.toString(commuteService.insertAttend(commuteVO));
    }

    @PutMapping("/updateCommute/{dclzEmplId}")
    public String updateCommute(@PathVariable String dclzEmplId) {
        return Integer.toString(commuteService.updateCommute(dclzEmplId));
    }

    @GetMapping("/getWeeklyAttendTime/{dclzEmplId}")
    public List<String> getWeeklyAttendTime(@PathVariable String dclzEmplId) {
        return commuteService.getWeeklyAttendTime(dclzEmplId);
    }

    @GetMapping("/getWeeklyLeaveTime/{dclzEmplId}")
    public List<String> getWeeklyLeaveTime(@PathVariable String dclzEmplId) {
        return commuteService.getWeeklyLeaveTime(dclzEmplId);
    }

    @GetMapping("/getAllYear/{dclzEmplId}")
    public List<String> getAllYear(@PathVariable String dclzEmplId) {
        return commuteService.getAllYear(dclzEmplId);
    }

    @GetMapping("/getAllMonth")
    public List<String> getAllMonth(String year, String dclzEmplId) {
        if (year == null) {
            year = "0";
        }
        Map<String, Object> map = new HashMap<>();
        map.put("year", year);
        map.put("dclzEmplId", dclzEmplId);

        return commuteService.getAllMonth(map);
    }

    @GetMapping("/getCommuteByYearMonth")
    public List<CommuteVO>getCommuteByYearMonth(String year, String month, String dclzEmplId) {
        Map<String, Object> map = new HashMap<>();
        map.put("year", year);
        map.put("month", month);
        map.put("dclzEmplId", dclzEmplId);

        return commuteService.getCommuteByYearMonth(map);
    }

    @GetMapping("/getAttend/{dclzEmplId}")
    public CommuteVO getAttend(@PathVariable String dclzEmplId) {
        return commuteService.getAttend(dclzEmplId);
    }

}
