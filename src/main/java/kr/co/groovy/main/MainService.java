package kr.co.groovy.main;

import kr.co.groovy.enums.NoticeKind;
import kr.co.groovy.vo.DietVO;
import kr.co.groovy.vo.NoticeVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainService {
    final
    MainMapper mapper;

    public MainService(MainMapper mapper) {
        this.mapper = mapper;
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
}
