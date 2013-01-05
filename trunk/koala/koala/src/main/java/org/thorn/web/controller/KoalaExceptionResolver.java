package org.thorn.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;
import org.thorn.core.util.LocalStringUtils;

/** 
 * @ClassName: KoalaExceptionResolver 
 * @Description: 
 * @author chenyun
 * @date 2013-1-5 上午11:39:25 
 */
public class KoalaExceptionResolver extends SimpleMappingExceptionResolver {
	
	static Logger log = LoggerFactory.getLogger(JsonExceptionResolver.class);

	private static final String DEFAULT_JSON_SUFFIX = ".jmt";

	private String json_suffix = DEFAULT_JSON_SUFFIX;
	
	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		
		String uri = request.getRequestURI().toLowerCase();

		log.debug("the request uri : {}", uri);

		if (uri.indexOf(json_suffix) > 0
				&& LocalStringUtils
						.equalsIgnoreCase(
								request.getHeader("x-requested-with"),
								"XMLHttpRequest")) {

			ModelAndView mv = new ModelAndView();

			mv.setView(new MappingJacksonJsonView());
			mv.addObject("success", false);
			mv.addObject("message", ex.getMessage());

			return mv;
		}
		
		return super.resolveException(request, response, handler, ex);
	}


	public String getJson_suffix() {
		return json_suffix;
	}

	public void setJson_suffix(String json_suffix) {
		this.json_suffix = json_suffix;
	}
	
}

