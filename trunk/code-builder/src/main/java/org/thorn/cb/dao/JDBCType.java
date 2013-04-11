package org.thorn.cb.dao;

public class JDBCType {
	
	private String javaType;
	
	private String jdbcType;
	
	public JDBCType() {
		
	}
	
	public JDBCType(String jdbcType, String javaType) {
		this.javaType = javaType;
		this.jdbcType = jdbcType;
	}
	
	public String getJavaType() {
		return javaType;
	}

	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}

	public String getJdbcType() {
		return jdbcType;
	}

	public void setJdbcType(String jdbcType) {
		this.jdbcType = jdbcType;
	}

	@Override
	protected Object clone() throws CloneNotSupportedException {
		JDBCType copy = new JDBCType(this.jdbcType, this.javaType);
		return copy;
	}
	
}
