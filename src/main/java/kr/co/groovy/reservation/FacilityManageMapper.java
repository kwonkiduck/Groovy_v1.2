package kr.co.groovy.reservation;

import kr.co.groovy.vo.FacilityVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FacilityManageMapper {
	
    //시설 예약조회
    public List<FacilityVO> getAllReservedRooms();
    
    //예약취소
    public void delReserve(int fcltyResveSn);
    
    //회의실 갯수
    public int getRoomCount(String oomCode);
    
    //당일 예약 조회
    public List<FacilityVO> findTodayResve();
    
    //각 시설별 비품 조회
	public List<FacilityVO> findEquipmentList();

}	
