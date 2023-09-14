package kr.co.groovy.email;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.enums.Department;
import kr.co.groovy.vo.EmailVO;
import kr.co.groovy.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.security.Principal;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/email")
@RequiredArgsConstructor
public class EmailController {
    private final EmailService emailService;
    private final EmployeeService employeeService;

    @GetMapping("/all")
    public String getAllMails(Principal principal, EmailVO emailVO, Model model) throws Exception {
        List<EmailVO> list = inputReceivedEmails(principal, emailVO);
        model.addAttribute("list", list);
        return "email/all";
    }

    @GetMapping("/inbox")
    public String getReceivedMails(Principal principal, EmailVO emailVO, Model model) throws Exception {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", employeeVO.getEmplEmail());
        map.put("at", "N");
        List<EmailVO> allReceivedMailsToMe = emailService.getAllReceivedMailsToMe(map);
        List<EmailVO> allReferencedMailsToMe = emailService.getAllReferencedMailsToMe(map);

        List<EmailVO> allReceivedMailList = new ArrayList<>();
        allReceivedMailList.addAll(allReceivedMailsToMe);
        allReceivedMailList.addAll(allReferencedMailsToMe);

        allReceivedMailList.sort(new Comparator<EmailVO>() {
            @Override
            public int compare(EmailVO vo1, EmailVO vo2) {
                Integer emailSn1 = vo1.getEmailSn();
                Integer emailSn2 = vo2.getEmailSn();
                return emailSn1.compareTo(emailSn2) * -1;
            }
        });

        model.addAttribute("list", allReceivedMailList);
        return "email/inbox";
    }

    @GetMapping("/sent")
    public String getAllSentMailsByMe(Principal principal, EmailVO emailVO, Model model) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", employeeVO.getEmplEmail());
        map.put("at", "N");
        List<EmailVO> allSentMailsByMe = emailService.getAllSentMailsByMe(map);
        model.addAttribute("list", allSentMailsByMe);
        return "email/sent";
    }

    @GetMapping("/mine")
    public String getAllSentMailsToMe(Principal principal, EmailVO emailVO, Model model) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", employeeVO.getEmplEmail());
        map.put("at", "N");
        List<EmailVO> allSentMailsToMe = emailService.getAllSentMailsToMe(map);
        model.addAttribute("list", allSentMailsToMe);
        return "email/mine";
    }

    @GetMapping("/trash")
    public String getAllDeletedMails(Principal principal, EmailVO emailVO, Model model) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        List<EmailVO> list = setAllEmailList(employeeVO.getEmplEmail(), "Y");
        model.addAttribute("list", list);
        return "email/trash";
    }

    @PutMapping("/{code}/{emailEtprCode}")
    @ResponseBody
    public String modifyEmailRedngAt(@PathVariable String code, @PathVariable String emailEtprCode, @RequestBody String at) {
        Map<String, String> map = new HashMap<>();
        switch (code) {
            case "redng":
                map.put("emailAtKind", "EMAIL_REDNG_AT");
                break;
            case "imprtnc":
                map.put("emailAtKind", "EMAIL_IMPRTNC_AT");
                break;
            case "delete":
                map.put("emailAtKind", "EMAIL_DELETE_AT");
                break;
        }

        if (at.equals("N")) {
            map.put("at", "Y");
        } else {
            map.put("at", "N");
        }
        map.put("emailEtprCode", emailEtprCode);
        emailService.modifyEmailRedngAt(map);
        return map.get("at");
    }

    @PutMapping ("/{emailEtprCode}")
    @ResponseBody
    public String deleteMail(@PathVariable String emailEtprCode) {
        emailService.deleteMails(emailEtprCode);
        return "success";
    }

    public List<EmailVO> inputReceivedEmails(Principal principal, EmailVO emailVO) throws Exception {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
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

            if (emailService.existsMessageNumber(map) == 0) {
                // 발신부
                String from = String.valueOf(mail.getFrom()[0]);
                if (from.startsWith("=?")) {
                    try {
                        InternetAddress decodedAddress = new InternetAddress(from, true);
                        String decodedEmail = decodedAddress.getAddress();
                        String decodedPersonal = null;

                        if (emailService.getEmployeeByEmailAddr(decodedEmail) == 0) {
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
                emailService.inputReceivedEmailsFrom(emailVO);

                emailVO.setEmailReceivedEmplId(employeeVO.getEmplId());
                emailVO.setEmailRedngAt("N");
                emailVO.setEmailDeleteAt("N");
                emailVO.setEmailImprtncAt("N");
                emailService.inputReceivedStatus(emailVO);

                // 수신부
                try {
                    Address[] toArray = mail.getRecipients(Message.RecipientType.TO);
                    for (Address to : toArray) {
                        emailVO.setEmailToAddr(String.valueOf(to));
                        emailVO.setEmailToReceivedDate(emailVO.getEmailFromSendDate());
                        emailService.inputReceivedEmailsTo(emailVO);
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
                        emailService.inputReceivedEmailsCc(emailVO);
                    }
                } catch (NullPointerException e) {
                    e.getMessage();
                }
            }
        }
        return setAllEmailList(employeeVO.getEmplEmail(), "N");
    }

    private List<EmailVO> setAllEmailList(String emailAddr, String at) {
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", emailAddr);
        map.put("at", at);
        List<EmailVO> allReceivedMails = new ArrayList<>();
        List<EmailVO> receivedMails = emailService.getAllReceivedMailsToMe(map);
        for (EmailVO receivedMail : receivedMails) {
            receivedMail.setEmailBoxName("받은메일함");
        }
        allReceivedMails.addAll(receivedMails);
        List<EmailVO> referencedMails = emailService.getAllReferencedMailsToMe(map);
        for (EmailVO referencedMail : referencedMails) {
            referencedMail.setEmailBoxName("받은메일함");
        }
        allReceivedMails.addAll(referencedMails);
        List<EmailVO> allSentMailsToMe = emailService.getAllSentMailsToMe(map);
        for (EmailVO allSentMailToMe : allSentMailsToMe) {
            allSentMailToMe.setEmailBoxName("내게쓴메일함");
        }
        allReceivedMails.addAll(allSentMailsToMe);
        List<EmailVO> allSentMailsByMe = emailService.getAllSentMailsByMe(map);
        for (EmailVO allSentMailByMe : allSentMailsByMe) {
            allSentMailByMe.setEmailBoxName("보낸메일함");
        }
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

    private URLName getUrlName(EmployeeVO employeeVO) {
        String host = null;
        int port = 995;
        String emailPassword = null;
        String emailAddr = employeeVO.getEmplEmail();
        if (employeeVO.getEmplEmail().contains("gmail.com")) {
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
