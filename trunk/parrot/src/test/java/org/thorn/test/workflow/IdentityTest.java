package com.parrot.test.workflow;

import java.io.IOException;

import org.thorn.workflow.identity.MyGroupDefine;

import junit.framework.TestCase;

/** 
 * @ClassName: IdentityTest 
 * @Description: 
 * @author chenyun
 * @date 2012-6-19 下午10:12:02 
 */
public class IdentityTest extends TestCase {
	
	
	public void testGroupDf() {
		String groupId = "{\"groupType\":\"org\",\"groupId\":\"000987\",\"limit\":\"suborg\",\"limitCode\":\"\"}";
		
		try {
			MyGroupDefine df = MyGroupDefine.getInstance(groupId);
			
			System.out.println(df.getGroupId());
			System.out.println(df.getGroupType());
			System.out.println(df.getLimit());
			System.out.println(df.getLimitCode());
			System.out.println(df.isLimited());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}

