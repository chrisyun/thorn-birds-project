package org.thorn.web.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName: Page
 * @Description:
 * @author chenyun
 * @date 2012-4-26 下午04:55:47
 */
public class Page<T> implements Serializable {

	public static final long DEFAULT_LIMIT = 20;

	/** */
	private static final long serialVersionUID = 5951452024298265919L;
	/** 结果集总数 */
	private long total;
	/** 结果集 */
	private List<T> reslutSet = new ArrayList<T>();

	private long start;

	private long limit;

	public Page(Long start, Long limit) {
		if (limit == null || limit <= 0) {
			limit = DEFAULT_LIMIT;
		}
		if (start == null || start < 0) {
			start = 1L;
		}

		this.start = start;
		this.limit = limit;
	}

	public Page() {

	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<T> getReslutSet() {
		return reslutSet;
	}

	public void setReslutSet(List<T> reslutSet) {
		this.reslutSet = reslutSet;
	}

	public long getStart() {
		return start;
	}

	public long getLimit() {
		return limit;
	}

	public long getPageIndex() {

		long index = start / limit;

		if ((start % limit) != 0) {
			index++;
		}

		return index;
	}

	public void setPageData(Page<T> page) {

		if (page != null) {
			this.reslutSet = page.getReslutSet();
			this.total = page.getTotal();
		}
	}

}
