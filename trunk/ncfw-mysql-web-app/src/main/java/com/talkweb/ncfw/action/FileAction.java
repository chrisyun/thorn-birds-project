package com.talkweb.ncfw.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import org.apache.log4j.Logger;
import org.jfree.util.Log;

import com.talkweb.ncframework.pub.common.ProccessResultBean;
import com.talkweb.ncframework.pub.exceptions.DAOException;
import com.talkweb.ncframework.pub.utils.PropertiesUtils;
import com.talkweb.ncframework.pub.utils.StringUtils;
import com.talkweb.ncframework.pub.web.common.utils.HttpServletUtils;
import com.talkweb.ncframework.pub.web.struts2.BaseAction;
import com.talkweb.ncfw.entity.CommonFile;
import com.talkweb.ncfw.file.IFileService;

/**
 * <p>文件名称: FileAction.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-23</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class FileAction extends BaseAction {
	
	private static Logger logger = Logger.getLogger(FileAction.class);
	private File uploadFile;
	private String uploadFileFileName;
	private IFileService fileService;
	
	public File getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getUploadFileFileName() {
		return uploadFileFileName;
	}
	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}
	public IFileService getFileService() {
		return fileService;
	}
	public void setFileService(IFileService fileService) {
		this.fileService = fileService;
	}
	
	public String uploadFile() {
		String fileLimitSize = StringUtils.isEmpty(PropertiesUtils.getProperty("commonfile.file.fileSizeMaxLimit")) 
			? "10240" : PropertiesUtils.getProperty("commonfile.file.fileSizeMaxLimit");
		
		long sysLimitSize = Long.parseLong(fileLimitSize);
		
		if(uploadFile == null || uploadFile.length() == 0) {
			ProccessResultBean resultBean = new ProccessResultBean(false, "文件内容不能为空");
			HttpServletUtils.outJsonWhenUpload(this.getResponse(), resultBean);
			return null;
		}
		
//		if(sysLimitSize*1024 < uploadFile.length()) {
//			ProccessResultBean resultBean = new ProccessResultBean(false, "文件大小超过最大限制："+sysLimitSize+"KB");
//			HttpServletUtils.outJsonWhenUpload(this.getResponse(), resultBean);
//			return null;
//		}
		
		CommonFile file = null;
		try {
			file = fileService.saveFile(uploadFile, uploadFileFileName, this.getParameter("pid"),this.getParameter("tableid"),this.getParameter("busatttype"));
			file.setSuccess(true);
		} catch (Exception e) {
			logger.error("文件上传出错：", e);
			ProccessResultBean resultBean = new ProccessResultBean(false, "文件上传失败");
			HttpServletUtils.outJsonWhenUpload(this.getResponse(), resultBean);
			return null;
		}
		
		HttpServletUtils.outJsonWhenUpload(this.getResponse(), file);
		return null;
	}
	
	public String downloadFile() throws IOException {
		String downAttid = this.getParameter("downAttid");
		if(StringUtils.isEmpty(downAttid)) {
			ProccessResultBean resultBean = new ProccessResultBean(false, "文件ID为空");
			HttpServletUtils.outJsonWhenUpload(this.getResponse(), resultBean);
			return null;
		}
		
		CommonFile cf = fileService.downloadFile(downAttid);
		
		if(cf == null || cf.getAttach() == null) {
			ProccessResultBean resultBean = new ProccessResultBean(false, "未找到对应文件");
			HttpServletUtils.outJsonWhenUpload(this.getResponse(), resultBean);
			return null;
		}
		
		getResponse().setContentType("application/octet-stream");
		OutputStream out = null;
		try {
			out = getResponse().getOutputStream();
			getResponse().addHeader("Content-Disposition", 
					(new StringBuilder("attachment;filename=").append(URLEncoder.encode(cf.getAttname(), "UTF-8")).toString()));
			
			FileInputStream in = new FileInputStream(cf.getAttach());
			byte b[] = new byte[2048];
			for (int i = 0; (i = in.read(b)) > 0;) {
				out.write(b, 0, i);
			}
			
			out.flush();
		} catch (IOException e) {
			Log.error("附件下载失败",e);
		} finally {
			out.close();
		}
		
		return null;
		
	}
	
	public String queryFiles() {
		String pid = this.getParameter("pid");
		String tableid = this.getParameter("tableid");
		String busatttype = this.getParameter("busatttype");
		
		if(StringUtils.isEmpty(pid)) {
			ProccessResultBean resultBean = new ProccessResultBean(false, "PID为空");
			HttpServletUtils.outJsonWhenUpload(this.getResponse(), resultBean);
			return null;
		}
		
		List<CommonFile> list = fileService.queryFile(pid,tableid,busatttype);
		HttpServletUtils.outJsonArray(this.getResponse(), list);
		return null;
	}

	public String deleteFiles() {
		String attId = this.getParameter("attId");
		
		ProccessResultBean resultBean;
		if(StringUtils.isEmpty(attId)) {
			resultBean = new ProccessResultBean(false, "文件ID为空");
			HttpServletUtils.outJson(this.getResponse(), resultBean);
			return null;
		}
		
		try {
			fileService.deleteFileByAttid(attId);
			resultBean = new ProccessResultBean(true, "附件删除成功");
		} catch (DAOException e) {
			resultBean = new ProccessResultBean(false, "附件删除失败："+e.getMessage());
		}
		
		HttpServletUtils.outJson(this.getResponse(), resultBean);
		return null;
	}
}

