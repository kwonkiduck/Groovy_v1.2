package mail;

import kr.co.groovy.vo.EmailVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.junit.Test;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Slf4j
@RequiredArgsConstructor
public class MailTest {
    @Test
    public void 메일_읽기_IMAP() throws MessagingException, IOException {
        String host = "imap.daum.net"; // imap.groovy.co.kr
        String userEmail = "groovytest@daum.net"; // 사번@groovy.co.kr
        String password = "groovy402dditfinal"; // 사원비번
        URLName url = new URLName("imaps", host, 993, "INBOX", userEmail, password);
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
            if (mail.getSubject() != null) {
                System.out.println("---------------------------------");
                log.info("allHeaders: " + mail.getAllHeaders());
                log.info("content: " + mail.getContent().toString());
                log.info("contentType: " + mail.getContentType());
                log.info("dataHandler: " + mail.getDataHandler());
                log.info("description: " + mail.getDescription());
                log.info("disposition: " + mail.getDisposition());
                log.info("fileName: " + mail.getFileName());
                log.info("inputStream: " + mail.getInputStream());
                log.info("lineCount: " + mail.getLineCount());
                log.info("size: " + mail.getSize());
                log.info("allRecipients: " + Arrays.toString(mail.getAllRecipients()));
                log.info("recipients.CC: " + Arrays.toString(mail.getRecipients(Message.RecipientType.CC)));
                log.info("recipients.BCC: " + Arrays.toString(mail.getRecipients(Message.RecipientType.BCC)));
                log.info("recipients.TO: " + Arrays.toString(mail.getRecipients(Message.RecipientType.TO)));
                log.info("flags: " + mail.getFlags());
                log.info("folder: " + mail.getFolder());
                log.info("from: " + mail.getFrom()[0]);
                log.info("messageNember: " + mail.getMessageNumber());
                log.info("receivedDate: " + mail.getReceivedDate());
                log.info("replyTo: " + Arrays.toString(mail.getReplyTo()));
                log.info("sendDate: " + mail.getSentDate());
                log.info("session: " + mail.getSession());
                log.info("subject: " + mail.getSubject());
                System.out.println("---------------------------------");
            }
        }
    }

    @Test
    public void 메일_읽기_pop3() throws MessagingException, IOException {
        List<EmailVO> list = new ArrayList<>();
        String userEmail = "groovytest@daum.net";
        String password = "groovy402dditfinal";
        String host = "pop.daum.net";

        URLName url = new URLName("pop3s", host, 995, "INBOX", userEmail, password);
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

        Folder folder = store.getFolder("INBOX");
        folder.open(Folder.READ_ONLY);

        Message[] messages = folder.getMessages();
        for (Message mail : messages) {

            EmailVO emailVO = new EmailVO();
            String content = "";
            if (mail.isMimeType("multipart/*")) {
                MimeMultipart mimeMultipart = (MimeMultipart) mail.getContent();
                content = getTextFromMimeMultipart(mimeMultipart);
            } else if (mail.isMimeType("text/*")) {
                content = mail.getContent().toString();
            }
            System.out.println("---------------------------------");
            log.info("allHeaders: " + mail.getAllHeaders());
            log.info("content: " + content);
            log.info("contentType: " + mail.getContentType());
            log.info("dataHandler: " + mail.getDataHandler());
            log.info("description: " + mail.getDescription());
            log.info("disposition: " + mail.getDisposition());
            log.info("fileName: " + mail.getFileName());
            log.info("inputStream: " + mail.getInputStream());
            log.info("lineCount: " + mail.getLineCount());
            log.info("size: " + mail.getSize());
            log.info("allRecipients: " + Arrays.toString(mail.getAllRecipients()));
            log.info("flags: " + mail.getFlags());
            log.info("folder: " + mail.getFolder());
            log.info("from: " + mail.getFrom()[0]);
            log.info("messageNember: " + mail.getMessageNumber());
            log.info("receivedDate: " + mail.getReceivedDate());
            log.info("replyTo: " + Arrays.toString(mail.getReplyTo()));
            log.info("sendDate: " + mail.getSentDate());
            log.info("session: " + mail.getSession());
            log.info("subject: " + mail.getSubject());
            System.out.println("---------------------------------");

            list.add(emailVO);
        }
        folder.close();
        store.close();
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

    @Test
    public void 메일주소_디코딩() {
        String encodedAddress = "=?UTF-8?B?64uk7J2M66mU7J28Cg==?= <notice-master@daum.net>";

        try {
            InternetAddress decodedAddress = new InternetAddress(encodedAddress, true);
            String decodedEmail = decodedAddress.getAddress();
            String decodedPersonal = decodedAddress.getPersonal();

            System.out.println("Decoded Email: " + decodedEmail);
            System.out.println("Decoded Personal: " + decodedPersonal);
        } catch (AddressException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void 메일주소_인코딩_테스트() throws UnsupportedEncodingException {
        String emailOwner = "테스트";
        String emailAddr = "example@email.com";

        byte[] encodedBytes = Base64.getEncoder().encode(emailOwner.getBytes());
        String encodedString = new String(encodedBytes);

        System.out.println("Encoded String: " + encodedString + " <" + emailAddr + ">");
    }

}
