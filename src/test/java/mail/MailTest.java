package mail;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.jsoup.Jsoup;
import org.junit.Test;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.Properties;

@Slf4j
@RequiredArgsConstructor
public class MailTest {
    @Test
    public void mailReadPop3() throws MessagingException, IOException {
        String host = "imap.daum.net"; // imap.groovy.co.kr
        String userEmail = "groovytest@daum.net"; // 사번@groovy.co.kr
        String password = "groovy402dditfinal"; // 사원비번

        URLName url = new URLName("imaps", host, 993, "INBOX", userEmail, password);
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

        Folder folder = store.getFolder("INBOX");
        folder.open(Folder.READ_ONLY);

        Message[] messages = folder.getMessages();
        for (Message mail : messages) {
            System.out.println("--------------------------");
            System.out.println("mail.getSubject() = " + mail.getSubject());
            Multipart multipart = (Multipart) mail.getContent();
            for (int i = 0; i < multipart.getCount(); i++) {
                BodyPart bodyPart = multipart.getBodyPart(i);
                if (Part.ATTACHMENT.equalsIgnoreCase(bodyPart.getDisposition())) {
                    if (bodyPart.getContent().getClass().equals(MimeMultipart.class)) {
                        MimeMultipart mimeMultipart = (MimeMultipart) bodyPart.getContent();
                        for (int j = 0; j < multipart.getCount(); j++) {
                            if (mimeMultipart.getBodyPart(j).getFileName() != null) {
                                printFileContents(mimeMultipart.getBodyPart(j));
                            }
                        }
                    }
                } else {
                    printFileContents(bodyPart);
                }
            }
            System.out.println("--------------------------");
        }
        folder.close();
        store.close();
    }

    private static void printFileContents(BodyPart bodyPart) throws IOException, MessagingException {
        InputStream is = bodyPart.getInputStream();

        StringWriter stringWriter = new StringWriter();
        IOUtils.copy(is, stringWriter);
        System.out.println("File Content: " + stringWriter.toString());
    }

    private String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws MessagingException, IOException {
        String content = "";
        int count = mimeMultipart.getCount();
        for (int i = 0; i < count; i++) {
            BodyPart bodyPart = mimeMultipart.getBodyPart(i);
            if (bodyPart.getContentType().contains("plain")) {
                content = content + "\n" + bodyPart.getContent();
                break;
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
