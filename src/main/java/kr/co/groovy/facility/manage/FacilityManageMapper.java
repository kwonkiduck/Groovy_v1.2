package kr.co.groovy.facility.manage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.groovy.vo.FacilityVO;

@Mapper
public interface FacilityManageMapper {
	
    //시설 예약조회
    public List<FacilityVO> getAllReservedRooms();
    
    //예약순번  조회
    public int getReserveCount();
    
    //예약취소
    public int delReserve(int fcltyResveSn);
}	
