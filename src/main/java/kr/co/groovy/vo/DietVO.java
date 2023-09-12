package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class DietVO {
    private Date dietDate;
    private String dietRice;
    private String dietSoup;
    private String dietDish1;
    private String dietDish2;
    private String dietDish3;
    private String dietDessert;

}
