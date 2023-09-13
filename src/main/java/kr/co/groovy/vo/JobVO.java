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
    private String jobSj;
    private String job;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date jobBeginDate;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date jobClosDate;
    private String commonCodeDutyKind;

    private List<String> selectedEmplIds;//수신 사원 리스트
}
