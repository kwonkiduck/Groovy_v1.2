package kr.co.groovy.facility.manage;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;

import kr.co.groovy.vo.FacilityVO;

@Mapper
public interface FacilityManageMapper {
	
    //시설 예약조회
    public List<FacilityVO> getAllReservedRooms();
    
}
