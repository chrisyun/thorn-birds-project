package org.thorn.process.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

	private static final String[] AZ = new String[] { "a", "b", "c", "d", "e",
			"f", "g", "h", "i", "j" };

	@Autowired
	@Qualifier("flowService")
	private IFlowService flowService;

	@Autowired
	@Qualifier("projectService")
	private IProjectService projectService;

	@RequestMapping("/getProcessMinds")
	@ResponseBody
	public List<FlowMinds> getProcessMinds(Integer flowId) {

		if (flowId == null) {
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

			if (pid != null) {
				list = flowService.queryCostBudget(pid, flowType);
			}

			CostBudget eqCb = new CostBudget();

			for (Dict dt : details) {

				String detail = dt.getDvalue();
				eqCb.setDetail(detail);

				if (!list.contains(eqCb)) {
					CostBudget cb = new CostBudget();
					cb.setDetail(detail);
					cb.setType(flowType);
					cb.setMoney(0);
					cb.setPid(pid);

					list.add(cb);
				}
			}

		} catch (DBAccessException e) {
			log.error("getBudget[CostBudget] - " + e.getMessage(), e);
		}

		return list;
	}

	@RequestMapping("/exportProcessWord")
	public void exportProcessWord(Integer pid, String flowType,
			HttpSession session, HttpServletResponse response) {

		if (pid == null || StringUtils.isEmpty(flowType)) {
			return;
		}

		String path = session.getServletContext().getRealPath("");

		try {
			if (StringUtils.equals(flowType, ProcessConfiguration.PROJECT_KEY)) {

				ProjectCost pc = projectService.queryProjectCost(pid);
				List<CostBudget> budgets = flowService.queryCostBudget(pid,
						flowType);

				path += "/" + ProcessConfiguration.PROJECT_WORD;

				String words = TextfileUtils.readUTF8Text(path);

				words = words.replaceAll("TprojectNameT",
						StringUtils.defaultString(pc.getProjectName()));
				words = words.replaceAll("TcreaterNameT",
						StringUtils.defaultString(pc.getCreaterName()));
				words = words.replaceAll("TaddressT",
						StringUtils.defaultString(pc.getAddress()));
				words = words.replaceAll("TpostalCodeT",
						StringUtils.defaultString(pc.getPostalCode()));
				words = words.replaceAll("TcontactsT",
						StringUtils.defaultString(pc.getContacts()));
				words = words.replaceAll("TphoneT",
						StringUtils.defaultString(pc.getPhone()));
				words = words.replaceAll("TbankNameT",
						StringUtils.defaultString(pc.getBankName()));
				words = words.replaceAll("TbankT",
						StringUtils.defaultString(pc.getBank()));
				words = words.replaceAll("TbankAccountT",
						StringUtils.defaultString(pc.getBankAccount()));
				words = words.replaceAll("TcompanyCtfT",
						StringUtils.defaultString(pc.getCompanyCtf()));
				words = words.replaceAll("TappReasonT",
						StringUtils.defaultString(pc.getAppReason()));
				words = words.replaceAll("TcontentT",
						StringUtils.defaultString(pc.getContent()));
				words = words.replaceAll("TtargetT",
						StringUtils.defaultString(pc.getTarget()));
				words = words.replaceAll("TusedYearT",
						StringUtils.defaultString(pc.getUsedYear()));

				Double money = pc.getMoney();
				if (money == null) {
					money = 0.0;
				}

				words = words.replaceAll("TmoneyT", String.valueOf(money));
				words = words.replaceAll("TbudgetT",
						StringUtils.defaultString(pc.getBudget()));

				double totalMoney = 0;

				int i = 1;
				for (; i <= budgets.size(); i++) {

					CostBudget bg = budgets.get(i - 1);

					words = words.replaceAll("TdetailO" + AZ[i - 1] + "T",
							StringUtils.defaultString(bg.getDetail()));
					words = words.replaceAll("TremarkO" + AZ[i - 1] + "T",
							StringUtils.defaultString(bg.getRemark()));

					money = bg.getMoney();
					if (money == null) {
						money = 0.0;
					}

					words = words.replaceAll(
							"TbudgetOMoneyO" + AZ[i - 1] + "T",
							String.valueOf(money));
					totalMoney += bg.getMoney();
				}

				for (; i <= 10; i++) {
					words = words.replaceAll("TdetailO" + AZ[i - 1] + "T", "");
					words = words.replaceAll("TremarkO" + AZ[i - 1] + "T", "");
					words = words.replaceAll(
							"TbudgetOMoneyO" + AZ[i - 1] + "T", "");
				}
				words = words.replaceAll("TtotalMoneyT",
						String.valueOf(totalMoney));

				ResponseHeaderUtils.setWordResponse(response,
						ProcessConfiguration.PROJECT_TITLE);
				OutputStream out = response.getOutputStream();
				out.write(words.getBytes());
				out.flush();
			}
		} catch (Exception e) {
			log.error("exportProcessWord[File] - " + e.getMessage(), e);
		}
	}
}
