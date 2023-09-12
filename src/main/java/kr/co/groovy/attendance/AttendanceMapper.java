package kr.co.groovy.attendance;

import kr.co.groovy.vo.CommuteVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AttendanceMapper {

    List<String> loadDeptList();

    List<CommuteVO> loadAllDclz();

    List<CommuteVO> loadDeptDclz(String deptCode);

    int deptTotalWorkTime(String deptCode);

    int deptAvgWorkTime(String deptCode);
}
