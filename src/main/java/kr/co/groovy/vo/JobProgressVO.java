package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JobProgressVO {
    private int jobNo;
    private String jobRecptnEmplId;
    private String jobRecptnEmplNm;
    private String commonCodeDutySttus;
    private String commonCodeDutyProgrs;
}
