package org.cy.thorn.core.util;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.util.Assert;

/**
 * <p>文件名称: RandomUtil.java</p>
 * <p>文件描述: 本类描述</p>
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
public class RandomUtil extends RandomUtils {
	
	private static char[] numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz"
			+ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
			.toCharArray();

	public static final String randomString(int length) {
		Assert.isTrue(length > 0, "The input parameters not legal");
		
		char[] randBuffer = new char[length];
		
		for (int i = 0; i < randBuffer.length; i++) {
			randBuffer[i] = numbersAndLetters[nextInt(71)];
		}
		
		return new String(randBuffer);
	}
	
	public static void main(String[] args) {
		System.out.println(RandomUtil.randomString(32));
	}
}

