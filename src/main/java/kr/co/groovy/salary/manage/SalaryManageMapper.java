package kr.co.groovy.salary.manage;

import org.apache.ibatis.annotations.Mapper;

import kr.co.groovy.vo.AnslryVO;
import kr.co.groovy.vo.CommuteVO;
import kr.co.groovy.vo.SalaryVO;

@Mapper
public interface SalaryManageMapper {
	
	//부서코드 조회
	public AnslryVO getDept(String deptCode);
	
	//직급코드 조회
	public AnslryVO getClsf(String clsfCode);
	
	//연봉 등록
	public String inputSalary(AnslryVO anslryVO);
}