package org.thorn.core.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @ClassName: DateTimeUtils
 * @Description:
 * @author chenyun
 * @date 2013-2-18 上午10:31:37
 */
public class DateTimeUtils {
	
	private static SimpleDateFormat timeDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private static SimpleDateFormat dateDf = new SimpleDateFormat("yyyy-MM-dd");
	
	public static String getCurrentTime() {
		return timeDf.format(new Date());
	}

	public static String getCurrentDate() {
		return dateDf.format(new Date());
	}
	
	public static Date formatTime(String time) throws ParseException {
		return timeDf.parse(time);
	}
	
	public static Date formatDate(String date) throws ParseException {
		return dateDf.parse(date);
	}

}
