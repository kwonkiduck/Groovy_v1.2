package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class CardVO {
    private String cprCardNo;
    private String cprCardNm;
    private String cprCardChrgCmpny;
    private String cprCardUseAt;
    private String maskCardNo;
    private int cprCardSttus;
}
