package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AnnualSalaryVO {
    private String anslryStdrYear;
    private String commonCodeDeptCrsf;
    private int anslryAllwnc;
    private int bonus;

    public int getTotalSalary() {
        return anslryAllwnc + bonus;
    }
}
