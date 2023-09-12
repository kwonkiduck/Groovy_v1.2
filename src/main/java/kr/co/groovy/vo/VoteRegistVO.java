package kr.co.groovy.vo;

import java.sql.Date;
import java.util.List;

public class VoteRegistVO {
    private int voteRegistSeq;
    private String voteRegistEmpId;
    private String voteRegistTitle;
    private Date voteRegistStartDate;
    private Date voteRegistEndDate;
    private List<VoteOptionVO> voteOptions;

}
