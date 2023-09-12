package kr.co.groovy.job;

import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.JobDiaryVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JobService {
    final JobMapper mapper;

    public JobService(JobMapper mapper) {
        this.mapper = mapper;
    }

    String getLeader(String emplId) {
        return mapper.getLeader(emplId);
    }

    int insertDiary(JobDiaryVO jobDiaryVO) {
        return mapper.insertDiary(jobDiaryVO);
    }

    EmployeeVO getInfoById(String emplId) {
        return mapper.getInfoById(emplId);
    }

    List<JobDiaryVO> getDiaryByDept(String commonCodeDept) {
        return mapper.getDiaryByDept(commonCodeDept);
    }

    List<JobDiaryVO> getDiaryByInfo(EmployeeVO employeeVO) {
        return mapper.getDiaryByInfo(employeeVO);
    }

    JobDiaryVO getDiaryByDateAndId(JobDiaryVO jobDiaryVO) {
        return mapper.getDiaryByDateAndId(jobDiaryVO);
    }
}
