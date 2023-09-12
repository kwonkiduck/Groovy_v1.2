package kr.co.groovy.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SalaryVO {
	
	private Date salaryPymntDate;
	private String salaryEmplId;
	private int salaryBslry;
	private int salaryOvtimeAllwnc;
	
}