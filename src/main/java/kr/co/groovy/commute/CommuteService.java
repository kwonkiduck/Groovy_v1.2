package kr.co.groovy.commute;

import kr.co.groovy.vo.CommuteVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommuteService {
    final CommuteMapper commuteMapper;

    public CommuteService(CommuteMapper commuteMapper) {
        this.commuteMapper = commuteMapper;
    }

    public CommuteVO getCommute(String dclzEmplId) {
        return commuteMapper.getCommute(dclzEmplId);
    }

    public int getMaxWeeklyWorkTime(String dclzEmplId) {
        return commuteMapper.getMaxWeeklyWorkTime(dclzEmplId);
    }

    public int insertAttend(CommuteVO commuteVO) {
        return commuteMapper.insertAttend(commuteVO);
    }

    public int updateCommute(String dclzEmplId) {
        return commuteMapper.updateCommute(dclzEmplId);
    }

    public List<String> getWeeklyAttendTime(String dclzEmplId) {
        return commuteMapper.getWeeklyAttendTime(dclzEmplId);
    }

    public List<String> getWeeklyLeaveTime(String dclzEmplId) {
        return commuteMapper.getWeeklyLeaveTime(dclzEmplId);
    }

    public List<String> getAllYear(String dclzEmplId) {
        return commuteMapper.getAllYear(dclzEmplId);
    }

    public List<String> getAllMonth(Map<String, Object> map) {
        return commuteMapper.getAllMonth(map);
    }

    public List<CommuteVO> getCommuteByYearMonth(Map<String, Object> map) {
        return commuteMapper.getCommuteByYearMonth(map);
    }

    public CommuteVO getAttend(String dclzEmplId) {
        return commuteMapper.getAttend(dclzEmplId);
    };
}
