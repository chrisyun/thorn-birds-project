package com.talkweb.ncfw.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.talkweb.ncframework.pub.dao.IGenericDAO;
import com.talkweb.ncframework.pub.exceptions.DAOException;
import com.talkweb.ncframework.pub.utils.PropertiesUtils;
import com.talkweb.ncframework.pub.utils.SequenceUtils;
import com.talkweb.ncframework.pub.utils.StringUtils;
import com.talkweb.ncfw.entity.CommonFile;
import com.talkweb.security.SecurityHelper;

/**
 * <p>文件名称: FileServiceImpl.java</p>
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
public class FileServiceImpl implements IFileService {
	
	private static Logger logger = Logger.getLogger(FileServiceImpl.class);
	private IGenericDAO genericDAO;
	public IGenericDAO getGenericDAO() {
		return genericDAO;
	}
	public void setGenericDAO(IGenericDAO genericDAO) {
		this.genericDAO = genericDAO;
	}


	public CommonFile saveFile(File uploadFile, String uploadFileName,
			String pid, String tableid, String busatttype) throws IOException, DAOException {
		CommonFile cf = new CommonFile();
		cf.setPid(pid);
		cf.setTableid(tableid);
		cf.setAttname(uploadFileName);
		cf.setBusatttype(busatttype);
		String fileType = uploadFileName.substring(uploadFileName.indexOf("."), uploadFileName.length());
		cf.setAtttype(fileType);
		cf.setAttid(SequenceUtils.createPrimaryKeySeq());
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		cf.setUploadtime(df.format(new Date()));
		
//		String saveMode = PropertiesUtils.getProperty("commonfile.file.saveMode");
		String saveMode = "0";
		cf.setUploadType(saveMode);
		
		cf.setUploader(SecurityHelper.getCurrentUser().getUser().getUserid());
		
		//本地
		if(StringUtils.equals("0", saveMode)) {
//			String diskPath = PropertiesUtils.getProperty("commonfile.saveDiskPath");
			String diskPath = "d:\\culture";
			String folderName = diskPath + "\\"+ cf.getUploadtime();
			
			File folder = new File(folderName);
			if (! folder.exists()) {
				folder.mkdirs();
			}
			
			cf.setAttpath("\\"+ cf.getUploadtime() + "\\" + cf.getAttid() + cf.getAtttype());
			File attach = new File(diskPath + cf.getAttpath());
			
			FileInputStream instream = null;
			FileOutputStream outstream = null;
			try {
				attach.createNewFile();
				instream = new FileInputStream(uploadFile);
				
				outstream = new FileOutputStream(attach);
				int bytesRead;
				byte[] buf = new byte[4 * 1024]; //4K buffer
				while((bytesRead = instream.read(buf)) != -1){
					outstream.write(buf, 0, bytesRead);
				}
				outstream.flush();
			} catch (IOException e) {
				throw e;
			} finally {
				outstream.close();
				instream.close();
			}
		}
		
		
		//写数据库
		genericDAO.insert("FileMapper.insert", cf);
		
		
		return cf;
	}
	
	public CommonFile downloadFile(String attid) {
		List<CommonFile> list = genericDAO.queryList("FileMapper.queryByAttid", attid);
		if(list == null || list.size() == 0) {
			return null;
		}
		CommonFile cf = list.get(0);
		
//		String saveMode = PropertiesUtils.getProperty("commonfile.file.saveMode");
		String saveMode = "0";
		if(StringUtils.equals("0", saveMode)) {
//			String diskPath = PropertiesUtils.getProperty("commonfile.saveDiskPath");
			String diskPath = "d:\\culture";
			File attach = new File(diskPath + cf.getAttpath());
			cf.setAttach(attach);
		}
		
		return cf;
		
	}

	public void deleteFileByPid(String pid) throws DAOException {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pid", pid);
		genericDAO.deleteForeach("FileMapper.delete", map);
	}
	
	public void deleteFileByAttid(String attid) throws DAOException {
		HashMap map = new HashMap();
		map.put("attid", attid);
		genericDAO.deleteForeach("FileMapper.delete", map);
	}
	
	public List<CommonFile> queryFile(String pid,String tableId,String busatttype) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pid", pid);
		map.put("tableid", tableId);
		map.put("busatttype", busatttype);
		return genericDAO.queryList("FileMapper.query", map);
	}
	
	public void updateFile(String attids, String pid, String tableid) throws DAOException {
		String[] atts = attids.replace("'", "").split(",");
		StringBuffer attsbf = new StringBuffer();
		for(String att : atts) {
			attsbf.append("'").append(att).append("',");
		}
		String attOver = attsbf.toString().substring(0, attsbf.toString().length()-1);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("attId", attOver);
		map.put("pid", pid);
		map.put("tableid", tableid);
		
		genericDAO.update("FileMapper.update", map);
	}
}

