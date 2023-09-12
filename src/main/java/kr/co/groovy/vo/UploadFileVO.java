package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class UploadFileVO {
    private int uploadFileSn;
    private String uploadFileEtprCode;
    private String uploadFileOrginlNm;
    private String uploadFileStreNm;
    private int uploadFileSize;
    private Date uploadFileRgsde;

}
