package kr.co.groovy.email;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.vo.EmailVO;
import kr.co.groovy.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.*;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.security.Principal;
import java.util.Properties;

@Slf4j
@Controller
@RequestMapping("/email")
@RequiredArgsConstructor
public class EmailController {
    private final EmailService emailService;
    private final EmployeeService employeeService;

    public int inputReceivedEmails(Principal principal, EmailVO emailVO) throws MessagingException, IOException {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        URLName url = getUrlName(employeeVO);
        Session session = null;
        if (session == null) {
            Properties properties = null;
            try {
                properties = System.getProperties();
            } catch (SecurityException e) {
                properties = new Properties();
            }
            session = Session.getInstance(properties, null);
        }
        Store store = session.getStore(url);
        store.connect();
        Folder folder = store.getFolder("inbox");
        folder.open(Folder.READ_ONLY);

        Message[] messages = folder.getMessages();
        for (Message mail : messages) {
            String content = null;
            if (mail.getSubject() != null) {
                content = "";
                if (mail.isMimeType("multipart/*")) {
                    MimeMultipart mimeMultipart = (MimeMultipart) mail.getContent();
                    content = getTextFromMimeMultipart(mimeMultipart);
                } else if (mail.isMimeType("text/*")) {
                    content = mail.getContent().toString();
                }
            }
            emailVO.setEmailFromAddr(String.valueOf(mail.getFrom()[0]));
        }
        return 0;
    }

    private URLName getUrlName(EmployeeVO employeeVO) {
        String host = null;
        int port = 993;
        String emailAddr = employeeVO.getEmplEmail();
        String emailPassword = employeeVO.getEmplPassword();
        if (employeeVO.getEmplEmail().contains("gmail.com")) {
            host = "imap.gmail.com";
        } else if (employeeVO.getEmplEmail().contains("daum.net")) {
            host = "imap.daum.net";
        } else if (employeeVO.getEmplEmail().contains("naver.com")) {
            host = "map.naver.com";
        }

        URLName url = new URLName("imaps", host, port, "INBOX", emailAddr, emailPassword);
        return url;
    }

    private String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws MessagingException, IOException {
        String content = "";
        int count = mimeMultipart.getCount();
        for (int i = 0; i < count; i++) {
            BodyPart bodyPart = mimeMultipart.getBodyPart(i);
            if (bodyPart.isMimeType("text/plain")) {
                content = content + "\n" + bodyPart.getContent();
                break; // without break same text appears twice in my tests
            } else if (bodyPart.isMimeType("text/html")) {
                String html = (String) bodyPart.getContent();
                content = content + "\n" + Jsoup.parse(html).text();
            } else if (bodyPart.getContent() instanceof MimeMultipart) {
                content = content + getTextFromMimeMultipart((MimeMultipart) bodyPart.getContent());
            }
        }
        return content;
    }

}
