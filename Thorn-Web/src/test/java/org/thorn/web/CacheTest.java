package org.thorn.web;

import org.thorn.core.context.SpringContext;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.service.IDataDictService;

import junit.framework.TestCase;

/** 
 * @ClassName: CacheTest 
 * @Description: 
 * @author chenyun
 * @date 2012-6-1 下午05:56:28 
 */
/** 
 * @ClassName: CacheTest 
 * @Description: 
 * @author chenyun
 * @date 2012-6-1 下午05:56:37 
 *  
 */
public class CacheTest extends TestCase {
	
	private IDataDictService service;
	
	public void setUp() {
		SpringContext sp = new SpringContext();
		sp.setApplicationContext("Thorn-Spring.xml");
		
		service = SpringContext.getBean("ddService");
	}
	
	public void testCache() {
		System.out.println("000000000");
		for (int i = 0; i < 10; i++) {
			try {
				service.queryDdList("AREA");
			} catch (DBAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}

