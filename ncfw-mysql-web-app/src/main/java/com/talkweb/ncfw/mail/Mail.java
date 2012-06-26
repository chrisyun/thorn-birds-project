package com.talkweb.ncfw.mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 * <p>文件名称: 题目名称</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>公    司: 拓维信息系统股份有限公司</p>
 * <p>内容摘要: // 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: // 其它内容的说明</p>
 * <p>完成日期：// 输入完成日期，例：2010年4月30日</p>
 * <p>修改记录1: // 修改历史记录，包括修改日期、修改者及修改内容</p>
 * <pre>
 *    修改日期：
 *    修 改 人：
 *    修改内容：
 * </pre>
 * <p>修改记录2：…</p>
 * @author  陈云
 */
public class Mail {
    private MimeMessage message; //MIME邮件对象
    private Session session; //邮件会话对象
    private Properties props; //系统属性
    private Multipart mp; //Multipart对象,邮件内容,标题,附件等内容均添加到其中后再生成MimeMessage对象
    private Transport transport;
    
    private MailBean mailBean;
    
    public Mail(MailBean mailBean) {
    	this.mailBean =  mailBean;
    	init();
    }

    private void init() {
		props = new Properties(); //获得系统属性对象
		
		Authenticator auth = new Authenticator() {
		    protected PasswordAuthentication getPasswordAuthentication() {
		    	return new PasswordAuthentication(mailBean.getUserName(),mailBean.getPassword());
		    }
		};
		
		props.put("mail.smtp.host",mailBean.getMailHost()); //设置SMTP主机
		
		if(mailBean.isNeedAuth()){
		    props.put("mail.smtp.auth","true");
		}else{
		    props.put("mail.smtp.auth","false");
		}
		
		session = Session.getInstance(props, auth);
		
		try {
		    transport = session.getTransport("smtp");
		    transport.connect(mailBean.getMailHost(), 
			    mailBean.getUserName(), mailBean.getPassword());
		} catch (NoSuchProviderException e) {
		    e.printStackTrace();
		} catch (MessagingException e) {
		    e.printStackTrace();
		}
	
    }
    
    private void createMessage() throws AddressException, MessagingException {
		message = new MimeMessage(session);
		
		//加载发件人地址
		message.setFrom(new InternetAddress(mailBean.getFromAddress()));
		message.setSentDate(new Date());
		
		//加载收件人地址
		message.addRecipients(Message.RecipientType.TO, getAddress(new String[]{mailBean.getToAddress()}));
		
		// 加载标题
		message.setSubject(mailBean.getTitle());
		
		// 向multipart对象中添加邮件的各个部分内容，包括文本内容和附件
		// 设置邮件的文本内容
        MimeBodyPart contentPart = new MimeBodyPart();
        
        contentPart.setContent(mailBean.getContent(),
        	"text/html;charset=GBK");
        
        mp =  new MimeMultipart();
        mp.addBodyPart(contentPart);
	
        message.setContent(mp);
        //保存邮件
        message.saveChanges();
    }
    
    
    public String sendMail(boolean debug) throws MessagingException {
    	// 有了这句便可以在发送邮件的过程中在console处显示过程信息，供调试使
    	// 用（你可以在控制台（console)上看到发送邮件的过程）
		session.setDebug(debug);
		String flag = "success";
		
		try {
		    createMessage();
		    transport.sendMessage(message, message.getAllRecipients());
		} catch (MessagingException e) {
		    flag = e.getMessage();
		    e.printStackTrace();
		} finally {
		    if (null != transport) {
			transport.close();
		    }
		}
		
		return flag;
    }
    
    public Address[] getAddress(String[] address) throws AddressException {
		Address[] addrs = new InternetAddress[address.length];
		for (int i = 0; i < address.length; i++) {
		    addrs[i] = new InternetAddress(address[i]);
		}
		return addrs;
    }
    
    
//    public static void main(String[] args) {
//    	MailBean mailBean = new MailBean("kysb","59881182","mail.mcprc.gov.cn",true,
//				"kysb@mcprc.gov.cn","chenyun@talkweb.com.cn","----","test");
//    	
////		MailBean mailBean = new MailBean("xingbo@ccic.gov.cn","xingbo1981","mail.ccic.gov.cn",true,
////			"xingbo@ccic.gov.cn","chenyun@talkweb.com.cn","<a href=http://www.baidu.com>baidu</a>","邮件发送测试");
//		
//		Mail mail = new Mail(mailBean);
//		
//		try {
//		    mail.sendMail(true);
//		} catch (MessagingException e) {
//		    e.printStackTrace();
//		}
//    }
}
