package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class VacationVO {
    private String yrycEmpId;
    private double yrycUseCo;//사용연차개수
    private double yrycNowCo;//현재연차개수
    private String emplNm;
    private String deptNm;
    private String clsfNm;
    private Date emplEncpn;
}
