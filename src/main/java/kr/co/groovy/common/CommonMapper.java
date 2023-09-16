package kr.co.groovy.common;

import kr.co.groovy.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommonMapper {
    List<EmployeeVO> loadOrgChart (String depCode);
    DietVO loadMenu(String today);
    List<NoticeVO> loadNotice();

    List<SanctionVO> loadSanction(String emplId);
}
