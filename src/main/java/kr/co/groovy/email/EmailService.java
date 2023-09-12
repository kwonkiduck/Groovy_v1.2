package kr.co.groovy.email;

import kr.co.groovy.vo.EmailVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final EmailMapper mapper;

    public int inputReceivedEmails(EmailVO emailVO) {
        return mapper.inputReceivedEmails(emailVO);
    }

}
