package org.cy.thorn.dao.incrementer;

import org.cy.thorn.core.util.RandomUtil;

/**
 * <p>文件名称: RandomIncrementer.java</p>
 * <p>文件描述: 随机数增长期</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-9-29</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class RandomIncrementer {
	
	private static int suffixLen = 10;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：生成随机主键
	 * @return
	 */
	public static synchronized String getNextKey() {
		String currentTimeMillisStr = new Long(System.currentTimeMillis()).toString();
		return currentTimeMillisStr + RandomUtil.randomString(suffixLen);
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：生成一组随机主键
	 * @param count 主键个数
	 * @return
	 */
	public synchronized static String[] getPrimaryKeyArray (int count) {
		String currentTimeMillisStr = new Long(System.currentTimeMillis()).toString();
		String[] pkSeqArray = new String[count];
		
		for (int i = 0;i < count;i++) {
			pkSeqArray[i] = currentTimeMillisStr + RandomUtil.randomString(suffixLen);
		}
		
		return pkSeqArray;
	}
}

