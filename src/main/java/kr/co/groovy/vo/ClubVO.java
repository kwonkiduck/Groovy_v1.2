package kr.co.groovy.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@ToString
public class ClubVO {
    private String clbEtprCode;
    private String clbNm;
    private String clbDc;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
    private Date clbDate;
    private int clbPsncpa;
    private String clbChirmnEmplId;
    private String clbChirmnEmplNm;
    private String clbKind;
    private String clbConfmAt;
    private List<ClubMbrVO> clubMbr;
    private int joinChk;

    public void setClubMbr(List<ClubMbrVO> clubMbr) {
        this.clubMbr = clubMbr;
    }
}
