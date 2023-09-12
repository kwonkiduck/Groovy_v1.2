package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class VehicleVO {
    private String vhcleNo;
    private String vhcleVhcty;
    private int vhclePsncpa;
    private String commonCodeHipassAsnAt;
    private int vhcleResveNo;
    private Date vhcleResveBeginTime;
    private Date vhcleResveEndTime;
    private String vhcleResveEmplId;
    private String vhcleResveEmplNm;
    private String commonCodeResveAt;
}
