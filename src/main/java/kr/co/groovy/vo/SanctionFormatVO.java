package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SanctionFormatVO {
    private String commonCodeSanctnFormat;
    private String formatSanctnKnd;
    private String formatSj;
    private String formatCn; // CLOB 타입
    private String formatUseAt;

}
