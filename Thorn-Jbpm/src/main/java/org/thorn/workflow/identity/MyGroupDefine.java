package org.thorn.workflow.identity;

import java.io.IOException;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonToken;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.workflow.WorkflowConfiguration;

/**
 * @ClassName: MyGroup
 * @Description: groupId为json形式{groupType:"",groupId:"",limit:"",limitCode:""}
 *               groupType组类型，groupId组ID，limit限制类型，limitCode限制ID（orgCode、area）
 * @author chenyun
 * @date 2012-6-19 上午12:05:04
 */
public class MyGroupDefine {

	private String groupType;

	private String limit;

	private String limitCode;

	private String groupId;

	private boolean limited;

	private MyGroupDefine() {

	}

	public String getGroupType() {
		return groupType;
	}

	public String getLimit() {
		return limit;
	}

	public String getLimitCode() {
		return limitCode;
	}

	public String getGroupId() {
		return groupId;
	}

	public boolean isLimited() {
		return limited;
	}

	public static MyGroupDefine getInstance(String groupId) throws IOException {
		MyGroupDefine df = new MyGroupDefine();

		JsonFactory f = new JsonFactory();
		JsonParser jp = f.createJsonParser(groupId);
		jp.nextToken();

		while (jp.nextToken() != JsonToken.END_OBJECT) {
			String nodeName = jp.getCurrentName();
			
			if (LocalStringUtils.equals(nodeName, "groupType")) {

				df.groupType = jp.getText().toLowerCase();
			} else if (LocalStringUtils.equals(nodeName, "groupId")) {

				df.groupId = jp.getText();
			} else if (LocalStringUtils.equals(nodeName, "limit")) {

				df.limit = jp.getText().toLowerCase();
				if (LocalStringUtils.equals(df.limit,
						WorkflowConfiguration.LIMIT_NONE)) {
					df.limited = false;
				} else {
					df.limited = true;
				}
			} else if (LocalStringUtils.equals(nodeName, "limitCode")) {

				df.limitCode = jp.getText();
			} else {
				throw new IllegalStateException("Unrecognized field '"
						+ nodeName + "'!");
			}
		}
		
		jp.close();
		return df;
	}

}
