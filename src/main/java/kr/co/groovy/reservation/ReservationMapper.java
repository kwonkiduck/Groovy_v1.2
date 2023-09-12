package kr.co.groovy.reservation;

import kr.co.groovy.vo.VehicleVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReservationMapper {
    /* 차량 예약 */
    List<VehicleVO> getTodayReservedVehicles();

    List<VehicleVO> getAllVehicles();

    int inputVehicle(VehicleVO vo);
}
