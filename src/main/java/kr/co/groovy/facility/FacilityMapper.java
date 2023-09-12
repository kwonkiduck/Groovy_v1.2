package kr.co.groovy.facility;

import kr.co.groovy.vo.FacilityVO;
import kr.co.groovy.vo.VehicleVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FacilityMapper {
    List<VehicleVO> getVehicles();

    List<VehicleVO> getReservedVehicleByVhcleNo(String vhcleNo);

    List<VehicleVO> getReservedVehicleByEmplId(String vhcleResveEmplId);

    int inputVehicleReservation(VehicleVO vehicleVO);

    int deleteReservedByVhcleResveNo(int vhcleResveNo);

    List<FacilityVO> getRooms(String commonCodeFcltyKind);

    List<FacilityVO> getReservedRoomsByFcltyKind(String commonCodeFcltyKind);

    List<FacilityVO> getReservedRoomByFcltyResveEmplId(Map<String, String> map);

    int inputRestReservation(FacilityVO facilityVO);

    int deleteReservedByFcltyResveSn(int fcltyResveSn);

    FacilityVO getFixturesByFcltyKind(String commonCodeFcltyKind);


}
