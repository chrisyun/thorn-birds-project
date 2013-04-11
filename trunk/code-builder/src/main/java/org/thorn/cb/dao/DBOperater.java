package org.thorn.cb.dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.thorn.cb.data.Field;

public class DBOperater {
	
	@Autowired
	private NamedParameterJdbcTemplate namedJdbcTemplate;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public boolean isTableExist(String table) {

		String sql = "select count(*) as num from " + table;

		try {
			Map<String, Object> result = jdbcTemplate.queryForMap(sql);

			if (result == null || (Long) result.get("num") == 0) {
				return false;
			}

			return true;
		} catch (Exception e) {
			// the table not exist
			e.printStackTrace();
		}

		return false;
	}

	public void dropTable(String table) throws SQLException {

		String sql = "drop table " + table;

		executeSql(sql);
	}

	public void executeSql(String sql) throws SQLException {
		String[] batchSql = sql.split(";");
		
		for(String one : batchSql) {
			if(StringUtils.isNotBlank(one)) {
				jdbcTemplate.execute(one);
			}
			
		}
	}

	public Set<Field> queryDBField(String table) throws SQLException {
		
		Set<Field> set = new HashSet<Field>();
		
		Connection conn = null;
		try {
			conn = jdbcTemplate.getDataSource().getConnection();
			DatabaseMetaData dbMetaData = conn.getMetaData();
			
			ResultSet rs = dbMetaData.getColumns("", "", table, "");
			
			while(rs.next()) {
				// 来自 java.sql.Types 的 SQL 类型
				int dataType = rs.getInt("DATA_TYPE");
				// 列大小
				int columnSize = rs.getInt("COLUMN_SIZE");
				// 列的名称
				String columnName = rs.getString("COLUMN_NAME");
				// 描述列的注释（可为 null）
				String remarks = rs.getString("REMARKS");
				// 默认值
				String defVal = rs.getString("COLUMN_DEF");
				
				Field field = new Field();
				field.setTabName(columnName.toUpperCase());
				field.setTabLength(columnSize);
				field.setJdbcType(dataType);
				field.setTabType(JDBCTypesMapping.getJDBCTypeName(dataType));
				field.setComment(remarks);
				
				set.add(field);
			}
			
			rs.close();
		} finally {
			conn.close();
		}

		return set;
	}

}
