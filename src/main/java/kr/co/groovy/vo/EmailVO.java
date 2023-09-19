package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@ToString
public class EmailVO {
    private String emailEtprCode;
    private int emailSn;

    private String emailFromAddr;
    private String emailFromNm;
    private String emailFromSj;
    private String emailFromCn;
    private String emailFromCnType;
    private Date emailFromSendDate;
    private String emailFromTmprStreAt;

    private String emailToAddr;
    private String emailToNm;
    private Date emailToReceivedDate;

    private String emailCcAddr;
    private String emailCcNm;
    private Date emailCcReceivedDate;

    private String emailReceivedEmplId;
    private String emailRedngAt;
    private String emailDeleteAt;
    private String emailRealDeleteAt;
    private String emailImprtncAt;

    private String emailBoxName;

    private List<String> emplIdToList;
    private List<String> emplIdCcList;
    private List<String> emailToAddrList;
    private List<String> emailCcAddrList;
}
