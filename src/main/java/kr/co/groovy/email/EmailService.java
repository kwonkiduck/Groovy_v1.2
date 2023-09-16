package kr.co.groovy.email;

import kr.co.groovy.employee.EmployeeMapper;
import kr.co.groovy.enums.Department;
import kr.co.groovy.vo.EmailVO;
import kr.co.groovy.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmailService {
    private final EmailMapper emailMapper;
    private final EmployeeMapper employeeMapper;
    private final String uploadPath;

    public void inputReceivedEmailsFrom(EmailVO emailVO) {
        emailMapper.inputReceivedEmailsFrom(emailVO);
    }

    public void inputReceivedEmailsTo(EmailVO emailVO) {
        emailMapper.inputReceivedEmailsTo(emailVO);
    }

    public void inputReceivedEmailsCc(EmailVO emailVO) {
        emailMapper.inputReceivedEmailsCc(emailVO);
    }

    public void inputReceivedStatus(EmailVO emailVO) {
        emailMapper.inputReceivedStatus(emailVO);
    }

    public int existsMessageNumber(Map<String, Object> map) {
        return emailMapper.existsMessageNumber(map);
    }

    public List<EmailVO> getAllReceivedMailsToMe(Map<String, String> map) {
        return emailMapper.getAllReceivedMailsToMe(map);
    }

    public List<EmailVO> getAllReferencedMailsToMe(Map<String, String> map) {
        return emailMapper.getAllReferencedMailsToMe(map);
    }

    public List<EmailVO> getAllSentMailsToMe(Map<String, String> map) {
        return emailMapper.getAllSentMailsToMe(map);
    }

    public List<EmailVO> getAllSentMailsByMe(Map<String, String> map) {
        return emailMapper.getAllSentMailsByMe(map);
    }

    public int getEmployeeByEmailAddr(String emailAddr) {
        return emailMapper.getEmployeeByEmailAddr(emailAddr);
    }

    public void modifyEmailRedngAt(Map<String, String> map) {
        emailMapper.modifyEmailRedngAt(map);
    }

    public void deleteMails(String emailEtprCode) {
        emailMapper.deleteMails(emailEtprCode);
    }

    public int getUnreadMailCount(String emplId) {
        return emailMapper.getUnreadMailCount(emplId);
    }

    public JavaMailSenderImpl googleMailSender(String email, String password) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername(email);
        mailSender.setPassword(password);

        Properties javaMailProperties = new Properties();
        javaMailProperties.put("mail.smtp.starttls.enable", "true");
        javaMailProperties.put("mail.smtp.auth", "true");
        javaMailProperties.put("mail.transport.protocol", "smtp");
        javaMailProperties.put("mail.debug", "true");
        javaMailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        javaMailProperties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        mailSender.setJavaMailProperties(javaMailProperties);
        return mailSender;
    }

    public JavaMailSenderImpl naverMailSender(String email, String password) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.naver.com");
        return getMailSender(email, password, mailSender);
    }

    public JavaMailSenderImpl daumMailSender(String email, String password) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.daum.net");
        return getMailSender(email, password, mailSender);
    }

    public JavaMailSenderImpl getMailSender(String email, String password, JavaMailSenderImpl mailSender) {
        mailSender.setPort(465);
        mailSender.setUsername(email);
        mailSender.setPassword(password);

        Properties javaMailProperties = new Properties();
        javaMailProperties.put("mail.smtp.auth", "true");
        javaMailProperties.put("mail.smtp.starttls.enable", "true");
        javaMailProperties.put("mail.smtps.checkserveridentity", "true");
        javaMailProperties.put("mail.smtps.ssl.trust", "*");
        javaMailProperties.put("mail.debug", "true");
        javaMailProperties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        mailSender.setJavaMailProperties(javaMailProperties);

        return mailSender;
    }

    public List<EmailVO> inputReceivedEmails(Principal principal, EmailVO emailVO) throws Exception {
        EmployeeVO employeeVO = employeeMapper.loadEmp(principal.getName());
        URLName url = getUrlName(employeeVO);

        Session session = null;
        Properties properties = null;
        try {
            properties = System.getProperties();
        } catch (SecurityException e) {
            properties = new Properties();
        }
        session = Session.getInstance(properties, null);
        Store store = session.getStore(url);
        store.connect();
        Folder folder = store.getFolder("inbox");
        folder.open(Folder.READ_ONLY);

        Map<String, Object> map = new HashMap<>();
        Message[] messages = folder.getMessages();
        for (Message mail : messages) {
            emailVO.setEmailSn(mail.getMessageNumber());
            map.put("emailSn", emailVO.getEmailSn());
            map.put("nowEmailAddr", employeeVO.getEmplEmail());

            if (emailMapper.existsMessageNumber(map) == 0) {
                // 발신부
                String from = String.valueOf(mail.getFrom()[0]);
                if (from.startsWith("=?")) {
                    try {
                        InternetAddress decodedAddress = new InternetAddress(from, true);
                        String decodedEmail = decodedAddress.getAddress();
                        String decodedPersonal = null;

                        if (emailMapper.getEmployeeByEmailAddr(decodedEmail) == 0) {
                            decodedPersonal = decodedAddress.getPersonal();
                        } else {
                            decodedPersonal = decodedAddress.getPersonal();
                            String dept = Department.valueOf(employeeVO.getCommonCodeDept()).label();
                            decodedPersonal = decodedPersonal + " (" + dept + "팀)";
                        }
                        decodedPersonal = decodedPersonal.replaceAll("[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]", "");
                        from = decodedPersonal + "<" + decodedEmail + ">";
                    } catch (AddressException e) {
                        e.getMessage();
                    }
                }

                String subject = mail.getSubject();
                if (subject == null || subject.isEmpty()) {
                    subject = "(제목 없음)";
                }

                String content = "";
                if (mail.getSubject() != null) {
                    if (mail.isMimeType("multipart/*")) {
                        MimeMultipart mimeMultipart = (MimeMultipart) mail.getContent();
                        content = getTextFromMimeMultipart(mimeMultipart);
                    } else if (mail.isMimeType("text/*")) {
                        content = mail.getContent().toString();
                    }
                }

                emailVO.setEmailFromAddr(from);
                emailVO.setEmailFromSj(subject);
                emailVO.setEmailFromCn(content);
                emailVO.setEmailFromCnType(mail.getContentType());
                emailVO.setEmailFromSendDate(mail.getSentDate());
                emailVO.setEmailFromTmprStreAt("N");
                emailMapper.inputReceivedEmailsFrom(emailVO);

                emailVO.setEmailReceivedEmplId(employeeVO.getEmplId());
                emailVO.setEmailRedngAt("N");
                emailVO.setEmailDeleteAt("N");
                emailVO.setEmailImprtncAt("N");
                emailVO.setEmailRealDeleteAt("N");
                emailMapper.inputReceivedStatus(emailVO);

                // 수신부
                try {
                    Address[] toArray = mail.getRecipients(Message.RecipientType.TO);
                    for (Address to : toArray) {
                        emailVO.setEmailToAddr(String.valueOf(to));
                        emailVO.setEmailToReceivedDate(emailVO.getEmailFromSendDate());
                        emailMapper.inputReceivedEmailsTo(emailVO);
                    }
                } catch (NullPointerException e) {
                    e.getMessage();
                }

                // 참조부
                try {
                    Address[] ccArray = mail.getRecipients(Message.RecipientType.CC);
                    for (Address cc : ccArray) {
                        emailVO.setEmailCcAddr(String.valueOf(cc));
                        emailVO.setEmailCcReceivedDate(emailVO.getEmailFromSendDate());
                        emailMapper.inputReceivedEmailsCc(emailVO);
                    }
                } catch (NullPointerException e) {
                    e.getMessage();
                }
            }
        }
        return setAllEmailList(employeeVO.getEmplEmail(), "N");
    }

    private URLName getUrlName(EmployeeVO employeeVO) {
        String host = null;
        int port = 995;
        String emailPassword = null;
        String emailAddr = employeeVO.getEmplEmail();
        if (employeeVO.getEmplEmail().contains("gmail.com")) {
            emailPassword = "zwhfanbijftbggwx";
            host = "pop.gmail.com";
        } else if (employeeVO.getEmplEmail().contains("daum.net")) {
            emailPassword = "groovy402dditfinal";
            host = "pop.daum.net";
        } else if (employeeVO.getEmplEmail().contains("naver.com")) {
            emailPassword = "BowwowBowwow402";
            host = "pop.naver.com";
        }

        return new URLName("pop3s", host, port, "INBOX", emailAddr, emailPassword);
    }

    public List<EmailVO> setAllEmailList(String emailAddr, String at) {
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", emailAddr);
        map.put("at", at);
        List<EmailVO> receivedMails = emailMapper.getAllReceivedMailsToMe(map);
        for (EmailVO receivedMail : receivedMails) {
            receivedMail.setEmailBoxName("받은메일함");
        }
        List<EmailVO> referencedMails = emailMapper.getAllReferencedMailsToMe(map);
        for (EmailVO referencedMail : referencedMails) {
            referencedMail.setEmailBoxName("받은메일함");
        }
        List<EmailVO> allSentMailsToMe = emailMapper.getAllSentMailsToMe(map);
        for (EmailVO allSentMailToMe : allSentMailsToMe) {
            allSentMailToMe.setEmailBoxName("내게쓴메일함");
        }
        List<EmailVO> allSentMailsByMe = emailMapper.getAllSentMailsByMe(map);
        for (EmailVO allSentMailByMe : allSentMailsByMe) {
            allSentMailByMe.setEmailBoxName("보낸메일함");
        }
        List<EmailVO> allReceivedMails = new ArrayList<>();
        allReceivedMails.addAll(receivedMails);
        allReceivedMails.addAll(referencedMails);
        allReceivedMails.addAll(allSentMailsToMe);
        allReceivedMails.addAll(allSentMailsByMe);

        allReceivedMails.sort(new Comparator<EmailVO>() {
            @Override
            public int compare(EmailVO vo1, EmailVO vo2) {
                Integer emailSn1 = vo1.getEmailSn();
                Integer emailSn2 = vo2.getEmailSn();
                return emailSn1.compareTo(emailSn2) * -1;
            }
        });
        return allReceivedMails;
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

    public String inputNotice(EmailVO vo, MultipartFile[] notiFiles) {
        int emailSeq = emailMapper.getEmailSeq();
        SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        Date currentDate = new java.util.Date();
        String formattedDate = sdf.format(currentDate);

        String emailEtprCode = "EMAIL-" + emailSeq + "-" + formattedDate;
        vo.setEmailEtprCode(emailEtprCode);
//        mapper.inputNotice(vo);

        try {
            String path = uploadPath + "/email";
            log.info("notice path: " + path);
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdirs()) {
                    log.info("폴더 생성 성공");
                } else {
                    log.info("폴더 생성 실패");
                }
            }
            for (MultipartFile emailFile : notiFiles) {
                String originalFileName = emailFile.getOriginalFilename();
                String extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
                String newFileName = UUID.randomUUID() + "." + extension;

                File saveFile = new File(path, newFileName);
                emailFile.transferTo(saveFile);

                long fileSize = emailFile.getSize();
                HashMap<String, Object> map = new HashMap<>();
                map.put("notiEtprCode", emailEtprCode);
                map.put("originalFileName", originalFileName);
                map.put("newFileName", newFileName);
                map.put("fileSize", fileSize);
                emailMapper.uploadEmailFile(map);
                log.info("공지 파일 등록 성공");
            }
        } catch (Exception e) {
            log.info("공지 파일 등록 실패");
        }
        return emailEtprCode; //알림 url
    }

}
