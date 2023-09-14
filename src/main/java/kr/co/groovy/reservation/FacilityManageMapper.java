package kr.co.groovy.reservation;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.groovy.vo.FacilityVO;

@Mapper
public interface FacilityManageMapper {
	
    //시설 예약조회
    public List<FacilityVO> getAllReservedRooms();
    
    //예약취소
    public void delReserve(int fcltyResveSn);
    
    //시설 갯수
    public int getRoomCount(String facilityCount);

}	
