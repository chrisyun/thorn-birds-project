package org.thorn.workflow.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessInstanceQuery;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.model.ActivityCoordinates;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.Page;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.entity.ProcessInstance;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * @ClassName: ProcessMonitorController
 * @Description:
 * @author chenyun
 * @date 2012-6-17 下午08:22:56
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessMonitorController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ProcessMonitorController.class);

	@Autowired
	@Qualifier("repositoryService")
	private RepositoryService repository;

	@Autowired
	@Qualifier("executionService")
	private ExecutionService execution;
	
	@RequestMapping("/getProcessInstPage")
	@ResponseBody
	public Page<ProcessInstance> getProcessInstancePage(String processDfId,
			String instanceId, String instanceKey, long start, long limit,
			String sort, String dir) {
		Page<ProcessInstance> page = new Page<ProcessInstance>();

		try {
			ProcessInstanceQuery query = execution.createProcessInstanceQuery();

			if (LocalStringUtils.isNotEmpty(processDfId)) {
				query = query.processDefinitionId(processDfId);
			}
			if (LocalStringUtils.isNotEmpty(instanceId)) {
				query = query.processInstanceId(instanceId);
			}
			if (LocalStringUtils.isNotEmpty(instanceKey)) {
				query = query.processInstanceKey(instanceKey);
			}
			if (LocalStringUtils.isNotEmpty(sort)) {

				if (LocalStringUtils.equals(dir, Configuration.ORDER_ASC)) {
					query = query.orderAsc(sort);
				} else {
					query = query.orderDesc(sort);
				}

			} else {
//				query = query.orderDesc("end");
			}

			long total = query.count();
			page.setTotal(total);

			if (total > 0) {
				query = query.page((int) start, (int) limit);

				List<org.jbpm.api.ProcessInstance> piList = query.list();
				for (org.jbpm.api.ProcessInstance pi : piList) {
					ProcessInstance piEntity = new ProcessInstance();
					piEntity.setId(pi.getId());
					piEntity.setKey(pi.getKey());
					piEntity.setName(pi.getName());
					piEntity.setState(pi.getState());
					piEntity.setProcessDefinitionId(pi.getProcessDefinitionId());
					piEntity.setPriority(pi.getPriority());
					piEntity.setProcessInstance(pi.getIsProcessInstance());
					piEntity.setEnded(pi.isEnded());
					piEntity.setSuspended(pi.isSuspended());

					Set<String> activityNames = pi.findActiveActivityNames();
					String activityName = "";
					for (String name : activityNames) {
						activityName += name + ",";
					}
					if (activityName.endsWith(",")) {
						activityName = activityName.substring(0,
								activityName.length() - 1);
					}
					piEntity.setActiveActivityName(activityName);

					page.getReslutSet().add(piEntity);
				}
			}

		} catch (Exception e) {
			log.error(
					"getProcessInstancePage[ProcessInstance] - "
							+ e.getMessage(), e);
		}

		return page;
	}
	
	@RequestMapping("/deleteProcessInst")
	@ResponseBody
	public Status deleteProcessInstance(String ids) {
		List<String> instanceIds = LocalStringUtils.splitStr2Array(ids);
		Status status = new Status();
		
		try {
			
			for(String id : instanceIds) {
				execution.deleteProcessInstanceCascade(id);
			}
			status.setMessage("删除流程实例成功！");
		} catch (Exception e) {
			status.setSuccess(false);
			status.setMessage("删除流程实例失败：" + e.getMessage());
			log.error("deleteProcessInstance[String] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping("/cancelProcessInst")
	@ResponseBody
	public Status cancelProcessInstance(String ids, String reason) {
		List<String> instanceIds = LocalStringUtils.splitStr2Array(ids);
		Status status = new Status();
		
		try {
			
			for(String id : instanceIds) {
				execution.endProcessInstance(id, reason);
			}
			status.setMessage("结束流程实例成功！");
		} catch (Exception e) {
			status.setSuccess(false);
			status.setMessage("结束流程实例失败：" + e.getMessage());
			log.error("cancelProcessInstance[String] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping("/getProcessInstImage")
	public void getProcessInstImage(String processInstId, HttpServletResponse response) throws IOException {
		
		org.jbpm.api.ProcessInstance processInstance = execution.findProcessInstanceById(processInstId);   
		  
		String processDfId = processInstance.getProcessDefinitionId();   
		ProcessDefinition processDefinition = repository.createProcessDefinitionQuery()
			.processDefinitionId(processDfId).uniqueResult();   
		  
		Set<String> activityNames = processInstance.findActiveActivityNames();   
		
		String resource = processDefinition.getImageResourceName();
		
		BufferedImage image = null;
		
		if(LocalStringUtils.isEmpty(resource)) {
			//自己画一个提醒图片
			int weight = 350;
			int height = 100;
			image = new BufferedImage(weight, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = image.createGraphics();
			g.setFont(new Font("", Font.PLAIN, 30));

			//设置字体颜色
			g.setColor(new Color(255, 0, 0));
			g.drawString("该流程无可查看的流程图", 10, 50);
			g.dispose();
			
		} else {
			InputStream is = repository.getResourceAsStream(   
				    processDefinition.getDeploymentId(), resource);   
			image = ImageIO.read(is);   
			  
			for (String activityName : activityNames) {   
			    ActivityCoordinates ac = repository.getActivityCoordinates(processInstance.getProcessDefinitionId(), activityName);   
			  
			    Graphics g = image.getGraphics();
			    g.setColor(new Color(255, 0, 0));
			    g.drawRect(ac.getX(), ac.getY(), ac.getWidth(), ac.getHeight());
			    g.dispose();
			}
		}
		
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
		encoder.encode(image); 
	}
}
