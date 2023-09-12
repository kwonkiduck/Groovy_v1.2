package kr.co.groovy.vacation;

import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vo.VacationUseVO;
import kr.co.groovy.vo.VacationVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VacationMapper {

    VacationVO loadVacationCnt(String emplId);

    List<VacationUseVO> loadVacationRecord(String emplId);

    int inputVacation(VacationUseVO vo);

    String getSeq(String dept);

    VacationUseVO loadVacationDetail(int yrycUseDtlsSn);

    void modifySanctionCode(ParamMap map);
}
