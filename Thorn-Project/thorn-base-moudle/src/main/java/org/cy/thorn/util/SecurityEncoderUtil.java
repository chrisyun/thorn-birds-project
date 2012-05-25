package org.cy.thorn.util;

import org.cy.thorn.core.util.spring.SpringContextUtils;
import org.springframework.security.authentication.encoding.PasswordEncoder;

/**
 * <p>文件名称: SecurityEncoderUtil.java</p>
 * <p>文件描述: spring security的加密UTIL类：7b6e08119db708ea613ca241f822a64b(ADMIN的默认密码)</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-31</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class SecurityEncoderUtil {
	
	private static PasswordEncoder passwordEncoder = null;
	
	private static void initPwdEncoder() {
		if(passwordEncoder == null) {
			passwordEncoder = SpringContextUtils.getBean("passwordEncoder");
		}
	}
	
	public static String encodeUserPassword(String password, String userid) {
		initPwdEncoder();
		return passwordEncoder.encodePassword(password.trim(),userid.trim());
	}
	
	
}

