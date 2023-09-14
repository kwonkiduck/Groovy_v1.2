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

    public List<EmailVO> getAllReceivedMailsToMe(String emailAddr) {
        return mapper.getAllReceivedMailsToMe(emailAddr);
    }

    public List<EmailVO> getAllReferencedMailsToMe(String emailAddr) {
        return mapper.getAllReferencedMailsToMe(emailAddr);
    }

    public List<EmailVO> getAllSentMailsToMe(String emailAddr) {
        return mapper.getAllSentMailsToMe(emailAddr);
    }

    public List<EmailVO> getAllSentMailsByMe(String emailAddr) {
        return mapper.getAllSentMailsByMe(emailAddr);
    }

    public int getEmployeeByEmailAddr(String emailAddr) {
        return mapper.getEmployeeByEmailAddr(emailAddr);
    }

    public int modifyEmailRedngAt(Map<String, String> map) {
        return mapper.modifyEmailRedngAt(map);
    }

}
