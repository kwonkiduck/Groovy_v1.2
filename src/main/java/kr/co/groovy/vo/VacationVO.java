package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VacationVO {
    private String yrycEmpId;
    private double yrycUseCo;//사용연차개수
    private double yrycNowCo;//현재연차개수
}
