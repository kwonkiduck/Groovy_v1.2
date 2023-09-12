package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;
@Getter
@Setter
@ToString
public class ConnectionLogVO {
    private String emplId;
    private String emplMacadrs;
    private String conectLogMacadrs;
    private String conectLogIp;
    private Date conectLogDate;

}
