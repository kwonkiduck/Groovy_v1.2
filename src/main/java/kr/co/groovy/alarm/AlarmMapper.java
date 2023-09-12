package kr.co.groovy.alarm;

import kr.co.groovy.vo.AlarmVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AlarmMapper {
    void insertAlarm(AlarmVO alarmVO);

    void deleteAlarm(AlarmVO alarmVO);

    List<AlarmVO> getAlarmList(String ntcnEmplId);

    Integer getMaxAlarm();
}
