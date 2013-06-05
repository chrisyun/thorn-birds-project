package org.thorn.mypass.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.thorn.mypass.entity.Group;

@Repository
public class GroupDAO extends MyPassBaseDAO {

    public List<Group> getGroupByUserAndVersion(String username, Integer version) {
        String sql = "select id,name,pname,version,username from t_group where username = ? and version = ?";

        return this.jdbcTemplate.query(sql, new Object[]{username, version}, new RowMapper<Group>() {

            public Group mapRow(ResultSet rs, int rowNum) throws SQLException {
                Group group = new Group();

                group.setId(rs.getInt("id"));
                group.setVersion(rs.getInt("version"));
                group.setName(rs.getString("name"));
                group.setPname(rs.getString("pname"));
                group.setUsername(rs.getString("username"));

                return group;
            }
        });
    }

    public int saveGroup(Group group) {
        String sql = "insert into t_group(id,name,pname,version,username,operatorTime) values(null,?,?,?,?,datetime('now'))";
        return this.jdbcTemplate
                .update(sql, group.getName(), group.getPname(), group.getVersion(), group.getUsername());
    }

    public int modifyGroup(Group group) {
        String sql = "update t_group set name = ?, pname = ?, version = ?, username = ?, operatorTime = datetime('now') where id = ?";
        return this.jdbcTemplate.update(sql, group.getName(), group.getPname(), group.getVersion(),
                group.getUsername(), group.getId());
    }

    public int deleteGroup(Integer id) {
        String sql = "delete from t_group where id = ?";
        return this.jdbcTemplate.update(sql, id);
    }

}
