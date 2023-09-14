package kr.co.groovy.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SanctionBookmarkVO {
    @JsonProperty("elctrnSanctnDrftEmplId")
    private String elctrnSanctnDrftEmplId;
    @JsonProperty("elctrnSanctnBookmarkName")
    private String elctrnSanctnBookmarkName;
    @JsonProperty("elctrnSanctnLineBookmark")
    private String elctrnSanctnLineBookmark;

}
