package kr.co.groovy.job;

import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.JobDiaryVO;
import kr.co.groovy.vo.JobProgressVO;
import kr.co.groovy.vo.JobVO;
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

    int getMaxJobNo() {return mapper.getMaxJobNo();}

    void insertJob(JobVO jobVO) {mapper.insertJob(jobVO);}

    void insertJobProgress(JobProgressVO jobProgressVO) {mapper.insertJobProgress(jobProgressVO);}

    List<JobVO> getAllJobById(String jobRequstEmplId) {
        return mapper.getAllJobById(jobRequstEmplId);
    }

    JobVO getJobByNo(int jobNo) {
        return mapper.getJobByNo(jobNo);
    }
}
