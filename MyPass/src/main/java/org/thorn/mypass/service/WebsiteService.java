package org.thorn.mypass.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.mypass.core.NoSessionException;
import org.thorn.mypass.core.Session;
import org.thorn.mypass.dao.WebsiteDAO;
import org.thorn.mypass.entity.CommonResult;
import org.thorn.mypass.entity.User;
import org.thorn.mypass.entity.Website;

@Service("websiteService")
public class WebsiteService {

    @Autowired
    private WebsiteDAO wsDAO;

    public List<Website> queryWebsite(String groupName, String websiteName) throws Exception {

        Website filter = new Website();
        filter.setWebsite(websiteName);
        filter.setGroupName(groupName);

        Session session = Session.getCurrentSession();
        User user = session.getUser();
        filter.setUsername(user.getUsername());
        filter.setVersion(user.getUsedVersion());

        return wsDAO.queryWebsiteByFilter(filter);
    }

    public CommonResult<String> addWebSite(String website, String account, String password,
                                            String description, String groupName) throws DBAccessException, NoSessionException {
        CommonResult<String> result = new CommonResult<String>();

        Website ws = new Website();
        ws.setAccount(account);
        ws.setDescription(description);
        ws.setGroupName(groupName);
        ws.setPassword(password);
        ws.setWebsite(website);

        Session session = Session.getCurrentSession();
        User user = session.getUser();
        ws.setUsername(user.getUsername());
        ws.setVersion(user.getUsedVersion());

        try {
            if(wsDAO.saveWebsite(ws) == 1) {
                result.setMsg("数据保存成功！");
                result.setSuccess(true);
            } else {
                result.setMsg("数据保存失败！");
                result.setSuccess(false);
            }
        } catch (Exception e) {
            throw new DBAccessException(e);
        }

        return result;
    }

}
