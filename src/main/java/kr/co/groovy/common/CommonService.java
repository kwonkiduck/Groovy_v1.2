package kr.co.groovy.common;

import kr.co.groovy.enums.NoticeKind;
import kr.co.groovy.vo.*;
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

    public DietVO loadDiet(String today) {
        return mapper.loadMenu(today);
    }

    public List<NoticeVO> loadNotice() {
        List<NoticeVO> list = mapper.loadNotice();
        for (NoticeVO noticeVO : list) {
            String iconFileName = noticeVO.getNotiCtgryIconFileStreNm();
            String categoryLabel = NoticeKind.getCategoryLabel(iconFileName);
            noticeVO.setNotiCtgryIconFileStreNm(categoryLabel);
        }
        return list;
    }

    List<SanctionVO> loadSanction(String emplId) {
        return mapper.loadSanction(emplId);
    }

}
