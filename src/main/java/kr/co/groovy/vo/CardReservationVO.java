package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class CardReservationVO {
    private int cprCardResveSn;
    private Date cprCardResveBeginDate;
    private Date cprCardResveClosDate;
    private String cprCardResveEmplId;
    private String commonCodeResveAt; // RESVE010: 비예약, RESVE011: 예약
    private String cprCardNo;
    private int cprCardResveRturnAt; // 0: 반납X / 1: 반납O
    private String cprCardUseLoca;
    private String cprCardUsePurps;
    private int cprCardUseExpectAmount;
    private String commonCodeYrycState;
    private int generatedKey;

}
