package kr.co.groovy.email;

import kr.co.groovy.employee.EmployeeService;
import kr.co.groovy.vo.EmailVO;
import kr.co.groovy.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
        List<EmailVO> list = emailService.inputReceivedEmails(principal, emailVO);
        model.addAttribute("list", list);
        return "email/allList";
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
        return "email/inboxList";
    }

    @GetMapping("/sent")
    public String getAllSentMailsByMe(Principal principal, EmailVO emailVO, Model model) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", employeeVO.getEmplEmail());
        map.put("at", "N");
        List<EmailVO> allSentMailsByMe = emailService.getAllSentMailsByMe(map);
        model.addAttribute("list", allSentMailsByMe);
        return "email/sentList";
    }

    @GetMapping("/mine")
    public String getAllSentMailsToMe(Principal principal, EmailVO emailVO, Model model) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        Map<String, String> map = new HashMap<>();
        map.put("emailAddr", employeeVO.getEmplEmail());
        map.put("at", "N");
        List<EmailVO> allSentMailsToMe = emailService.getAllSentMailsToMe(map);
        model.addAttribute("list", allSentMailsToMe);
        return "email/mineList";
    }

    @GetMapping("/trash")
    public String getAllDeletedMails(Principal principal, EmailVO emailVO, Model model) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        List<EmailVO> list = emailService.setAllEmailList(employeeVO.getEmplEmail(), "Y");
        model.addAttribute("list", list);
        return "email/trashList";
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

    @PutMapping("/{emailEtprCode}")
    @ResponseBody
    public String deleteMail(@PathVariable String emailEtprCode) {
        emailService.deleteMails(emailEtprCode);
        return "success";
    }

    @GetMapping("/write")
    public String loadWritePage() {
        return "email/sendMail";
    }

    @PostMapping("/sent")
    @ResponseBody
    public String inputSentEmail(Principal principal, EmailVO emailVO, MultipartFile[] emailFiles) {
        EmployeeVO employeeVO = employeeService.loadEmp(principal.getName());
        String emplEmail = employeeVO.getEmplEmail();
        JavaMailSenderImpl mailSender = null;
        if (emplEmail.contains("naver.com")) {
            mailSender = emailService.naverMailSender(emplEmail, "BowwowBowwow402");
        } else if (emplEmail.contains("gmail.com")) {
            mailSender = emailService.googleMailSender(emplEmail, "zwhfanbijftbggwx");
        } else if (emplEmail.contains("daum.net")) {
            mailSender = emailService.daumMailSender(emplEmail, "groovy402dditfinal");
        }

        List<String> emplIdToList = emailVO.getEmplIdToList();
        for (String emplId : emplIdToList) {
            EmployeeVO emailToEmpl = employeeService.loadEmp(emplId);
            emplIdToList.clear();
            emplIdToList.add(emailToEmpl.getEmplEmail());
        }
        List<String> toList = new ArrayList<>(emplIdToList);
        toList.addAll(emailVO.getEmailToAddrList());
        String[] toArr = new String[toList.size()];
        toArr = toList.toArray(new String[0]);

        List<String> emplIdCcList = emailVO.getEmplIdCcList();
        for (String emplId : emplIdCcList) {
            EmployeeVO emailCcEmpl = employeeService.loadEmp(emplId);
            emplIdCcList.clear();
            emplIdCcList.add(emailCcEmpl.getEmplEmail());
        }
        List<String> ccList = new ArrayList<>(emplIdCcList);
        ccList.addAll(emailVO.getEmailCcAddrList());
        String[] ccArr = new String[toList.size()];
        ccArr = ccList.toArray(new String[0]);

        try {
            assert mailSender != null;
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(toArr);
            helper.setCc(ccArr);
            helper.setFrom(emplEmail);
            helper.setSubject(emailVO.getEmailFromSj());
            helper.setText(emailVO.getEmailFromCn(), true);

            for (MultipartFile emailFile : emailFiles) {
                String fileName = StringUtils.cleanPath(emailFile.getOriginalFilename());
                helper.addAttachment(MimeUtility.encodeText(fileName, "UTF-8", "B"), new ByteArrayResource(IOUtils.toByteArray(emailFile.getInputStream())));
            }
            mailSender.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public String getUnreadMailCount(Principal principal, Model model) {
        int unreadMailCount = emailService.getUnreadMailCount(principal.getName());
        log.info(String.valueOf(unreadMailCount));
        model.addAttribute("unreadMailCount", unreadMailCount);
        return "tiles/aside";
    }


    @PostMapping("/mine")
    @ResponseBody
    public String inputMineEmail() {
        return null;
    }

    @GetMapping("/{emailEtprCode")
    public EmailVO getEmail(@PathVariable String emailEtprCode) {
        return null;
    }


}
