package org.thorn.cb.dao;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

public class JDBCTypesMapping {

	private static Map<Integer, JDBCType> mapping = new HashMap<Integer, JDBCType>();
	
	private static final JDBCType DEFAULT_JDBC_TYPE = new JDBCType("VARCHAR", "String");
	
	static {
		mapping.put(Types.CHAR, new JDBCType("CHAR", "String"));
		mapping.put(Types.VARCHAR, new JDBCType("VARCHAR", "String"));
		mapping.put(Types.NVARCHAR, new JDBCType("NVARCHAR", "String"));
		mapping.put(Types.LONGNVARCHAR, new JDBCType("LONGNVARCHAR", "String"));
		mapping.put(Types.LONGVARCHAR, new JDBCType("LONGVARCHAR", "String"));
		
		mapping.put(Types.TINYINT, new JDBCType("TINYINT", "Short"));
		mapping.put(Types.SMALLINT, new JDBCType("SMALLINT", "Short"));
		mapping.put(Types.INTEGER, new JDBCType("INTEGER", "Integer"));
		mapping.put(Types.BIGINT, new JDBCType("LONGVARCHAR", "Long"));
		
		mapping.put(Types.REAL, new JDBCType("REAL", "Float"));
		mapping.put(Types.FLOAT, new JDBCType("LONGVARCHAR", "Float"));
		mapping.put(Types.DOUBLE, new JDBCType("LONGVARCHAR", "Double"));
		mapping.put(Types.NUMERIC, new JDBCType("LONGVARCHAR", "Double"));
		mapping.put(Types.DECIMAL, new JDBCType("LONGVARCHAR", "Double"));
		
		mapping.put(Types.DATE, new JDBCType("DATE", "String"));
		mapping.put(Types.TIME, new JDBCType("TIME", "String"));
		mapping.put(Types.TIMESTAMP, new JDBCType("TIMESTAMP", "String"));
	}
	
	public static String getJDBCTypeName(int type) {
		JDBCType jdbc = mapping.get(type);
		
		if(jdbc == null) {
			try {
				jdbc = (JDBCType) DEFAULT_JDBC_TYPE.clone();
			} catch (CloneNotSupportedException e) {
				jdbc = new JDBCType("VARCHAR", "String");
			}
		}
		
		return jdbc.getJdbcType();
	}
	
	public static String getJavaTypeName(int type) {
		JDBCType jdbc = mapping.get(type);
		
		if(jdbc == null) {
			try {
				jdbc = (JDBCType) DEFAULT_JDBC_TYPE.clone();
			} catch (CloneNotSupportedException e) {
				jdbc = new JDBCType("VARCHAR", "String");
			}
		}
		
		return jdbc.getJavaType();
	}
	
}
