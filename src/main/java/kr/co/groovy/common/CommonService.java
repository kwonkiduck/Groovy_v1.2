package kr.co.groovy.common;

import kr.co.groovy.enums.NoticeKind;
import kr.co.groovy.vo.AlarmVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.NoticeVO;
import kr.co.groovy.vo.UploadFileVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommonService {
    final
    CommonMapper mapper;

    public CommonService(CommonMapper mapper) {
        this.mapper = mapper;
    }

    public List<EmployeeVO> loadOrgChart(String depCode) {
        return mapper.loadOrgChart(depCode);
    }
}
