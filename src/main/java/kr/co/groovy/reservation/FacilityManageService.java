package kr.co.groovy.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.groovy.vo.FacilityVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FacilityManageService {

	@Autowired
	private FacilityManageMapper mapper;

	FacilityVO facilityVO;
	
	// 시설 예약 현황 조회
	public List<FacilityVO> getAllReservedRooms() {
		List<FacilityVO> reservedRoom = mapper.getAllReservedRooms();
		// log.info("(서비스)값이 나오니? " + reservedRoom);
		return reservedRoom;
	}

	// 저장된 시설 이름 vo에 전달
	public FacilityVO addFcilityName(FacilityVO facilityVO) {
		String commonCodeFcltyKind = facilityVO.getCommonCodeFcltyKind();
		String fcltyName = getFacilityName(commonCodeFcltyKind);
		// log.info("(서비스)값이 나오니? " + commonCodeFcltyKind);
		// VO에 시설이름 저장
		facilityVO.setFcltyName(fcltyName);
		// log.info("(서비스)값이 나오니? " + fcltyName);
		return facilityVO;
	}

	// 시설 이름 저장
	public String getFacilityName(String commonCodeFcltyKind) {
		if (commonCodeFcltyKind.startsWith("FCLTY010")) {
			return "회의실";
		} else if (commonCodeFcltyKind.startsWith("FCLTY011")) {
			return "휴게실";
		} else {
			return commonCodeFcltyKind;
		}
	}

	// 예약 취소 매퍼 연결
	public void delResved(int fcltyResveSn) {
		mapper.delReserve(fcltyResveSn);
	}

	// 시설 코드 vo에 전달
	public FacilityVO addFacility(FacilityVO facilityVO) {
		String meetingRoom = facilityVO.getCommonCodeFcltyKind();
		String meetingRoomCode = setMeetingCode(meetingRoom);

		String retiringRoom = facilityVO.getCommonCodeFcltyKind();
		String retiringRoomCode = setRetiringCode(retiringRoom);

		facilityVO.setCommonCodeFcltyKind(meetingRoomCode);
		facilityVO.setCommonCodeFcltyKind(retiringRoomCode);

		return facilityVO;
	}

	//시설 수 세팅
	public int getFacilityCount(String CommonCodeFcltyKind) {
		String facilityCount = setMeetingCode(CommonCodeFcltyKind);
		facilityCount = setRetiringCode(facilityCount);
		return mapper.getRoomCount(CommonCodeFcltyKind);
	}
	
	// 회의실 코드 세팅
	public String setMeetingCode(String CommonCodeFcltyKind) {
		if (CommonCodeFcltyKind.startsWith("FCLTY010")) {
			return "FCLTY010";
		} else {
			return CommonCodeFcltyKind;
		}
	}

	// 휴게실 코드 세팅
	public String setRetiringCode(String CommonCodeFcltyKind) {
		if (CommonCodeFcltyKind.startsWith("FCLTY011")) {
			return "FCLTY011";
		} else {
			return CommonCodeFcltyKind;
		}
	}
}
