package org.sist.project.domain;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailSender  {

	@Autowired
	protected JavaMailSender mailSender;
	
	public void SendEmail(Email email) throws Exception {

		MimeMessage msg = mailSender.createMimeMessage();
		try {
			msg.setSubject(email.getSubject());
			msg.setText(email.getContent());
			msg.setRecipients(
				RecipientType.TO , 
				InternetAddress.parse(email.getReceiver())
			);

		}catch(MessagingException e) {
			System.out.println("MessagingException");
			throw e;
		}
		try {
			mailSender.send(msg);
		}catch(MailException e) {
			System.out.println("MailException발생");
			throw e;
		}
	}
}