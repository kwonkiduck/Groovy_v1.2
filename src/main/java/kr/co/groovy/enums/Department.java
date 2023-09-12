package kr.co.groovy.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum Department {
    DEPT010("인사"), DEPT011("회계"), DEPT012("영업"), DEPT013("홍보"), DEPT014("총무"), DEPT015("대표");
    private final String label;

    Department(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }

    public static String getValueByLabel(String label) {
        for (Department department : values()) {
            if (department.label().equals(label)) {
                return department.name();
            }
        }
        return null;
    }
}
