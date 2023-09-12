package kr.co.groovy.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

public enum SanctionFormat {
    SANCTN_FORMAT010("법인카드사용신청서-23-1"),
    SANCTN_FORMAT011("연차사용신청서-23-1"),
    SANCTN_FORMAT012("멀"),
    SANCTN_FORMAT013("공가신청서-23-1");
    private final String label;

    SanctionFormat(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }


}
