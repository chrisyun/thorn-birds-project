package org.thorn.sailfish.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.sailfish.core.Configuration;
import org.thorn.sailfish.entity.Resource;
import org.thorn.sailfish.entity.ResourceFolder;
import org.thorn.sailfish.utils.DateTimeUtils;
import org.thorn.sailfish.utils.PathUtils;

import javax.servlet.http.HttpSession;
import java.io.File;
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

    private static final String CMS_TAG = "{CMS}";

    private static final String FLT_TAG = CMS_TAG + "/{FLT}";

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
        if (StringUtils.contains(p, FLT_TAG)) {
            realPath = realPath + Configuration.FORMWORK_PATH + StringUtils.removeStart(p, FLT_TAG);
        } else {
            realPath = realPath + Configuration.STATIC_RESOURCE_PATH + StringUtils.removeStart(p, CMS_TAG);
        }

        //获取目录下的文件信息
        //获取目录下的文件夹信息及文件夹的数量
        File folder = new File(realPath);
        File[] files = folder.listFiles();

        List<Resource> resources = new ArrayList<Resource>();
        ResourceFolder resourceFolder = new ResourceFolder();
        resourceFolder.setFileNumber(files.length);
        resourceFolder.setPath(p);

        boolean isFormWork = false;
        if (p.equals(CMS_TAG)) {
            resourceFolder.setName("资源库 - {CMS}");
        } else if (p.equals(FLT_TAG)) {
            resourceFolder.setName("模板库 - {CMS}/{FLT}");
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
            ResourceFolder childFolder = new ResourceFolder();
            childFolder.setName("模板库 - {CMS}/{FLT}");
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


}
