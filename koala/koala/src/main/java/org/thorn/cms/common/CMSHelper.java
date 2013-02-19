package org.thorn.cms.common;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.thorn.cms.entity.WebSite;
import org.thorn.cms.service.IWebSiteService;
import org.thorn.core.context.SpringContext;
import org.thorn.dao.exception.DBAccessException;

/**
 * @ClassName: CMSHelper
 * @Description:
 * @author chenyun
 * @date 2013-2-19 下午4:53:22
 */
public class CMSHelper {

	public static WebSite getCurrentWebSite(HttpSession session)
			throws DBAccessException {

		WebSite wsSession = (WebSite) session
				.getAttribute(CMSConfiguration.SESSION_WS);

		if (wsSession == null) {
			IWebSiteService wsService = SpringContext.getBean("wsService");

			List<WebSite> list = wsService.queryList(null);

			if (list == null || list.size() == 0) {
				throw new DBAccessException("未设置站点！");
			} else {
				wsSession = list.get(0);
				session.setAttribute(CMSConfiguration.SESSION_WS, list.get(0));
			}
		}
		
		return wsSession;
	}

}
