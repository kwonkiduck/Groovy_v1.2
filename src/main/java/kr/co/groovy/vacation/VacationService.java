package kr.co.groovy.vacation;

import kr.co.groovy.enums.Department;
import kr.co.groovy.enums.VacationKind;
import kr.co.groovy.sanction.SanctionMapper;
import kr.co.groovy.vo.VacationUseVO;
import kr.co.groovy.vo.VacationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VacationService {

    private final VacationMapper vacationMapper;

    public VacationService(VacationMapper vacationMapper, SanctionMapper sanctionMapper) {
        this.vacationMapper = vacationMapper;
    }

    public VacationVO loadVacationCnt(String emplId) {
        return vacationMapper.loadVacationCnt(emplId);
    }

    public List<VacationUseVO> loadVacationRecord(String emplId) {
        List<VacationUseVO> list = vacationMapper.loadVacationRecord(emplId);
        for(VacationUseVO vo : list ){
            vo.setCommonCodeYrycUseKind(VacationKind.valueOf(vo.getCommonCodeYrycUseKind()).label());
            vo.setCommonCodeYrycUseSe(VacationKind.valueOf(vo.getCommonCodeYrycUseSe()).label());
        }
        return list;
    }
    public int inputVacation(VacationUseVO vo){
        return vacationMapper.inputVacation(vo);
    }

    public VacationUseVO loadVacationDetail(int yrycUseDtlsSn){
        VacationUseVO vo = vacationMapper.loadVacationDetail(yrycUseDtlsSn);
        vo.setCommonCodeYrycUseKind(VacationKind.valueOf(vo.getCommonCodeYrycUseKind()).label());
        vo.setCommonCodeYrycUseSe(VacationKind.valueOf(vo.getCommonCodeYrycUseSe()).label());
        return vo;
    }
}
