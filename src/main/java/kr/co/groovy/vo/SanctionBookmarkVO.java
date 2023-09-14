package kr.co.groovy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SanctionBookmarkVO {
    private String sanctionLineBookmarkSn;
    private String elctrnSanctnDrftEmplId;
    private String elctrnSanctnBookmarkName;
//    @JsonProperty("elctrnSanctnLineBookmark")
    private String elctrnSanctnLineBookmark;

}
