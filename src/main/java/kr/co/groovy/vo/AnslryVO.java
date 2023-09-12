package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AnslryVO {
	private String anslryStdrYear;
	private String commonCodeDeptBslry;
	private String deptBslryName;

	// 부서별 구분 코드 정의
	public enum DeptBslryCommonCode {
		HMR("DEPT_BSLRY010", "인사팀"),
		ANT("DEPT_BSLRY011", "회계팀"),
		SAL("DEPT_BSLRY012", "영업팀"),
		PR("DEPT_BSLRY013", "홍보팀"),
		GA("DEPT_BSLRY014", "총무팀"),
		OWNER("DEPT_BSLRY015", "대표이사");
		
		private final String deptCode;
		private final String deptDescription;
		
		DeptBslryCommonCode(String deptCode, String deptDescription){
			this.deptCode = deptCode;
			this.deptDescription = deptDescription;
		}
		
		public String getDeptCode() {
			return deptCode;
		}
		public String getDeptDescription() {
			return deptDescription;
		}
	}
	
	private String commonCodeClsfAllwnc;
	private String clsfAllwncName;

	// 직급별 구분 코드 정의
	public enum ClsfAllwncCommonCode {
		CEO("CLSF_ALLWNC010", "대표이사")
		,GM("CLSF_ALLWNC011", "부장")
		,CF("CLSF_ALLWNC012", "팀장")
		,DGM("CLSF_ALLWNC013", "차장")
		,MR("CLSF_ALLWNC014", "과장")
		,AM("CLSF_ALLWNC015", "대리")
		,SF("CLSF_ALLWNC016", "사원");

		private final String clsfCode;
		private final String clsfDescription;

		ClsfAllwncCommonCode(String clsfCode, String clsfDescription) {
			this.clsfCode = clsfCode;
			this.clsfDescription = clsfDescription;
		}

		public String getClsfCode() {
			return clsfCode;
		}

		public String getClsfDescription() {
			return clsfDescription;
		}
	}
}
