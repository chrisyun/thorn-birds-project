package org.thorn.sailfish.controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.thorn.sailfish.core.Configuration;
import org.thorn.sailfish.entity.Resource;
import org.thorn.sailfish.entity.ResourceFolder;
import org.thorn.sailfish.entity.Status;
import org.thorn.sailfish.utils.DateTimeUtils;
import org.thorn.sailfish.utils.PathUtils;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-10-16 上午10:03
 * @Version: 1.0
 */
@Controller
@RequestMapping("/am/rs")
public class ResourceController {

    static Logger log = LoggerFactory.getLogger(ResourceController.class);

    private static final String CMS_TAG = "CMS";

    private static final String FLT_TAG = CMS_TAG + "/FLT";

    @RequestMapping("/index")
    public String index(String p, HttpSession session, ModelMap modelMap) {

        if (StringUtils.isEmpty(p)) {
            p = CMS_TAG;
        }

        if (p.indexOf(CMS_TAG) < 0 || StringUtils.equalsIgnoreCase(p, CMS_TAG)) {
            p = CMS_TAG;
        }

        if (!p.startsWith(CMS_TAG)) {
            p = p.substring(p.indexOf(CMS_TAG));
        }

        if (p.endsWith("/") || p.endsWith("\\")) {
            p = p.substring(0, p.length() - 1);
        }

        //特殊处理 {CMS}、{CMS}/{FLT}
        String realPath = PathUtils.getContextPath(session);
        if (StringUtils.startsWith(p, FLT_TAG)) {
            realPath = realPath + Configuration.FORMWORK_PATH + StringUtils.removeStart(p, FLT_TAG);
        } else {
            realPath = realPath + Configuration.STATIC_RESOURCE_PATH + StringUtils.removeStart(p, CMS_TAG);
        }

        //获取目录下的文件信息
        //获取目录下的文件夹信息及文件夹的数量
        File folder = new File(realPath);
        if (!folder.exists()) {
            return "redirect:/am/rs/index";
        }

        File[] files = folder.listFiles();

        List<Resource> resources = new ArrayList<Resource>();
        ResourceFolder resourceFolder = new ResourceFolder();
        resourceFolder.setFileNumber(files.length);
        resourceFolder.setPath(p);

        boolean isFormWork = false;
        if (p.equals(CMS_TAG)) {
            resourceFolder.setName("资源库 - CMS");
        } else if (p.equals(FLT_TAG)) {
            resourceFolder.setName("模板库 - CMS/FLT");
            resourceFolder.setParent(CMS_TAG);
            isFormWork = true;
        } else {
            resourceFolder.setName(folder.getName());
            resourceFolder.setParent(StringUtils.removeEnd(p, resourceFolder.getName()));
        }

        for (File file : files) {
            if (file.isDirectory()) {
                ResourceFolder childFolder = new ResourceFolder();
                childFolder.setName(file.getName());
                childFolder.setPath(p + "/" + file.getName());
                childFolder.setFileNumber(file.list().length);
                resourceFolder.getChildFolders().add(childFolder);
            } else {
                Resource resource = new Resource();
                resource.setName(file.getName());
                resource.setSize(file.length());
                resource.setLastModifyTime(DateTimeUtils.formatTime(new Date(file.lastModified())));
                resource.setFormWork(isFormWork);
                resources.add(resource);
            }
        }

        if (resourceFolder.getParent() == null) {
            resourceFolder.setFileNumber(resourceFolder.getFileNumber() + 1);

            ResourceFolder childFolder = new ResourceFolder();
            childFolder.setName("模板库 - CMS/FLT");
            childFolder.setPath(FLT_TAG);

            File fwFile = new File(PathUtils.getContextPath(session) + Configuration.FORMWORK_PATH);
            childFolder.setFileNumber(fwFile.list().length);
            resourceFolder.getChildFolders().add(childFolder);
        }

        modelMap.put("folder", resourceFolder);
        modelMap.put("resources", resources);
        modelMap.put("p", p);

        return "resource";
    }

