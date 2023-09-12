package kr.co.groovy.main;

import kr.co.groovy.vo.DietVO;
import kr.co.groovy.vo.NoticeVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MainMapper {
    DietVO loadMenu(String today);
    List<NoticeVO> loadNotice();
}
