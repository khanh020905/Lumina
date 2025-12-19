package Service;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class MailService {

    private static final String MAIL_HOST = "smtp.gmail.com";
    private static final String MAIL_PORT = "587";
    private static final String MAIL_USERNAME = "lenguyenquockhanh57@gmail.com";
    private static final String MAIL_NAME = "LUVINA@Course";
    private static final String APP_PASSWORD = "fwmywceyjilhkten";

    public boolean sendMail(String email, String otp) {
        Properties prop = new Properties();

        prop.put("mail.smtp.host", MAIL_HOST);
        prop.put("mail.smtp.port", MAIL_PORT);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MAIL_USERNAME, APP_PASSWORD);
            }
        });

        try {
            Message msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(MAIL_USERNAME, MAIL_NAME));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            msg.setSubject("Here is your OTP code");
            msg.setText("Your OTP is: " + otp + "\nValid for 5 minutes.");
            Transport.send(msg);
            System.out.println("OTP sent to: " + email);
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public static void main(String[] args) {
        MailService mail = new MailService();

        mail.sendMail("lenguyenquockhanh57@gmail.com", "123456");
    }
}
