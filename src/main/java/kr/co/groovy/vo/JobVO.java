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
public class JobVO {
    private int jobNo;
    private String jobRequstEmplId;
    private String jobRequstEmplNm;
    private String jobRequstEmplProfl;
    private String jobSj;
    private String jobCn;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date jobBeginDate;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date jobClosDate;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date jobRequstDate;
    private String commonCodeDutyKind;

    private List<String> selectedEmplIds; //수신 사원 리스트
    private List<JobProgressVO> jobProgressVOList;
}
