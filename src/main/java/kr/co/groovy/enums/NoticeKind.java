package kr.co.groovy.enums;

public enum NoticeKind {
    IMPORTANT("important.png", "중요"),
    NOTICE("notice.png", "공지"),
    EVENT("event.png", "행사"),
    OBITUARY("obituary.png", "부고");

    private String iconFileName;
    private String label;

    NoticeKind(String iconFileName, String label) {
        this.iconFileName = iconFileName;
        this.label = label;
    }

    public static String getCategoryLabel(String iconFileName) {
        for (NoticeKind category : values()) {
            if (category.iconFileName.equals(iconFileName)) {
                return category.label;
            }
        }
        return "기타";
    }
}
