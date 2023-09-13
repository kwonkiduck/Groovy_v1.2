package kr.co.groovy.email;

import kr.co.groovy.vo.EmailVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EmailMapper {
    void inputReceivedEmailsFrom(EmailVO emailVO);

    void inputReceivedEmailsTo(EmailVO emailVO);

    void inputReceivedEmailsCc(EmailVO emailVO);

    void inputReceivedStatus(EmailVO emailVO);

    List<EmailVO> getAllReceivedMailsToMe(String emailAddr);

    List<EmailVO> getAllReferencedMailsToMe(String emailAddr);

    List<EmailVO> getAllSentMailsToMe(String emailAddr);

    List<EmailVO> getAllSentMailsByMe(String emailAddr);

    int getEmployeeByEmailAddr(String emailAddr);

    int existsMessageNumber(Map<String, Object> map);

    int modifyEmailRedngAt(Map<String, String> map);

}
