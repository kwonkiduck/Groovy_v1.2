package kr.co.groovy.email;

import kr.co.groovy.vo.EmailVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmailMapper {
    int inputReceivedEmails(EmailVO emailVO);

}
