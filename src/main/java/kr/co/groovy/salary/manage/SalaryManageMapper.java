package kr.co.groovy.salary.manage;

import org.apache.ibatis.annotations.Mapper;

import kr.co.groovy.vo.AnslryVO;
import kr.co.groovy.vo.CommuteVO;
import kr.co.groovy.vo.SalaryVO;

@Mapper
public interface SalaryManageMapper {
	
	//부서코드 가져오기
	public String getDept(String getDeptParentCode);
	
	//직급코드 가져오기
	public String getClsf(String getClsfParentCode);
	
	//부서이름 가져오기
	public String getDeptName(String deptName);
	
	//직급이름 가져오기
	public String getClsfName(String clsfName);
	
	//부서수당 가져오기
	public int getDeptBslry(int commonCodeDeptBslry);
	
	//직급수당 가져오기
	public int getClsfBslry(int commonCodeClsfBslry);
	
	//연봉 등록
	public String inputSalary(AnslryVO anslryVO);
}