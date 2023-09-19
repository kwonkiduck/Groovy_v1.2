package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class FacilityVO {
    private String commonCodeFcltyKind;
    private int fcltyPsncpa;
    private int fcltyResveSn;
    private Date fcltyResveBeginTime;
    private Date fcltyResveEndTime;
    private String fcltyResveRequstMatter;
    private String fcltyResveEmplId;
    private String commonCodeResveAt;
    private String projector;
    private String screen;
    private String whiteBoard;
    private String extinguisher;
    private String commonCodeFxtrsKind;
    private String equipName;
    private String fcltyName;
    private String fcltyCode;
    private String fcltyEmplName;
}