    @RequestMapping("/createFolder")
    @ResponseBody
    public Status createFolder(String p, String dir, HttpSession session) {
        Status status = new Status();

        //校验p格式是否正确
        if (!StringUtils.startsWith(p, CMS_TAG)) {
            status.setSuccess(false);
            status.setMessage("上级目录路径格式错误");
            return status;
        }

        if (p.endsWith("/") || p.endsWith("\\")) {
            p = p.substring(0, p.length() - 1);
        }

        if (StringUtils.equals(p, CMS_TAG) && StringUtils.equals(dir, FLT_TAG)) {
            status.setSuccess(false);
            status.setMessage("目录名称与现有目录名重复");
            return status;
        }

        //特殊处理 {CMS}、{CMS}/{FLT}
        String realPath = PathUtils.getContextPath(session);
        if (StringUtils.startsWith(p, FLT_TAG)) {
            realPath = realPath + Configuration.FORMWORK_PATH + StringUtils.removeStart(p, FLT_TAG);
        } else {
            realPath = realPath + Configuration.STATIC_RESOURCE_PATH + StringUtils.removeStart(p, CMS_TAG);
        }

        File folder = new File(realPath);
        if (!folder.exists() || !folder.isDirectory()) {
            status.setSuccess(false);
            status.setMessage("上级目录不存在");
            return status;
        }

        folder = new File(folder, dir);
        if (folder.exists()) {
            status.setSuccess(false);
            status.setMessage("目录名称已经存在");
            return status;
        }

        folder.mkdir();
        status.setMessage("目录创建成功");

        return status;
    }

    @RequestMapping("/renameFolder")
    @ResponseBody
    public Status renameFolder(String p, String renameDir, HttpSession session) {
        Status status = new Status();

        //校验p格式是否正确
        if (!StringUtils.startsWith(p, CMS_TAG)) {
            status.setSuccess(false);
            status.setMessage("目录路径格式错误");
            return status;
        }

        if (p.endsWith("/") || p.endsWith("\\")) {
            p = p.substring(0, p.length() - 1);
        }

        if (StringUtils.equals(p, CMS_TAG) && StringUtils.equals(p, FLT_TAG)) {
            status.setSuccess(false);
            status.setMessage("系统目录不允许修改");
            return status;
        }

        //特殊处理 {CMS}、{CMS}/{FLT}
        String realPath = PathUtils.getContextPath(session);
        if (StringUtils.startsWith(p, FLT_TAG)) {
            realPath = realPath + Configuration.FORMWORK_PATH + StringUtils.removeStart(p, FLT_TAG);
        } else {
            realPath = realPath + Configuration.STATIC_RESOURCE_PATH + StringUtils.removeStart(p, CMS_TAG);
        }

        File folder = new File(realPath);
        if (!folder.exists() || !folder.isDirectory()) {
            status.setSuccess(false);
            status.setMessage("当前目录不存在");
            return status;
        }

        File newFolder = new File(folder.getParent(), renameDir);
        if (newFolder.exists()) {
            status.setSuccess(false);
            status.setMessage("目录名称已经存在");
            return status;
        }

        folder.renameTo(newFolder);
        status.setMessage("目录名称修改成功");

        return status;
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Status uploadFile(String p, @RequestParam("file") CommonsMultipartFile file,
                           HttpServletResponse response, HttpSession session) throws IOException {
        Status status = new Status();

        //校验p格式是否正确
        if (!StringUtils.startsWith(p, CMS_TAG)) {
            status.setSuccess(false);
            status.setMessage("上传目录路径格式错误");
            return status;
        }

        if (p.endsWith("/") || p.endsWith("\\")) {
            p = p.substring(0, p.length() - 1);
        }

        //特殊处理 {CMS}、{CMS}/{FLT}
        String realPath = PathUtils.getContextPath(session);
        if (StringUtils.startsWith(p, FLT_TAG)) {
            realPath = realPath + Configuration.FORMWORK_PATH + StringUtils.removeStart(p, FLT_TAG);
        } else {
            realPath = realPath + Configuration.STATIC_RESOURCE_PATH + StringUtils.removeStart(p, CMS_TAG);
        }

        File folder = new File(realPath);
        if (!folder.exists() || !folder.isDirectory()) {
            status.setSuccess(false);
            status.setMessage("当前目录不存在");
            return status;
        }

        FileItem fileItem = file.getFileItem();
        String resourceName = fileItem.getName();

        File resource = new File(realPath, resourceName);
        if(resource.exists()) {
            status.setSuccess(false);
            status.setMessage("文件名已经存在");
            return status;
        }

        try {
            resource.createNewFile();
            OutputStream os = new FileOutputStream(resource);
            os.write(file.getBytes());
            os.flush();
            os.close();

            status.setMessage("文件上传成功！");
        } catch (IOException e) {
            status.setSuccess(false);
            status.setMessage("文件上传失败：" + e.getMessage());
            log.error("uploadFile[File] - " + e.getMessage(), e);
        }

        //TODO write db

        return status;
    }


}
