package org.thorn.mypass.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.thorn.mypass.entity.Website;

@Repository
public class WebsiteDAO extends MyPassBaseDAO {

    public List<Website> queryWebsiteByFilter(Website filter) {
        StringBuilder sql = new StringBuilder("select id,website,account,password,");
        sql.append("description,version,groupName,username from t_website where ");
        sql.append("username = ? and version = ? ");

        List<Object> argsList = new ArrayList<Object>();
        argsList.add(filter.getUsername());
        argsList.add(filter.getVersion());

        if (StringUtils.isNotEmpty(filter.getGroupName())) {
            sql.append("and groupName = ? ");
            argsList.add(filter.getGroupName());
        }

        if (StringUtils.isNotEmpty(filter.getWebsite())) {
            sql.append("and website = ? ");
            argsList.add(filter.getWebsite());
        }

        Object[] args = new Object[argsList.size()];
        for (int i = 0; i < args.length; i++) {
            args[i] = argsList.get(i);
        }

        return this.jdbcTemplate.query(sql.toString(), args, new RowMapper<Website>() {

            public Website mapRow(ResultSet rs, int rowNum) throws SQLException {
                Website ws = new Website();

                ws.setId(rs.getInt("id"));
                ws.setAccount(rs.getString("account"));
                ws.setDescription(rs.getString("description"));
                ws.setGroupName(rs.getString("groupName"));
                ws.setPassword(rs.getString("password"));
                ws.setUsername(rs.getString("username"));
                ws.setVersion(rs.getInt("version"));
                ws.setWebsite(rs.getString("website"));

                return ws;
            }
        });
    }

    public int saveWebsite(Website website) {
        StringBuilder sql = new StringBuilder("insert into t_website");
        sql.append("(id,website,account,password,description,version,groupName,username,operatorTime)");
        sql.append("values(null,?,?,?,?,?,?,?,datetime('now'))");
        return this.jdbcTemplate.update(sql.toString(), website.getWebsite(), website.getAccount(),
                website.getPassword(), website.getDescription(), website.getVersion(), website.getGroupName(),
                website.getUsername());
    }

    public int modifyWebsite(Website website) {
        StringBuilder sql = new StringBuilder("update t_website set ");
        sql.append("website = ?,account = ?,password = ?,description = ?,");
        sql.append("version = ?,groupName = ?,username = ?,operatorTime = datetime('now')");
        sql.append(" where id = ?");
        return this.jdbcTemplate.update(sql.toString(), website.getWebsite(), website.getAccount(),
                website.getPassword(), website.getDescription(), website.getVersion(), website.getGroupName(),
                website.getUsername(), website.getId());
    }

    public int deleteWebsite(Integer id) {
        String sql = "delete from t_website where id = ?";
        return this.jdbcTemplate.update(sql, id);
    }

}
