package kr.co.groovy.enums;

public enum DutyProgress {
    DUTY030("업무 전"), DUTY031("업무 중"), DUTY032("업무 완");

    private String label;

    DutyProgress(String label) { this.label = label; }

    public String getLabel() { return label; }

    public static String getLabelByValue( String value ) {
        for (DutyProgress dutyProgress : values()) {
            if (dutyProgress.name().equals(value)) {
                return dutyProgress.getLabel();
            }
        }
        return null;
    }
}
