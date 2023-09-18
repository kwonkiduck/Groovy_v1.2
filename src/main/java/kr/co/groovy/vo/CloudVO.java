package kr.co.groovy.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CloudVO {
	
	private String cloudFileCode;
	private String cloudFileName;
	private int cloudFileSize;
	private Date cloudUploadDate;
	private String s3BucketName;
	private String s3ObjectKey;
	private String cloudEmplId;
	private String cloudFileType;
}
