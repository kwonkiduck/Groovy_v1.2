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

    List<EmailVO> getAllReceivedMailsToMe(Map<String, String> map);

    List<EmailVO> getAllReferencedMailsToMe(Map<String, String> map);

    List<EmailVO> getAllSentMailsToMe(Map<String, String> map);

    List<EmailVO> getAllSentMailsByMe(Map<String, String> map);

    int getEmployeeByEmailAddr(String emailAddr);

    int existsMessageNumber(Map<String, Object> map);

    void modifyEmailRedngAt(Map<String, String> map);

    void deleteMails(String emailEtprCode);

}
