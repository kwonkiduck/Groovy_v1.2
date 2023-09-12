package kr.co.groovy.vo;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class SanctionVO {
    private String elctrnSanctnEtprCode;
    private String elctrnSanctnFormatCode;
    private String elctrnSanctnSj;
    private String elctrnSanctnDc;
    private String elctrnSanctnDrftEmplId;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
    private Date elctrnSanctnRecomDate;
    private String commonCodeSanctProgrs;

    // 결재 라인 출력용
    private String emplNm;
    private String commonCodeDept; // 부서
    private String commonCodeClsf; // 직급
    private String uploadFileStreNm; // 서명 파일
}