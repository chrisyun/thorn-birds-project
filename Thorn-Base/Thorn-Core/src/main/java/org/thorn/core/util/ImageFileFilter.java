package org.thorn.core.util;

import java.io.File;
import java.io.FileFilter;

import org.apache.commons.lang.StringUtils;

/** 
 * @ClassName: ZipFileFilter 
 * @Description: 
 * @author chenyun
 * @date 2012-7-30 上午11:46:40 
 */
public class ImageFileFilter implements FileFilter {

	public boolean accept(File pathname) {
		if(pathname.isDirectory()) {
			return false;
		}
		
		String name = pathname.getName();
		if(StringUtils.endsWithIgnoreCase(name, ".gif")
				|| StringUtils.endsWithIgnoreCase(name, ".png")
				|| StringUtils.endsWithIgnoreCase(name, ".jpg")
				|| StringUtils.endsWithIgnoreCase(name, ".jpeg")) {
			return true;
		} else {
			return false;
		}
	}

}

