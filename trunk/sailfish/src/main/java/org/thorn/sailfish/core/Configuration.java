package org.thorn.sailfish.core;

import org.omg.CORBA.PUBLIC_MEMBER;

import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-10-15 下午2:40
 * @Version: 1.0
 */
public class Configuration {

    public static final String SESSION_USER = "sessionUser";

    public static final String ADMIN_USERNAME = "Administrator";

    public static final String ADMIN_PASSWORD = "_PL<)OKM";

    public static final String STATIC_RESOURCE_PATH = File.separator + "cms";

    public static final String FORMWORK_PATH = File.separator + "WEB-INF" + File.separator + "flt";

    /** 分页查询的start参数 */
    public final static String PAGE_START = "start";
    /** 分页查询的limit参数 */
    public final static String PAGE_LIMIT = "limit";
    /** 排序字段参数 */
    public final static String SORT_NAME = "sort";
    /** 顺序参数 */
    public final static String ORDER_NAME = "dir";

    public final static String ORDER_ASC = "asc";

    public final static String ORDER_DESC = "desc";

}
