package kr.co.groovy.salary.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.groovy.vo.AnslryVO;
import kr.co.groovy.vo.FacilityVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SalaryManageService {

	@Autowired
	private SalaryManageMapper mapper;
	
	//부서코드 저장
	public String getDeptParentCode(String getDeptParentCode) {
		getDeptParentCode = "DEPT_BSLRY01";
		String deptParentCode =  mapper.getDept(getDeptParentCode);
		log.info("부서 부모 코드가 나오니? " + deptParentCode);
		return deptParentCode;
	}
	
	//직급코드 저장
	public String getClsfParentCode(String getClsfParentCode) {
		getClsfParentCode = "CLSF_ALLWNC01";
		String clsfParentCode = mapper.getClsf(getClsfParentCode);
		log.info("직급 부모 코드가 나오니? " + clsfParentCode);
		return clsfParentCode;
	}
	
	//직급, 부서 부모 코드 vo에 전달
	public AnslryVO addCommonCode(AnslryVO anslryVO) {
		String deptParentCode = anslryVO.getDeptParentCode();
		String clsfParentCode = anslryVO.getClsfParentCode();
		
		anslryVO.setDeptCode(deptParentCode);
		anslryVO.setClsfCode(clsfParentCode);
		log.info("부서 부모 코드가 나오니? " + deptParentCode);
		log.info("직급 부모 코드가 나오니? " + clsfParentCode);
		return anslryVO;
	}
	
	//직급 코드 저장
	public String getDeptCode(String deptCode) {
		AnslryVO anslryVO = new AnslryVO();
		
		String deptParent = anslryVO.getDeptParentCode();
		
		for(int i=0; i<deptParent.length(); i++) {
			String dCode = deptParent+i;
		}
		log.info("deptCode값이 나오니? " + deptCode);
		return deptCode;
	}
	
	//부서 코드 저장
}