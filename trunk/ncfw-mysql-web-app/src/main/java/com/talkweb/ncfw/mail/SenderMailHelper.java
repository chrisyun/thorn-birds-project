package com.talkweb.ncfw.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.talkweb.ncframework.pub.utils.StringUtils;
import com.talkweb.ncframework.pub.utils.spring.SpringContextUtils;


public class SenderMailHelper {
	
	private static Logger log = Logger.getLogger(SenderMailHelper.class);
	
	private static ApplicationContext context = null;

	private static ApplicationContext getApplicationContext () {
		if (context == null) {
			context = SpringContextUtils.getApplicationContext();
		}
		return context;
	}
	
	public static boolean senderMail (MailInfo mail, boolean isAsynchronous) 
		throws MessagingException {
		if (false) {//为异步发送
//			Runnable sendMailTsk = new SendMailTask(mailInfoBean);
//			ThreadPoolTaskExecutor taskExecutor = (ThreadPoolTaskExecutor)getApplicationContext().getBean("taskExecutor");
//			taskExecutor.execute(sendMailTsk);
			return true;
		} else {	//同步发送
			return sendJMail(mail);
		}
	}
	
	private static boolean sendJMail(MailInfo mailInfo) {
		boolean flag = true;
		JavaMailSenderImpl mailSender = (JavaMailSenderImpl) getApplicationContext().getBean("mailSender");
		
		MailBean mailBean = new MailBean("kysb","59881182","mail.mcprc.gov.cn",true,
				"kysb@mcprc.gov.cn",mailInfo.getToAddress()[0],mailInfo.getContent(),mailInfo.getSubject());
		
//		MailBean mailBean = new MailBean(mailSender.getUsername(),mailSender.getPassword(),
//				mailSender.getHost(),true,
//				mailSender.getUsername()+"@mcprc.gov.cn",mailInfo.getToAddress()[0],mailInfo.getContent(),mailInfo.getSubject());
		
		Mail mail = new Mail(mailBean);
		
		try {
		    mail.sendMail(true);
		} catch (MessagingException e) {
			flag = false;
			log.error("seand mail error", e);
		}
		
		return flag;
    }
	
	private static boolean sendMailProcess (MailInfo mail) throws MessagingException {
		JavaMailSenderImpl mailSender = (JavaMailSenderImpl) getApplicationContext().getBean("mailSender");
		String _from 	= StringUtils.isEmpty(mail.getFromAddress()) ? mailSender.getUsername() : mail.getFromAddress();
		String[] _to 	= mail.getToAddress();
		
		log.debug("begin to send mail, mail form " + _from);
		
		String _content = mail.getContent();
			
		try {
			MimeMessage mime = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mime, true, "utf-8");
			helper.setFrom(_from);
			helper.setTo(_to);
			helper.setSubject(mail.getSubject());
			//BouncyCastleEncryptHelper.encryptMail(mime, _content); //邮件加密
			helper.setText(_content, true);
			mailSender.send(mime);
		} catch (Exception e) {
			log.error("send mail error: " + e.getMessage(),e);
			throw new MessagingException(e.getMessage());
		}
		log.debug("send mail successful...");
		return true;
	}


}
