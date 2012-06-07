package org.thorn.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsHtmlView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;
import org.thorn.web.util.ResponseHeaderUtils;

/**
 * @ClassName: JSONExceptionResolver
 * @Description:
 * @author chenyun
 * @date 2012-5-27 下午01:46:53
 */
public class JsonExceptionResolver implements HandlerExceptionResolver, Ordered {

	static Logger log = LoggerFactory.getLogger(JsonExceptionResolver.class);

	private static final String DEFAULT_JSON_SUFFIX = ".jmt";

	private String json_suffix = DEFAULT_JSON_SUFFIX;

	private int order = Ordered.HIGHEST_PRECEDENCE;

	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {

		String uri = request.getRequestURI().toLowerCase();

		log.debug("the request uri : {}", uri);

		if (uri.indexOf(json_suffix) > 0) {

			ModelAndView mv = new ModelAndView();

			mv.setView(new MappingJacksonJsonView());
			mv.addObject("success", false);
			mv.addObject("message", ex.getMessage());
			
			if(request instanceof DefaultMultipartHttpServletRequest) {
//				mv.setView(new JasperReportsHtmlView());
			}
			
			return mv;
		}

		return null;
	}

	public String getJson_suffix() {
		return json_suffix;
	}

	public void setJson_suffix(String json_suffix) {
		this.json_suffix = json_suffix;
	}

	public int getOrder() {
		return this.order;
	}

	public void setOrder(int order) {
		this.order = order;
	}
}
