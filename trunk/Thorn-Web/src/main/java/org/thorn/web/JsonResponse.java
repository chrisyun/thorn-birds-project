package org.thorn.web;
/** 
 * @ClassName: JsonResponse 
 * @Description: 
 * @author chenyun
 * @date 2012-5-13 上午11:02:48 
 */
public class JsonResponse<T> extends Status {

	/** */
	private static final long serialVersionUID = 4937313269465119475L;
	
	private T obj;

	public T getObj() {
		return obj;
	}

	public void setObj(T obj) {
		this.obj = obj;
	}
}

