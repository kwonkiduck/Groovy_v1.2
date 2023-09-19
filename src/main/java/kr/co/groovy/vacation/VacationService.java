package kr.co.groovy.vacation;

import kr.co.groovy.enums.Department;
import kr.co.groovy.enums.VacationKind;
import kr.co.groovy.sanction.SanctionMapper;
import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vo.VacationUseVO;
import kr.co.groovy.vo.VacationVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Slf4j
@Service
public class VacationService {

    private final VacationMapper mapper;

    public VacationService(VacationMapper vacationMapper) {
        this.mapper = vacationMapper;
    }

    public VacationVO loadVacationCnt(String emplId) {
        return mapper.loadVacationCnt(emplId);
    }

    public List<VacationUseVO> loadVacationRecord(String emplId) {
        List<VacationUseVO> list = mapper.loadVacationRecord(emplId);
        for(VacationUseVO vo : list ){
            vo.setCommonCodeYrycUseKind(VacationKind.valueOf(vo.getCommonCodeYrycUseKind()).label());
            vo.setCommonCodeYrycUseSe(VacationKind.valueOf(vo.getCommonCodeYrycUseSe()).label());
            vo.setCommonCodeYrycState(VacationKind.valueOf(vo.getCommonCodeYrycState()).label());
        }
        return list;
    }
    public int inputVacation(VacationUseVO vo){
        return mapper.inputVacation(vo);
    }

    public VacationUseVO loadVacationDetail(int yrycUseDtlsSn){
        VacationUseVO vo = mapper.loadVacationDetail(yrycUseDtlsSn);
        vo.setCommonCodeYrycUseKind(VacationKind.valueOf(vo.getCommonCodeYrycUseKind()).label());
        vo.setCommonCodeYrycUseSe(VacationKind.valueOf(vo.getCommonCodeYrycUseSe()).label());
        vo.setCommonCodeYrycState(VacationKind.valueOf(vo.getCommonCodeYrycState()).label());
        return vo;
    }

    public List<VacationUseVO> loadConfirmedVacation(String emplId) {
        List<VacationUseVO> list = mapper.loadConfirmedVacation(emplId);
        for(VacationUseVO vo : list) {
            String useKind = VacationKind.valueOf(vo.getCommonCodeYrycUseKind()).label();
            vo.setCommonCodeYrycUseKind(useKind);
        }
        if(list.size() > 10) {
            List<VacationUseVO> myConfirmedVacation = list.subList(0, 10);
            return myConfirmedVacation;
        } else {
            return list;
        }
    }

    public List<VacationUseVO> loadTeamMemVacation(String emplId) {
        List<VacationUseVO> list = mapper.loadTeamMemVacation(emplId);
        for(VacationUseVO vo : list) {
            String useKind = VacationKind.valueOf(vo.getCommonCodeYrycUseKind()).label();
            vo.setCommonCodeYrycUseKind(useKind);
        }
        if(list.size() > 10) {
            List<VacationUseVO> teamMemVacationList = list.subList(0, 10);
            return teamMemVacationList;
        } else {
            return list;
        }
    }

    public void modifyVacationCount(VacationUseVO vacationUseVO) {mapper.modifyVacationCount(vacationUseVO);}

    public VacationUseVO loadVacationBySn(int yrycUseDtlsSn) {
        return mapper.loadVacationBySn(yrycUseDtlsSn);
    }

    public void modifyStatus(Map<String, Object> paramMap) {
        ParamMap map = ParamMap.init();
        map.put("approveId", paramMap.get("approveId"));
        map.put("state", paramMap.get("state"));
        log.info(map+"오긴 왔는데");
        mapper.modifyStatus(map);
    }
}
