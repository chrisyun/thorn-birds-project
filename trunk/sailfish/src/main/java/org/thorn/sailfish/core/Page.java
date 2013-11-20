package org.thorn.sailfish.core;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-10-28 下午5:13
 * @Version: 1.0
 */
public class Page<T> {

    /** 结果集总数 */
    private long total = 0;

    /** 结果集 */
    private List<T> resultSet = new ArrayList<T>();

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<T> getResultSet() {
        return resultSet;
    }

    public void setResultSet(List<T> resultSet) {
        this.resultSet = resultSet;
    }
}
