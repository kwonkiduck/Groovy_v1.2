package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NotificationVO {
    private String dutyRequest;
    private String answer;
    private String teamNotice;
    private String companyNotice;
    private String schedule;
    private String newChattingRoom;
    private String emailReception;
    private String electronSanctionReception;
    private String electronSanctionResult;
}
