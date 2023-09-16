package kr.co.groovy.commute;

import kr.co.groovy.vo.CommuteVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommuteMapper {
    CommuteVO getCommute(String dclzEmplId);

    int getMaxWeeklyWorkTime(String dclzEmplId);

    int getMaxWeeklyWorkTimeByDay(CommuteVO commuteVO);

    int insertAttend(CommuteVO commuteVO);

    int updateCommute(String dclzEmplId);

    CommuteVO getAttend(String dclzEmplId);

    List<String> getWeeklyAttendTime(String dclzEmplId);

    List<String> getWeeklyLeaveTime(String dclzEmplId);

    List<String> getAllYear(String dclzEmplId);

    List<String> getAllMonth(Map<String, Object> map);

    List<CommuteVO> getCommuteByYearMonth(Map<String, Object> map);

    void insertCommute(CommuteVO commuteVO);

    String getWorkWik(String currentDate);
}
