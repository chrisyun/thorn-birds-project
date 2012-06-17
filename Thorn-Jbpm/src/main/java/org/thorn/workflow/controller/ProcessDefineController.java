package org.thorn.workflow.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.zip.ZipInputStream;

import javax.servlet.http.HttpServletResponse;

import org.jbpm.api.ProcessDefinitionQuery;
import org.jbpm.api.RepositoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Page;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.web.util.ResponseHeaderUtils;
import org.thorn.workflow.entity.ProcessDefinition;

/**
 * @ClassName: ProcessDefineController
 * @Description:
 * @author chenyun
 * @date 2012-6-17 下午12:50:08
 */
@Controller
public class ProcessDefineController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ProcessDefineController.class);

	@Autowired
	@Qualifier("repositoryService")
	private RepositoryService repository;

	@RequestMapping("/wf/deployProcess")
	public void deployProcess(String fileName,
			@RequestParam("attach") MultipartFile attach,
			HttpServletResponse response) throws IOException {
		fileName = fileName.toLowerCase();

		StringBuilder json = new StringBuilder();

		try {
			if (fileName.endsWith(".zip")) {
				ZipInputStream zis = new ZipInputStream(attach.getInputStream());
				repository.createDeployment()
						.addResourcesFromZipInputStream(zis).deploy();
			} else if (fileName.endsWith(".xml")) {
				repository
						.createDeployment()
						.addResourceFromInputStream(fileName,
								attach.getInputStream()).deploy();
			}

			json.append("{\"success\":true,");
			json.append("\"message\":\"流程发布成功！\"}");
		} catch (Exception e) {
			json.append("{\"success\":false,");
			json.append("\"message\":\"流程发布失败：" + e.getMessage() + "\"}");
			log.error("deployProcess[attach] - " + e.getMessage(), e);
		}

		ResponseHeaderUtils.setHtmlResponse(response);
		response.getWriter().write(json.toString());
		response.getWriter().flush();
	}

	/**
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-6-17 下午04:22:28
	 * @param ids
	 * @return
	 */
	@RequestMapping("/wf/deleteProcessDf")
	@ResponseBody
	public Status deleteProcessDf(String ids) {
		List<String> deployIds = LocalStringUtils.splitStr2Array(ids);

		Status status = new Status();

		try {
			for (String deployId : deployIds) {
				repository.deleteDeploymentCascade(deployId);
			}
			status.setMessage("删除流程定义成功！");
		} catch (Exception e) {
			status.setSuccess(false);
			status.setMessage("删除流程定义失败：" + e.getMessage());
			log.error("deleteProcessDf[String] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/wf/getProcessDfImage")
	public void getProcessImage(String processDfId, HttpServletResponse response) {

		org.jbpm.api.ProcessDefinition processDefinition = repository
				.createProcessDefinitionQuery()
				.processDefinitionId(processDfId).uniqueResult();
		InputStream inputStream = repository.getResourceAsStream(
				processDefinition.getDeploymentId(),
				processDefinition.getImageResourceName());
		byte[] b = new byte[1024];
		int len = -1;
		try {
			while ((len = inputStream.read(b, 0, 1024)) != -1) {
				response.getOutputStream().write(b, 0, len);
			}
		} catch (IOException e) {
			log.error("creat processImage exception : " + e.getMessage(), e);
		}
	}

	/**
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-6-17 下午04:22:32
	 * @param name
	 * @param key
	 * @return
	 */
	@RequestMapping("/wf/getProcessDf")
	@ResponseBody
	public Page<ProcessDefinition> getProcessDf(String name, String key) {

		Page<ProcessDefinition> page = new Page<ProcessDefinition>();

		ProcessDefinitionQuery query = repository
				.createProcessDefinitionQuery();
		if (LocalStringUtils.isNotEmpty(key)) {
			query = query.processDefinitionKey(key);
		}
		if (LocalStringUtils.isNotEmpty(name)) {
			query = query.processDefinitionNameLike(name + "%");
		}

		List<org.jbpm.api.ProcessDefinition> pdList = query.list();

		for (org.jbpm.api.ProcessDefinition pd : pdList) {
			ProcessDefinition pdEntity = new ProcessDefinition();
			pdEntity.setId(pd.getId());
			pdEntity.setDeploymentId(pd.getDeploymentId());
			pdEntity.setDescription(pd.getDescription());
			pdEntity.setImageResourceName(pd.getImageResourceName());
			pdEntity.setKey(pd.getKey());
			pdEntity.setName(pd.getName());
			pdEntity.setSuspended(pd.isSuspended());
			pdEntity.setVersion(pd.getVersion());

			page.getReslutSet().add(pdEntity);
		}

		page.setTotal(pdList.size());
		return page;
	}
}
