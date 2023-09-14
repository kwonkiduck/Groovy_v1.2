package mail;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.junit.Test;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.util.Arrays;
import java.util.Properties;

@Slf4j
@RequiredArgsConstructor
public class MailTest {
    @Test
    public void mailReadPop3() throws MessagingException, IOException {
        String host = "pop.naver.com"; // imap.groovy.co.kr
        String userEmail = "groovytest@naver.com"; // 사번@groovy.co.kr
        String password = "BowwowBowwow402"; // 사원비번

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
            System.out.println("--------------------------");
            System.out.println(mail.getSubject());
            System.out.println(mail.getContent());
            System.out.println(Arrays.toString(mail.getFrom()));
            System.out.println(Arrays.toString(mail.getRecipients(Message.RecipientType.TO)));
            System.out.println(mail.getContentType());
            System.out.println("--------------------------");

        }
    }

    private String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws MessagingException, IOException {
        String content = "";
        int count = mimeMultipart.getCount();
        for (int i = 0; i < count; i++) {
            BodyPart bodyPart = mimeMultipart.getBodyPart(i);
            if (bodyPart.getContentType().contains("plain")) {
                content = content + "\n" + bodyPart.getContent();
                break; // without break same text appears twice in my tests
            } else if (bodyPart.getContentType().contains("html")) {
                String html = (String) bodyPart.getContent();
                content = content + "\n" + Jsoup.parse(html).text();
            } else if (bodyPart.getContent() instanceof MimeMultipart) {
                content = content + getTextFromMimeMultipart((MimeMultipart) bodyPart.getContent());
            }
        }
        return content;
    }

    @Test
    public void mailAddrDecoding() {
        String encodedAddress = "=?UTF-8?B?IuuEpOydtOuyhOuplOydvCI=?= <navermail_noreply@navercorp.com>";

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


}
