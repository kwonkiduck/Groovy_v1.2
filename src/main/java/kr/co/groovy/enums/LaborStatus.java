package kr.co.groovy.enums;

public enum LaborStatus {
    LABOR_STTUS010("정상출근"),
    LABOR_STTUS011("연차"),
    LABOR_STTUS012("지각"),
    LABOR_STTUS013("조퇴"),
    LABOR_STTUS014("공가"),
    LABOR_STTUS015("무단결근");

    private String label;

    LaborStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
