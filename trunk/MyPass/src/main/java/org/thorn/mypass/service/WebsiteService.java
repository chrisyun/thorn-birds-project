package org.thorn.mypass.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.mypass.core.Session;
import org.thorn.mypass.dao.WebsiteDAO;
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

}
