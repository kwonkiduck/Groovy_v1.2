package kr.co.groovy.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SalaryDtssmtVO {
	private String salaryDtsmtEtprCode;
	private Date salaryDtsmtIssuDate;
	private String salaryEmplId;
	private int salaryDtsmtDdcTotamt;
	private int salaryDtsmtPymntTotamt;
	private int salaryDtsmtNetPay;
}
