package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class EmailVO {
    private String emailEtprCode;
    private String emailFromAddr;
    private String emaiFromSj;
    private String emailFromCn;
    private String emailFromCnType;
    private Date emailFromSendDate;
    private String emailFromTmprStreAt;
    private String emailToAddr;
    private Date emailToReceivedDate;
    private String emailRedngAt;
    private String emailImprtncAt;
    private String emailDeleteAt;
    private String emailCcAddr;
}
