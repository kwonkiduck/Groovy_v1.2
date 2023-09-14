package kr.co.groovy.reservation;

import kr.co.groovy.enums.Hipass;
import kr.co.groovy.vo.CardReservationVO;
import kr.co.groovy.vo.CardVO;
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
        List<VehicleVO> todayReservedVehicles = mapper.getTodayReservedVehicles();
        setCommonCodeToHipass(todayReservedVehicles);
        return todayReservedVehicles;
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

    public int inputCard(CardVO cardVO) {
        return mapper.inputCard(cardVO);
    }

    public List<CardVO> loadAllCard() {
        List<CardVO> cardList = mapper.loadAllCard();
        for (CardVO cardVO : cardList) {
            String cprCardNo = cardVO.getCprCardNo();
            cardVO.setMaskCardNo(maskCardNumber(cprCardNo));
        }
        return cardList;
    }

    private String maskCardNumber(String cprCardNo) {
        if (cprCardNo.length() != 19 || !cprCardNo.matches("\\d{4}-\\d{4}-\\d{4}-\\d{4}")) {
            return "Invalid card number format";
        }

        String[] number = cprCardNo.split("-");
        number[1] = "****";
        number[2] = "****";

        String maskCardNo = String.join("-", number);

        return maskCardNo;
    }

    public int modifyCardNm(CardVO cardVO) {
        return mapper.modifyCardNm(cardVO);
    }
    public int modifyCardStatusDisabled(String cprCardNo) {
        return mapper.modifyCardStatusDisabled(cprCardNo);
    }

    public List<CardReservationVO> loadCardWaitingList() {
        return mapper.loadCardWaitingList();
    }

}
