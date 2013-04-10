package org.thorn.workflow;
/** 
 * @ClassName: WorkflowConfiguration 
 * @Description: 
 * @author chenyun
 * @date 2012-6-18 下午11:38:35 
 */
public interface WorkflowConfiguration {
	
	/** 组织限制，该组织及子组织下的所有人  */
	public final static String LIMIT_SUBORG = "suborg";
	
	/** 组织限制，该组织下的所有人，不包含子组织  */
	public final static String LIMIT_CURORG = "curorg";
	
	/** 无限制 */
	public final static String LIMIT_NONE = "none";
	
	/** 数据类型 */
	public final static String GROUP_ROLE = "role";
	
	public final static String GROUP_ORG = "org";
	
	public final static String GROUP_AREA = "area";
	
	public final static String GROUP_USER = "user";
	
	/** 组织类型*/
	public final static String COMPANY = "COMPANY";
	
	public final static String DEPT = "DEPT";
	
	public final static String ORG = "ORG";
	
	/** 参与者类型*/
	public final static String PP_USER = "USER";
	
	public final static String PP_GROUP = "GROUP";
	
	public final static String START_ACTIVITY_ID = "start";
	
	public final static String PROCESS_CREATER = "creater";
}

