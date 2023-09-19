package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class PaystubVO {
    private String salaryDtsmtEtprCode;
    private Date salaryDtsmtIssuDate;
    private String salaryEmplId;
    private int salaryDtsmtDdcTotamt;
    private int salaryDtsmtPymntTotamt;
    private int salaryDtsmtNetPay;
    private int salaryDtsmtSisNp;
    private int salaryDtsmtSisHi;
    private int salaryDtsmtSisEi;
    private int salaryDtsmtSisWci;
    private int salaryDtsmtIncmtax;
    private int salaryDtsmtLocalityIncmtax;
    private int salaryBslry;
    private int salaryOvtimeAllwnc;
}
