package org.thorn.workflow.tag;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.thorn.core.context.SpringContext;
import org.thorn.workflow.entity.FlowType;
import org.thorn.workflow.service.IFlowTypeService;

/** 
 * @ClassName: WfCNNameTag 
 * @Description: 
 * @author chenyun
 * @date 2012-6-24 下午02:40:02 
 */
public class WfCNNameTag extends TagSupport {

	/** */
	private static final long serialVersionUID = 2093408107482963274L;

	public int doStartTag() throws JspException {

		try {
			JspWriter out = this.pageContext.getOut();

			StringBuffer wfJson = new StringBuffer("[");
			
			IFlowTypeService service = SpringContext.getBean("flowTypeService");
			List<FlowType> list = service.queryByType(null);
			
			for (FlowType ft : list) {
				wfJson.append("['").append(ft.getFlowKey()).append("','")
						.append(ft.getFlowName()).append("','")
						.append(ft.getFlowType()).append("'],");
			}

			String json = wfJson.toString();
			if (json.endsWith(",")) {
				json = json.substring(0, json.length() - 1);
			}
			json += "]";

			out.print(json);

		} catch (Exception e) {
			throw new JspException("getWfCNName Resolving Tag Exception", e);
		}

		return super.doStartTag();
	}
	
}

