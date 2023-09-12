package kr.co.groovy.enums;

public enum Hipass {
    HIPASS010("가능"), HIPASS011("불가능");
    private String label;

    Hipass(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static String getValueByLabel(String label) {
        for (Hipass hipass : values()) {
            if (hipass.getLabel().equals(label)) {
                return hipass.name();
            }
        }
        return null;
    }
}
