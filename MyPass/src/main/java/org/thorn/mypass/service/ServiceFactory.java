package org.thorn.mypass.service;

import org.thorn.core.context.SpringContext;

public class ServiceFactory {

    private static ServiceFactory factory = new ServiceFactory();

    private ServiceFactory() {

    }

    public static ServiceFactory getInstance() {
        return factory;
    }

    public UserService getUserService() {
        return SpringContext.getBean("userService");
    }

    public WebsiteService getWebsiteService() {
        return SpringContext.getBean("websiteService");
    }

    public DataService getDataService() {
        return SpringContext.getBean("dataService");
    }

    public GroupService getGroupService() {
        return SpringContext.getBean("groupService");
    }

}
