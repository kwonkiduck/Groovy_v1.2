package kr.co.groovy.enums;

public enum SanctionProgress {
    // 승인 반려 보류 회수 상신
    // CONSENT("승인"), RETURN("반려"), RESERVATION, RETIREVAL, REPORT
    SANCTN010("상신"),
    SANCTN011("진행"),
    SANCTN012("회수"),
    SANCTN013("대기"),
    SANCTN014("예정"),
    SANCTN015("반려"),
    SANCTN016("승인");

    private final String label;

    SanctionProgress(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }


}
