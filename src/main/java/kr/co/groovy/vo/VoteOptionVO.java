package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VoteOptionVO {
    private int voteOptionNo;
    private int voteRegistNo;
    private String voteOptionContents;
    private int voteTotalCnt;
    private int votedAt;

}
