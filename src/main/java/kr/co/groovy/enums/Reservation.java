package kr.co.groovy.enums;

public enum Reservation {
    RESVE010("비예약"), RESVE011("예약");

    private String label;

    Reservation(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
