package org.thorn.web;

import java.io.File;

import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.security.web.util.UrlMatcher;

import junit.framework.TestCase;

/**
 * @ClassName: UrlMatchTest
 * @Description:
 * @author chenyun
 * @date 2012-6-1 上午11:50:22
 */
public class UrlMatchTest extends TestCase {

	public void testjs() {
		String a = "/amk/cddlk/kl.js";
		String b = "/**/*.js";

		UrlMatcher urlMatcher = new AntUrlPathMatcher();
		System.out.println(urlMatcher.pathMatchesUrl(b, a));

	}
	
	public void testUrlSper() {
		String a = "\\asas\\sasas\\asas";
		
		System.out.println(a.replaceAll(File.separator, "/"));
	}

}
