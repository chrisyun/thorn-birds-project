package org.thorn.process.controller;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.thorn.process.ProcessConfiguration;
import org.thorn.user.entity.User;

/** 
 * @ClassName: ActivityUtils 
 * @Description: 
 * @author chenyun
 * @date 2012-8-13 上午10:33:49 
 */
public class ActivityUtils {
	
	private static final String TO_PROVINCE = "送省厅审批";
	
	private static final String TO_CENTRE = "送非遗司审批";
	
	private static final String TO_SUCCESS = "审批通过";
	
	private static final String RETO_PROVINCE = "打回省厅重新审批";
	
	private static final String RETO_APPLY = "打回申报单位修改重新申报";
	
	public static Set<String> getNextStep(User user, String curActivity) {
		
		Set<String> nextStep = new HashSet<String>();
		
		if(StringUtils.equals(curActivity, ProcessConfiguration.ACTIVITY_CREATE)
				|| StringUtils.equals(curActivity, ProcessConfiguration.ACTIVITY_SAVE)) {
			
			if(StringUtils.equals(user.getOrgCode(),ProcessConfiguration.CENTRE_ORG_CODE)) {
				nextStep.add(TO_CENTRE);
			} else {
				nextStep.add(TO_PROVINCE);
			}
		} else if(StringUtils.equals(curActivity, ProcessConfiguration.ACTIVITY_PROVINCE)) {
			nextStep.add(TO_CENTRE);
			nextStep.add(RETO_APPLY);
		} else if(StringUtils.equals(curActivity, ProcessConfiguration.ACTIVITY_CENTRE)) {
			nextStep.add(TO_SUCCESS);
			nextStep.add(RETO_PROVINCE);
		}
		
		return nextStep;
	}
	
	
}

