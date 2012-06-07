package org.thorn.attachment.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.thorn.attachment.entity.Attachment;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;
import org.thorn.web.util.ResponseHeaderUtils;

/**
 * @ClassName: AttachmentCotroller
 * @Description:
 * @author chenyun
 * @date 2012-6-6 下午11:42:40
 */
@Controller
public class AttachmentCotroller extends BaseController {

	@RequestMapping("/att/upload")
	public void upload(String fileName,
			@RequestParam("attach") MultipartFile attach,
			HttpServletResponse response) throws IOException {

		StringBuilder json = new StringBuilder("{\"success\":true,");
		json.append("\"message\":\"附件上传成功！\",");
		json.append("\"obj\":\"").append(fileName).append("\"}");

		ResponseHeaderUtils.setHtmlResponse(response);
		response.getWriter().write(json.toString());
		response.getWriter().flush();
	}
	
	@RequestMapping("/att/delete")
	@ResponseBody
	public Status removeAtt(String ids) {
		Status status = new Status();
		
		status.setMessage("附件删除成功！");
		return status;
	}
	
	@RequestMapping("/att/queryAtts")
	@ResponseBody
	public JsonResponse<List<Attachment>> queryAtts(String ids) {
		JsonResponse<List<Attachment>> json = new JsonResponse<List<Attachment>>();
		
		json.setMessage("附件加载成功！");
		
		
		return json;
	}
	
	@RequestMapping("/att/download")
	public void download(String id) {
		
	}
	
	
}
