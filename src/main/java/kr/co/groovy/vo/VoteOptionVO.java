package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VoteOptionVO {
    private int voteOptionSeq;
    private int voteRegistSeq;
    private String voteOptionContents;
    private int voteTotalCnt;
    private int votedAt;

}
