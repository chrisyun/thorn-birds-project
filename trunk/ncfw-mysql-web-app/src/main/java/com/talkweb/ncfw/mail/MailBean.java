package com.talkweb.ncfw.mail;
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
public class MailBean {
    private String userName;
    private String password;
    private String mailHost;
    private boolean needAuth;//smtp是否需要认证
    private String fromAddress;
    private String toAddress;
    private String content;
    private String title;
    
    public MailBean(String userName,String password, String mailHost, boolean needAuth, 
	    String fromAddress, String toAddress, String content, String title) {
	this.userName = userName;
	this.password = password;
	this.mailHost = mailHost;
	this.needAuth = needAuth;
	this.fromAddress = fromAddress;
	this.toAddress = toAddress;
	this.content = content;
	this.title = title;
    }
    
    
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getMailHost() {
        return mailHost;
    }
    public void setMailHost(String mailHost) {
        this.mailHost = mailHost;
    }
    public boolean isNeedAuth() {
        return needAuth;
    }
    public void setNeedAuth(boolean needAuth) {
        this.needAuth = needAuth;
    }
    public String getFromAddress() {
        return fromAddress;
    }
    public void setFromAddress(String fromAddress) {
        this.fromAddress = fromAddress;
    }
    public String getToAddress() {
        return toAddress;
    }
    public void setToAddress(String toAddress) {
        this.toAddress = toAddress;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    
}
