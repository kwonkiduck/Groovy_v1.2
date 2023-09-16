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
    private String commonCodeDutySttus; //업무 상태 (대기, 승인, 거절)
    private String commonCodeDutyProgrs; //업무 진행 (전, 중, 완)
}
