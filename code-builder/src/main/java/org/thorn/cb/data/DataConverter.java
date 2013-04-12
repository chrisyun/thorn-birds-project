package org.thorn.cb.data;

import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.thorn.cb.dao.JDBCTypesMapping;
import org.thorn.cb.xml.Builder;
import org.thorn.cb.xml.Column;

public class DataConverter {

	public static TemplateData convert(Builder xml, Set<Field> fields) {

		TemplateData templateData = new TemplateData();

		templateData.setName(xml.getName());
		templateData.setPkg(xml.getPkg());
		templateData.setTableName(xml.getTable().getTable());

		for (Field field : fields) {

			if (xml.getIds().contains(field.getTabName())) {
				field.setKey(true);

				for (Column col : xml.getIds()) {
					if (col.equals(field.getTabName())) {
						field.setFieldName(col.getProperty());
						field.setFieldType(col.getJavaType());
						break;
					}
				}

			} else if (xml.getColumns().contains(field.getTabName())) {
				field.setKey(false);

				for (Column col : xml.getColumns()) {
					if (col.equals(field.getTabName())) {
						field.setFieldName(col.getProperty());
						field.setFieldType(col.getJavaType());
						break;
					}
				}

			} else {
				field.setKey(false);
			}

			if (StringUtils.isEmpty(field.getFieldName())) {
				field.setFieldName(field.getTabName().toLowerCase());
			}
			if (StringUtils.isEmpty(field.getFieldType())) {
				field.setFieldType(JDBCTypesMapping.getJavaTypeName(field
						.getJdbcType()));
			}
		}
		
		templateData.setFields(fields);

		return templateData;
	}

}
