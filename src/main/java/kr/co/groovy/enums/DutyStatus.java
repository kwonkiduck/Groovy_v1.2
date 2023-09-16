package kr.co.groovy.enums;

public enum DutyStatus {
    DUTY020("대기"), DUTY021("승인"), DUTY022("거절");

    private String label;

    DutyStatus(String label) { this.label = label; }

    public String getLabel() { return label; }

    public static String getValueOfByLabel( String label ) {
        for (DutyStatus dutyStatus :  values()) {
            if (dutyStatus.getLabel().equals(label)) {
                return dutyStatus.name();
            }
        }
        return null;
    }

    public static String getLabelByValue( String value ) {
        for (DutyStatus dutyStatus : values()) {
            if (dutyStatus.name().equals(value)) {
                return dutyStatus.getLabel();
            }
        }
        return null;
    }


}
