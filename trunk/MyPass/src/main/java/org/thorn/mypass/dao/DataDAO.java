package org.thorn.mypass.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.thorn.mypass.entity.Data;

@Repository
public class DataDAO extends MyPassBaseDAO {

    public List<Data> queryDataByFilter(Data filter) {
	StringBuilder sql = new StringBuilder("select id,dataInfo,version,groupName,username ");
	sql.append("from t_data where username = ? and version = ? ");

	List<Object> argsList = new ArrayList<Object>();
	argsList.add(filter.getUsername());
	argsList.add(filter.getVersion());

	if (StringUtils.isNotEmpty(filter.getGroupName())) {
	    sql.append("and groupName = ? ");
	    argsList.add(filter.getGroupName());
	}

	Object[] args = new Object[argsList.size()];
	for (int i = 0; i < args.length; i++) {
	    args[i] = argsList.get(i);
	}

	return this.jdbcTemplate.query(sql.toString(), args, new RowMapper<Data>() {

	    public Data mapRow(ResultSet rs, int rowNum) throws SQLException {
		Data data = new Data();

		data.setId(rs.getInt("id"));
		data.setDataInfo(rs.getString("groupName"));
		data.setGroupName(rs.getString("groupName"));
		data.setUsername(rs.getString("username"));
		data.setVersion(rs.getInt("version"));

		return data;
	    }
	});
    }

    public int saveData(Data data) {
	StringBuilder sql = new StringBuilder("insert into t_data");
	sql.append("(id,dataInfo,version,groupName,username,operatorTime)");
	sql.append("values(null,?,?,?,?,datetime('now'))");
	return this.jdbcTemplate.update(sql.toString(), data.getDataInfo(), data.getVersion(), data.getGroupName(), data.getUsername());
    }

    public int modifyData(Data data) {
	StringBuilder sql = new StringBuilder("update t_data set ");
	sql.append("dataInfo = ?,version = ?,groupName = ?,username = ?,");
	sql.append("operatorTime = datetime('now') where id = ?");
	return this.jdbcTemplate.update(sql.toString(), data.getDataInfo(), data.getVersion(), data.getGroupName(), data.getUsername(), data.getId());
    }

    public int deleteData(Integer id) {
	String sql = "delete from t_data where id = ?";
	return this.jdbcTemplate.update(sql, id);
    }

}
