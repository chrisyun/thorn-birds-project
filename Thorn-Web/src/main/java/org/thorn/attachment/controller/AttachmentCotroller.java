package org.thorn.attachment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;

/** 
 * @ClassName: AttachmentCotroller 
 * @Description: 
 * @author chenyun
 * @date 2012-6-6 下午11:42:40 
 */
@Controller
public class AttachmentCotroller extends BaseController {
	
	@RequestMapping("/att/upload")
	@ResponseBody
	public JsonResponse<String> upload(String fileName, CommonsMultipartFile attach) {
		
		JsonResponse<String> json = new JsonResponse<String>();
		json.setMessage("附件上传成功！");
		json.setObj(fileName);
		
		return json;
	}
	
}

