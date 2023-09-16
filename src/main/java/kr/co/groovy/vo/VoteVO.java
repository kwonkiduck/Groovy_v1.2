package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VoteVO {
    private String votePartcptnEmpId;
    private int voteOptionNo;
    private int voteRegistNo;
}