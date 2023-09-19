package kr.co.groovy.reservation;

import kr.co.groovy.enums.Hipass;
import kr.co.groovy.vo.VehicleVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class ReservationService {
    final
    ReservationMapper mapper;

    public ReservationService(ReservationMapper mapper) {
        this.mapper = mapper;
    }

    /* 차량 예약 */
    public List<VehicleVO> getTodayReservedVehicles() {
        List<VehicleVO> todayReservedVehicles = getReservedVehicles(mapper.getTodayReservedVehicles());
        setCommonCodeToHipass(todayReservedVehicles);
        return todayReservedVehicles;
    }

    public List<VehicleVO> getAllReservation() {
        return getReservedVehicles(mapper.getAllReservation());
    }

    public List<VehicleVO> getAllVehicles() {
        List<VehicleVO> allVehicles = mapper.getAllVehicles();
        setCommonCodeToHipass(allVehicles);
        return allVehicles;
    }

    public int inputVehicle(VehicleVO vo) {
        return mapper.inputVehicle(vo);
    }

    private static void setCommonCodeToHipass(List<VehicleVO> list) {
        for (VehicleVO vehicleVO : list) {
            vehicleVO.setCommonCodeHipassAsnAt(Hipass.valueOf(vehicleVO.getCommonCodeHipassAsnAt()).getLabel());
        }
    }

    private List<VehicleVO> getReservedVehicles(List<VehicleVO> list) {
        for (VehicleVO vehicleVO : list) {
            int vhcleResveNo = vehicleVO.getVhcleResveNo();
            vhcleResveNo = 0;
            vehicleVO.setVhcleResveNoRedefine(++vhcleResveNo);
        }
        return list;
    }

    public int modifyReturnAt(String vhcleResveNo) {
        return mapper.modifyReturnAt(vhcleResveNo);
    }

}
