package org.thorn.core.util;

import java.util.List;

/**
 * @ClassName: ArrayAdapter
 * @Description:
 * @author chenyun
 * @date 2012-5-2 下午03:22:03
 */
public class ArrayAdapter {

	private String[] header;

	private String[] orderArray;

	private List<Object[]> dataSource;

	private int[] orderMapping;

	public ArrayAdapter(String[] header, String[] orderArray,
			List<Object[]> dataSource) {

		this.header = header;
		this.orderArray = orderArray;
		this.dataSource = dataSource;

		if (this.header == null || this.header.length == 0) {
			this.header = this.orderArray;
		}
		initOrderMapping();
	}

	public ArrayAdapter(String[][] array, List<Object[]> dataSource) {

		this.header = array[0];
		this.orderArray = array[1];
		this.dataSource = dataSource;

		if (this.header == null || this.header.length == 0) {
			this.header = this.orderArray;
		}
		initOrderMapping();
	}

	private void initOrderMapping() {

		String[] sourceOrder = (String[]) dataSource.get(0);
		orderMapping = new int[sourceOrder.length];

		for (int i = 0; i < orderArray.length; i++) {

			for (int j = 0; j < sourceOrder.length; j++) {

				if (LocalStringUtils.equals(orderArray[i], sourceOrder[j])) {
					orderMapping[i] = j;
					break;
				}
			}
		}
	}

	public String[] getHeader() {
		return this.getHeader();
	}

	public int getDataSourceOfSize() {
		int size = this.dataSource.size();
		// remove the list header
		if (size > 1) {
			size--;
		}

		return size;
	}

	public Object[] getRow(int rowNum) {
		Object[] obj = dataSource.get(rowNum + 1);

		Object[] orderObj = new Object[obj.length];

		for (int i = 0; i < orderObj.length; i++) {
			orderObj[i] = obj[orderMapping[i]];
		}

		return orderObj;
	}

	public Object getObject(int rowNum, int columnNum) {
		Object[] obj = dataSource.get(rowNum + 1);

		return obj[orderMapping[columnNum]];
	}

}
