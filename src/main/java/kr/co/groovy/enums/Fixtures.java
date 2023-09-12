package kr.co.groovy.enums;

public enum Fixtures {
    FXTRS010("프로젝터"), FXTRS011("화이트보드"), FXTRS012("스크린"), FXTRS013("소화기");

    private String label;

    Fixtures(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
