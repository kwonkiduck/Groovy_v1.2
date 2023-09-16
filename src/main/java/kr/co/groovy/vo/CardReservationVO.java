package kr.co.groovy.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;

@Getter
@Setter
@ToString
public class CardReservationVO {
    private int cprCardResveSn;
    private Date cprCardResveBeginDate;
    private Date cprCardResveClosDate;
    private String cprCardNo;
    private String cprCardNm;
    private String cprCardResveEmplId;
    private String commonCodeResveAt;
    private String cprCardResveRturnAt;
    private String cprCardResveEmplNm;

}
