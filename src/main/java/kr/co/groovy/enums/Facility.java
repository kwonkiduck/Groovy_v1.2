package kr.co.groovy.enums;

public enum Facility {
    FCLTY010("회의실"),
    FCLTY0100("A101"), FCLTY0101("A102"), FCLTY0102("A103"), FCLTY0103("B101"), FCLTY0104("B102"), FCLTY0105("B103"),
    FCLTY011("휴게실"),
    FCLTY0110("R001"), FCLTY0111("R002"), FCLTY0112("R003"), FCLTY0113("R004"), FCLTY0114("R011"), FCLTY0115("R012"), FCLTY0116("R013"), FCLTY0117("R014");

    private String label;

    Facility(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static String getValueByLabel(String label) {
        for (Facility facility : values()) {
            if (facility.getLabel().equals(label)) {
                return facility.name();
            }
        }
        return null;
    }

}
