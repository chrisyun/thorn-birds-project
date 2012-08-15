package org.thorn.process.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.entity.CostBudget;
import org.thorn.app.entity.ProjectCost;
import org.thorn.app.service.IProjectService;
import org.thorn.core.util.TextfileUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.entity.Dict;
import org.thorn.process.ProcessConfiguration;
import org.thorn.process.entity.FlowMinds;
import org.thorn.process.service.IFlowService;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.web.util.DDUtils;
import org.thorn.web.util.ResponseHeaderUtils;

/** 
 * @ClassName: ProcessExtendController 
 * @Description: 
 * @author chenyun
 * @date 2012-8-13 下午04:22:36 
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessExtendController extends BaseController {
	
	static Logger log = LoggerFactory.getLogger(ProcessExtendController.class);
	
	@Autowired
	@Qualifier("flowService")
	private IFlowService flowService;
	
	@Autowired
	@Qualifier("projectService")
	private IProjectService projectService;
	
	@RequestMapping("/getProcessMinds")
	@ResponseBody
	public List<FlowMinds> getProcessMinds(Integer flowId) {
		
		if(flowId == null) {
			return null;
		}
		
		List<FlowMinds> list = new ArrayList<FlowMinds>();
		
		try {
			list = flowService.queryFlowMinds(flowId);
		} catch (DBAccessException e) {
			log.error("getProcessMinds[FlowMinds] - " + e.getMessage(), e);
		}
		
		return list;
	}
	
	@RequestMapping("/deleteProcess")
	@ResponseBody
	public Status deleteProcess(String id, String flowType, String pid) {
		Status status = new Status();
		
		try {
			flowService.deleteProcess(id, flowType, pid);
			status.setMessage("流程删除成功!");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteProcess[String] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping("/getBudget")
	@ResponseBody
	public List<CostBudget> getBudget(Integer pid, String flowType) {
		List<CostBudget> list = new ArrayList<CostBudget>();
		
		try {
			List<Dict> details = DDUtils.queryDd("BUDGET_DETAIL");
			
			if(pid != null) {
				list = flowService.queryCostBudget(pid, flowType);
			}
			
			for(Dict dt : details) {
				
				String detail = dt.getDvalue();
				if(!list.contains(detail)) {
					CostBudget cb = new CostBudget();
					cb.setDetail(detail);
					cb.setType(flowType);
					cb.setMoney(0);
					
					list.add(cb);
				}
			}
			
		} catch (DBAccessException e) {
			log.error("getBudget[CostBudget] - " + e.getMessage(), e);
		}
		
		return list;
	}
	
	@RequestMapping("/exportProcessWord")
	public void exportProcessWord(Integer pid, String flowType, ServletContext context, HttpServletResponse response) {
		
		String path = context.getRealPath("/");
		
		try {
			if(StringUtils.equals(flowType, ProcessConfiguration.PROJECT_KEY)) {
				
				ProjectCost pc = projectService.queryProjectCost(pid);
				List<CostBudget> budgets = flowService.queryCostBudget(pid, flowType);
				
				path += ProcessConfiguration.PROJECT_WORD;
				
				String words = TextfileUtils.readUTF8Text(path);
				
				words = words.replaceAll("$projectName$", pc.getProjectName());
				words = words.replaceAll("$createrName$", pc.getCreaterName());
				words = words.replaceAll("$address$", pc.getAddress());
				words = words.replaceAll("$postalCode$", pc.getPostalCode());
				words = words.replaceAll("$contacts$", pc.getContacts());
				words = words.replaceAll("$phone$", pc.getPhone());
				words = words.replaceAll("$bankName$", pc.getBankName());
				words = words.replaceAll("$bank$", pc.getBank());
				words = words.replaceAll("$bankAccount$", pc.getBankAccount());
				words = words.replaceAll("$companyCtf$", pc.getCompanyCtf());
				words = words.replaceAll("$appReason$", pc.getAppReason());
				words = words.replaceAll("$content$", pc.getContent());
				words = words.replaceAll("$target$", pc.getTarget());
				words = words.replaceAll("$usedYear$", pc.getUsedYear());
				words = words.replaceAll("$money$", String.valueOf(pc.getMoney()));
				words = words.replaceAll("$budget$", pc.getBudget());
				
				double totalMoney = 0;
				
				int i = 0;
				for (; i < budgets.size(); i++) {
					
					CostBudget bg = budgets.get(i);
					
					words = words.replaceAll("$detail_"+i+"$", bg.getDetail());
					words = words.replaceAll("$remark_"+i+"$", bg.getRemark());
					words = words.replaceAll("$budget_Money_"+i+"$", String.valueOf(bg.getMoney()));
					totalMoney += bg.getMoney();
				}
				
				for (; i <= 10; i++) {
					words = words.replaceAll("$detail_"+i+"$", "");
					words = words.replaceAll("$remark_"+i+"$", "");
					words = words.replaceAll("$budget_Money_"+i+"$", "");
				}
				words = words.replaceAll("$totalMoney$", String.valueOf(totalMoney));
				
				ResponseHeaderUtils.setWordResponse(response, ProcessConfiguration.PROJECT_TITLE);
				OutputStream out = response.getOutputStream();
				out.write(words.getBytes());
				out.flush();
			}
		} catch (Exception e) {
			log.error("exportProcessWord[File] - " + e.getMessage(), e);
		}
	}
}

