package kr.co.groovy.schedule;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.groovy.vo.ScheduleVO;

@Service
public class ScheduleService {
	
	final
	ScheduleMapper scheduleMapper;
	
	public ScheduleService(ScheduleMapper scheduleMapper) {
		this.scheduleMapper = scheduleMapper;
	}

    public List<ScheduleVO> getSchedule() {
    	return scheduleMapper.getSchedule();
    }
    
	public ScheduleVO getOneSchedule(int schdulSn) {
		return scheduleMapper.getOneSchedule(schdulSn);
	}
    
    public int inputSchedule(ScheduleVO scheduleVO) {
    	return scheduleMapper.inputSchedule(scheduleVO);
    }
    
    public int modifySchedule(ScheduleVO scheduleVO) {
    	return scheduleMapper.modifySchedule(scheduleVO);
    }
    
    public int deleteSchedule(int schdulSn) {
    	return scheduleMapper.deleteSchedule(schdulSn);
    }
    
}
