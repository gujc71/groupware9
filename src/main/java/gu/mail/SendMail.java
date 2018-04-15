package gu.mail;

//http://blog.daum.net/toddryu/49

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SendMail {

    static final Logger LOGGER = LoggerFactory.getLogger(SendMail.class);
	private String SMTP_HOST;
	private String SMTP_PORT;		// "465";
	private String SMTP_ACCOUNT;
	private String SMTP_PASSWD;
	private String SMTP_USERNM;
	private String smtpssl = "true";

	public static void main(String args[]) throws Exception {

		SendMail sm = new SendMail("", "", "", "", "");
		sm.send(true, new String[]{""}, new String[]{}, new String[]{}, "test", "body1111");
	}
	
	public SendMail(String host, String port, String user, String usernm, String pw) {
		this.SMTP_HOST = host;
		this.SMTP_PORT = port;
		this.SMTP_ACCOUNT = user;
		this.SMTP_USERNM = usernm;
		this.SMTP_PASSWD = pw;
		if (!"465".equals(port)) smtpssl="false";
	}
	
	public void send(boolean debug, String[] recipients, String[] cc, String[] bcc, String subject, String contents) throws MessagingException {
		Properties props = new Properties();
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.auth", "true");
		props.put("mail.debug", "true"); 
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.EnableSSL.enable", "true");
		props.put("mail.smtp.port", SMTP_PORT);

		props.put("mail.smtp.socketFactory.port", SMTP_PORT);
		if ("true".equals(smtpssl)){
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		}
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(SMTP_ACCOUNT, SMTP_PASSWD);
			}
		});

		session.setDebug(debug);

		MimeMessage msg = new MimeMessage(session);
		InternetAddress addressFrom;
		try {
			addressFrom = new InternetAddress(SMTP_ACCOUNT, SMTP_USERNM, "UTF-8");
			msg.setFrom(addressFrom);
		} catch (UnsupportedEncodingException e) {
			LOGGER.error("send mail");
		}

		msg.setRecipients(Message.RecipientType.TO, mail2Addr(recipients));
		
		if (cc.length>0){
			msg.setRecipients(Message.RecipientType.CC,  mail2Addr(cc));
		}
		if (bcc.length>0){
			msg.setRecipients(Message.RecipientType.BCC, mail2Addr(bcc));
		}
		
		msg.setSubject(subject, "UTF-8"); 
		msg.setContent(contents, "text/html;charset=UTF-8");
		
		Transport.send(msg);
	}
	
	public InternetAddress[] mail2Addr(String[] maillist) {
		InternetAddress[] addressTo = new InternetAddress[maillist.length];
		try {
			for (int i = 0; i < maillist.length; i++) {
				if (!"".equals(maillist[i])) addressTo[i] = new InternetAddress(maillist[i]);
			}
		} catch (AddressException e) {
            LOGGER.error("mail2Addr");
		}

		return addressTo;
	}
	
	public String get_mailFile(String filename){
		File fileDir = new File(filename);
		BufferedReader in;
		String mailBody="";
		try {
			in = new BufferedReader( new InputStreamReader( new FileInputStream(fileDir), "UTF8"));
			String line = null;
			while((line = in.readLine()) != null ) {
				mailBody += line;
			}
			in.close();
		} catch ( FileNotFoundException e1) {
            LOGGER.error("mailFile");
		} catch (IOException e) {
            LOGGER.error("mailFile");
		}		
		return mailBody;
	}
	
}
