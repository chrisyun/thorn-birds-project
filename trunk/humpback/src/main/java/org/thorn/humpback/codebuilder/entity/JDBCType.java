package org.thorn.humpback.codebuilder.entity;

public class JDBCType {
	
	private String javaType;
	
	private String dbType;
	
	public JDBCType() {
		
	}
	
	public JDBCType(String dbType, String javaType) {
		this.javaType = javaType;
		this.dbType = dbType;
	}
	
	public String getJavaType() {
		return javaType;
	}

	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }

    @Override
	protected Object clone() throws CloneNotSupportedException {
		JDBCType copy = new JDBCType(this.dbType, this.javaType);
		return copy;
	}
	
}
