package kr.co.groovy.sanction;

import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vacation.VacationMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Map;

@Slf4j
@Service
public class AnnualLeaveService {
    final
    VacationMapper mapper;

    public AnnualLeaveService(VacationMapper mapper) {
        this.mapper = mapper;
    }

    public void afterApprove(Map<String, Object> paramMap) {
        log.info("오남?");
        ParamMap map = ParamMap.init();
        map.put("approveId", paramMap.get("approveId"));
        map.put("elctrnSanctnEtprCode", paramMap.get("elctrnSanctnEtprCode"));
        mapper.modifySanctionCode(map);
    }


}
