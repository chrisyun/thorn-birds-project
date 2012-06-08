package org.thorn.attachment.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;
import org.thorn.attachment.entity.Attachment;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.log.NoLogging;

/** 
 * @ClassName: AttachmentLocalServiceImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-6-8 上午10:30:53 
 */
public class AttachmentLocalServiceImpl extends AttachmentDBServiceImpl
		implements IAttachmentService {
	
	private String savePath;
	
	private String httpPath;
	
	String saveType = "Local";
	
	@NoLogging
	@Override
	public void uploadAtt(Attachment att, MultipartFile file)
			throws DBAccessException {
		if(LocalStringUtils.isEmpty(att.getSaveType())) {
			att.setSaveType(saveType);
		}
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String date = df.format(new Date());
		
		StringBuilder path = new StringBuilder(savePath);
		path.append(File.separator).append(date);
		path.append(File.separator).append(att.getUploader()).append(File.separator);
		
		File dir = new File(path.toString());
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		String[] name = null;
		if(att.getFileName().indexOf(".") > 0) {
			name = att.getFileName().split("\\.");
			name[1] = "." + name[1];
		} else {
			name = new String[]{att.getFileName(),""};
		}
		
		String onlyName = att.getFileName();
		String fileName = path.toString() + att.getFileName();
		File attfile = new File(fileName);
		
		int i = 1;
		while(attfile.exists()) {
			onlyName = name[0] + "_" + i + name[1];
			fileName = path.toString() + onlyName;
			attfile = new File(fileName);
			i++;
		}
		
		try {
			attfile.createNewFile();
			OutputStream os = new FileOutputStream(attfile);
			os.write(file.getBytes());
			os.flush();
			os.close();
		} catch (IOException e) {
			throw new DBAccessException("write local file exception", e);
		}
		
		StringBuilder savepath = new StringBuilder();
		savepath.append(File.separator).append(date);
		savepath.append(File.separator).append(att.getUploader());
		savepath.append(File.separator).append(onlyName);
		att.setFilePath(savepath.toString());
		
		super.uploadAtt(att, file);
	}
	
	@NoLogging
	@Override
	public Attachment downloadAtt(Integer id) throws DBAccessException {
		Attachment att = super.downloadAtt(id);
		
		if(att != null) {
			// 转换路径分隔符为http url的分隔符
			String url = httpPath + att.getFilePath().replaceAll("\\\\", "/");
			att.setFilePath(url);
			
			return att;
		} 
		
		return null;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getHttpPath() {
		return httpPath;
	}

	public void setHttpPath(String httpPath) {
		this.httpPath = httpPath;
	}
	
}

