package kr.co.groovy.job;

import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.JobDiaryVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface JobMapper {
    String getLeader(String emplId);

    int insertDiary(JobDiaryVO jobDiaryVO);

    EmployeeVO getInfoById(String emplId);

    List<JobDiaryVO> getDiaryByDept(String commonCodeDept);

    List<JobDiaryVO> getDiaryByInfo(EmployeeVO employeeVO);

    JobDiaryVO getDiaryByDateAndId(JobDiaryVO jobDiaryVO);
}
