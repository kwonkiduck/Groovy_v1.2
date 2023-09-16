package kr.co.groovy.email;

import kr.co.groovy.vo.EmailVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final EmailMapper mapper;

    public void inputReceivedEmailsFrom(EmailVO emailVO) {
        mapper.inputReceivedEmailsFrom(emailVO);
    }

    public void inputReceivedEmailsTo(EmailVO emailVO) {
        mapper.inputReceivedEmailsTo(emailVO);
    }

    public void inputReceivedEmailsCc(EmailVO emailVO) {
        mapper.inputReceivedEmailsCc(emailVO);
    }

    public void inputReceivedStatus(EmailVO emailVO) {
        mapper.inputReceivedStatus(emailVO);
    }

    public int existsMessageNumber(Map<String, Object> map) {
        return mapper.existsMessageNumber(map);
    }

    public List<EmailVO> getAllReceivedMailsToMe(Map<String, String> map) {
        return mapper.getAllReceivedMailsToMe(map);
    }

    public List<EmailVO> getAllReferencedMailsToMe(Map<String, String> map) {
        return mapper.getAllReferencedMailsToMe(map);
    }

    public List<EmailVO> getAllSentMailsToMe(Map<String, String> map) {
        return mapper.getAllSentMailsToMe(map);
    }

    public List<EmailVO> getAllSentMailsByMe(Map<String, String> map) {
        return mapper.getAllSentMailsByMe(map);
    }

    public int getEmployeeByEmailAddr(String emailAddr) {
        return mapper.getEmployeeByEmailAddr(emailAddr);
    }

    public void modifyEmailRedngAt(Map<String, String> map) {
        mapper.modifyEmailRedngAt(map);
    }

    public void deleteMails(String emailEtprCode) {
        mapper.deleteMails(emailEtprCode);
    }

}
