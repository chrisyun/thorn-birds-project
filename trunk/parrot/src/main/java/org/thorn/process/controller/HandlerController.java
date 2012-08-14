package org.thorn.process.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.entity.ProjectCost;
import org.thorn.process.ProcessConfiguration;
import org.thorn.process.entity.FlowMinds;
import org.thorn.process.entity.Process;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

/**
 * @ClassName: HandlerController
 * @Description:
 * @author chenyun
 * @date 2012-8-14 上午09:50:18
 */
@Controller
@RequestMapping("/wf/cm")
public class HandlerController extends BaseController {

	static Logger log = LoggerFactory.getLogger(HandlerController.class);

	@RequestMapping("/handlerProcess")
	@ResponseBody
	public Status handlerProcess(HttpServletRequest request, Integer mindsId,
			String minds, Integer flowId, String flowType, String nextStep,
			String creater, String curActivity, Integer pid, String flowAtts) {
		Status status = new Status();

		User user = SecurityUserUtils.getCurrentUser();
		
		//表单项处理
		Object form = null;
		if(StringUtils.equals(flowType, ProcessConfiguration.PROJECT_KEY)) {
			form = getProjectCost(request, flowAtts, user, pid);
		}
		
		
		// 流程环节处理
		Process process = ActivityUtils.dealWithActivity(flowId, flowType,
				user, nextStep, creater, curActivity, pid);
		
		// 处理流程意见
		FlowMinds flowMinds = new FlowMinds();
		flowMinds.setActivityName(curActivity);
		flowMinds.setFlowId(flowId);
		flowMinds.setId(mindsId);
		flowMinds.setUserId(user.getUserId());
		flowMinds.setUserName(user.getUserName());
		flowMinds.setMind(minds);

		return status;
	}
	
	
	private ProjectCost getProjectCost(HttpServletRequest request, String flowAtts, User user, Integer pid) {
		
		ProjectCost pc = new ProjectCost();
		
		if(pid == null) {
			pc.setCreater(user.getUserId());
			pc.setCreaterName(user.getUserName());
			pc.setProvince(user.getArea());
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			pc.setApplyTime(df.format(new Date()));
		} else {
			pc.setId(pid);
		}
		pc.setAttids(flowAtts);
		
		String projectId = request.getParameter("pc_projectId");
		pc.setProjectId(Integer.parseInt(projectId));
		
		String projectName = request.getParameter("pc_projectName");
		pc.setProjectName(projectName);
		
		String year = request.getParameter("pc_year");
		pc.setYear(Integer.parseInt(year));
		
		String address = request.getParameter("pc_address");
		pc.setAddress(address);
		
		String postalCode = request.getParameter("pc_postalCode");
		pc.setPostalCode(postalCode);
		
		String contacts = request.getParameter("pc_contacts");
		pc.setContacts(contacts);
		
		String phone = request.getParameter("pc_phone");
		pc.setPhone(phone);
		
		String bankName = request.getParameter("pc_bankName");
		pc.setBankName(bankName);
		
		String bank = request.getParameter("pc_bank");
		pc.setBank(bank);
		
		String bankAccount = request.getParameter("pc_bankAccount");
		pc.setBankAccount(bankAccount);
		
		String companyCtf = request.getParameter("pc_companyCtf");
		pc.setCompanyCtf(companyCtf);
		
		String appReason = request.getParameter("pc_appReason");
		pc.setAppReason(appReason);
		
		String content = request.getParameter("pc_content");
		pc.setContent(content);
		
		String target = request.getParameter("pc_target");
		pc.setTarget(target);
		
		String usedYear = request.getParameter("pc_usedYear");
		pc.setUsedYear(usedYear);
		
		String budget = request.getParameter("pc_budget");
		pc.setBudget(budget);
		
		String money = request.getParameter("pc_money");
		pc.setMoney(Double.parseDouble(money));
		
		return pc;
	}

}
