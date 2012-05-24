package org.thorn.security;

import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.thorn.core.context.SpringContext;

/** 
 * @ClassName: SecurityEncoderUtils 
 * @Description: 
 * @author chenyun
 * @date 2012-5-6 下午01:53:55 
 */
public class SecurityEncoderUtils {
	private static PasswordEncoder passwordEncoder = null;
	
	private synchronized static void initPwdEncoder() {
		if(passwordEncoder == null) {
			passwordEncoder = SpringContext.getBean(SecurityConfiguration.SPRING_ENCODER_BEAN);
		}
	}
	
	public static String encodeUserPassword(String password, String userid) {
		initPwdEncoder();
		return passwordEncoder.encodePassword(password.trim(),userid.trim());
	}
}

