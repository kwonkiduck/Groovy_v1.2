package kr.co.groovy.enums;

public enum VacationKind {

    YRYC010("연차"),
    YRYC011("공가"),
    YRYC0110("여름휴가"),
    YRYC0111("생일"),
    YRYC0112("경사"),
    YRYC0113("조사"),
    YRYC0114("병가"),
    YRYC020("오전반차"),
    YRYC021("오후반차"),
    YRYC022("하루종일"),
    YRYC030("미상신"),
    YRYC031("상신"),
    YRYC032("승인");
    private final String label;

    VacationKind(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }


}




