package org.thorn.web.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName: ResponseHeaderUtils
 * @Description:
 * @author chenyun
 * @date 2012-5-29 下午07:38:50
 */
public class ResponseHeaderUtils {

	private static final String EXCEL_CONTENT_TYPE = "application/vnd.ms-excel";
	
	private static final String JSON_CONTENT_TYPE = "text/javascript;charset=utf-8"; 
	
	/**
	 * 
	 * @Description：
	 * @author：chenyun 	        
	 * @date：2012-5-29 下午10:26:57
	 * @param response
	 * @param excelName
	 */
	public static void setExcelResponse(HttpServletResponse response,
			String excelName) {

		// 对文件名作中文处理
		String name = excelName;
		try {
			name = new String(excelName.getBytes("GBK"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			name = excelName;
		}

		name += ".xls";

		response.setContentType(EXCEL_CONTENT_TYPE);
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Content-Disposition", "attachment;filename=" + name
				+ "\"");
	}
	
	public static void setJsonResponse(HttpServletResponse response) {
		response.setContentType(JSON_CONTENT_TYPE);
	}

}
