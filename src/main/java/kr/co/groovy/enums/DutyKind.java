package kr.co.groovy.enums;

public enum DutyKind {
    DUTY010("회의"), DUTY011("팀"), DUTY012("개인"), DUTY013("교육"), DUTY014("기타");

    private String label;

    DutyKind(String label) { this.label = label; }

    public String getLabel() { return label; }

    public static String getValueOfByLabel( String label ) {
        for (DutyKind dutyKind :  values()) {
            if (dutyKind.getLabel().equals(label)) {
                return dutyKind.name();
            }
        }
        return null;
    }

    public static String getLabelByValue( String value ) {
        for (DutyKind dutyKind : values()) {
            if (dutyKind.name().equals(value)) {
                return dutyKind.getLabel();
            }
        }
        return null;
    }
}
