package kr.co.groovy.salary.manage;

import org.apache.ibatis.annotations.Mapper;

import kr.co.groovy.vo.AnslryVO;
import kr.co.groovy.vo.CommuteVO;
import kr.co.groovy.vo.SalaryVO;

@Mapper
public interface SalaryManageMapper {
	
	//기준 연도, 부서 수당 구분코드, 직급 수당 구분코드
	public int inputSalary(AnslryVO anslryVO);
	
	//급여 수정
	public int modifySalary(SalaryVO salaryVO);
	
	//시간 외 수당 등록
	public int inputOvertime(SalaryVO salaryVO);
	
	//시간 외 수당 수정
	public int modifyOvertime(SalaryVO salaryVO);
	
	//주간 근무시간 조회
	public CommuteVO findWeektime(CommuteVO commuteVO);

}