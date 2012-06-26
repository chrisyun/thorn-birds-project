package com.talkweb.ncfw.mail;

public class MailInfo {
	/**
	 * 发送者
	 */
	private String fromAddress;
	/**
	 * 接收者
	 */
	private String[] toAddress; // 接受者地址
	/**
	 * 邮件主题
	 */
	private String subject;
	/**
	 * 抄送
	 */
	private String[] copyAddress;
	/**
	 * 附件发送时邮件内容
	 */
	private String content;
	/**
	 * 附件地址
	 */
	private String files[];
	
	public MailInfo() {
		
	}
	
	public MailInfo(String fromAddress, String[] toAddress, String subject,
			String[] copyAddress, String content, String files[]) {
		this.fromAddress = fromAddress;
		this.toAddress = toAddress;
		this.subject = subject;
		this.copyAddress = copyAddress;
		this.content = content;
		this.files = files;
	}
	
	public String getFromAddress() {
		return fromAddress;
	}
	public void setFromAddress(String fromAddress) {
		this.fromAddress = fromAddress;
	}
	public String[] getToAddress() {
		return toAddress;
	}
	public void setToAddress(String[] toAddress) {
		this.toAddress = toAddress;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String[] getCopyAddress() {
		return copyAddress;
	}
	public void setCopyAddress(String[] copyAddress) {
		this.copyAddress = copyAddress;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	
}
