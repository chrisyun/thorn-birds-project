package org.cy.thorn.security;
/**
 * <p>文件名称: SecurityConstant.java</p>
 * <p>文件描述: security框架中定义的系统常量</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-1</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public interface SecurityConstant {
	/**
	 * 验证码存放在session中的id
	 */
	public static final String AUTHCODE_SESSION_ID = "ValidateCode";
	/**
	 * 验证码在form中的id
	 */
	public static final String AUTHCODE_FROM_ID = "ValidateCode";
	/**
	 * 验证码图片的宽度
	 */
	public static final int AUTHCODE_IMAGE_WIDTH = 80;
	/**
	 * 验证码图片的长度
	 */
	public static final int AUTHCODE_IMAGE_HEIGHT = 30;
	/**
	 * 验证码的位数
	 */
	public static final int AUTHCODE_NUM_LENGTH = 4;
	/**
	 * 是否
	 */
	public static final String IF_OR_NOT = "YES";
	/**
	 * 系统管理员角色ID
	 */
	public static final String SYS_ADMIN_ROLE = "SYSADMIN";
}

