package kr.co.groovy.attendance;

import kr.co.groovy.vo.CommuteVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AttendanceService {
    final
    AttendanceMapper mapper;

    public AttendanceService(AttendanceMapper mapper) {
        this.mapper = mapper;
    }

    List<Map<String, Object>> loadAllDclz() {
        List<CommuteVO> list = mapper.loadAllDclz();
        return mapList(list);
    }

    List<Map<String, Object>> loadDeptDclz(String deptCode) {
        List<CommuteVO> list = mapper.loadDeptDclz(deptCode);
        return mapList(list);
    }

    List<Map<String, Object>> mapList(List<CommuteVO> list) {
        List<Map<String, Object>> maps = new ArrayList<>();
        for (CommuteVO vo : list) {
            calculateAndSetWorkInfo(vo);
            Map<String, Object> map = convertToMap(vo);
            maps.add(map);
        }
        return maps;
    }

    void calculateAndSetWorkInfo(CommuteVO vo) {
        vo.setDefaulWorkDate(5);
        vo.setDefaulWorkTime("40:00");
        int defaulWorkTime = 40 * 60;
        int realWikWorkDate = vo.getRealWikWorkDate();
        int dclzWikWorkTime = vo.getDclzWikWorkTime();
        if (realWikWorkDate != 0 && dclzWikWorkTime != 0) {
            vo.setTotalWorkTime(convertTime(dclzWikWorkTime));
            if (dclzWikWorkTime > defaulWorkTime) {
                int overWorkTime = dclzWikWorkTime - defaulWorkTime;
                vo.setOverWorkTime(convertTime(overWorkTime));
                vo.setRealWorkTime("40:00");
            } else {
                vo.setOverWorkTime("00:00");
                vo.setRealWorkTime(convertTime(dclzWikWorkTime));
            }
            int avgWorkTime = dclzWikWorkTime / realWikWorkDate;
            vo.setAvgWorkTime(convertTime(avgWorkTime));
        } else {
            vo.setRealWorkTime("00:00");
            vo.setAvgWorkTime("00:00");
            vo.setOverWorkTime("00:00");
            vo.setTotalWorkTime("00:00");
        }
    }

    Map<String, Object> convertToMap(CommuteVO vo) {
        Map<String, Object> map = new HashMap<>();
        map.put("emplId", vo.getDclzEmplId());
        map.put("emplNm", vo.getEmplNm());
        map.put("deptNm", vo.getDeptNm());
        map.put("clsfNm", vo.getClsfNm());
        map.put("defaulWorkDate", vo.getDefaulWorkDate());
        map.put("realWikWorkDate", vo.getRealWikWorkDate());
        map.put("defaulWorkTime", vo.getDefaulWorkTime());
        map.put("realWorkTime", vo.getRealWorkTime());
        map.put("overWorkTime", vo.getOverWorkTime());
        map.put("totalWorkTime", vo.getTotalWorkTime());
        map.put("avgWorkTime", vo.getAvgWorkTime());
        return map;
    }

    String convertTime(int time) {
        String hours = String.format("%02d", (time / 60));
        String minutes = String.format("%02d", (time % 60));
        return hours + ":" + minutes;
    }

    List<String> loadDeptList() {
        return mapper.loadDeptList();
    }

    int deptTotalWorkTime(String deptCode) {
        return mapper.deptTotalWorkTime(deptCode);
    }

    int deptAvgWorkTime(String deptCode) {
        return mapper.deptAvgWorkTime(deptCode);
    }
}
