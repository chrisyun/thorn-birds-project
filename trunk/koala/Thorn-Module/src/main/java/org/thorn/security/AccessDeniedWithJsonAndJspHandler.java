package org.thorn.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;
import org.thorn.web.util.ResponseHeaderUtils;

/**
 * @ClassName: AccessDeniedWithJsonAndJspHandler
 * @Description: 对于ajax请求返回json，对于jsp请求交由父类进行处理
 * @author chenyun
 * @date 2012-5-30 下午11:26:28
 */
public class AccessDeniedWithJsonAndJspHandler extends AccessDeniedHandlerImpl {

	static Logger log = LoggerFactory
			.getLogger(AccessDeniedWithJsonAndJspHandler.class);

	private static final String DEFAULT_JSON_SUFFIX = ".jmt";

	private String json_suffix = DEFAULT_JSON_SUFFIX;

	@Override
	public void handle(HttpServletRequest request,
			HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException,
			ServletException {
		
		String url = request.getServletPath();

		int firstQuestionMarkIndex = url.indexOf("?");
		if (firstQuestionMarkIndex != -1) {
			url = url.substring(0, firstQuestionMarkIndex);
		}
		
		log.debug("the request url : {}", url);

		if (url.indexOf(json_suffix) > 0
				|| StringUtils.equalsIgnoreCase(
								request.getHeader("x-requested-with"),
								"XMLHttpRequest")) {
			StringBuilder json = new StringBuilder("{\"success\":false,");
			json.append("\"message\":\"访问被拒绝，");
			json.append(accessDeniedException.getMessage());
			json.append(" 您无权限访问本页面！\"}");

			ResponseHeaderUtils.setJsonResponse(response);
			response.getWriter().write(json.toString());
			response.getWriter().flush();
		} else {
			super.handle(request, response, accessDeniedException);
		}
	}

	public void setJson_suffix(String json_suffix) {
		this.json_suffix = json_suffix;
	}

}
