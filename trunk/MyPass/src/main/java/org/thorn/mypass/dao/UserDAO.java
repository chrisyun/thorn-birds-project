package org.thorn.mypass.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.thorn.mypass.entity.User;

@Repository
public class UserDAO extends MyPassBaseDAO {

    public User getUserByNameAndPassword(String username, String password) {
        String sql = "select id,username,password,usedVersion from t_user where username = ? and password = ?";

        return this.jdbcTemplate.query(sql, new String[] { username, password }, new ResultSetExtractor<User>() {

            public User extractData(ResultSet rs) throws SQLException, DataAccessException {
                
                while (rs.next()) {
                    User user = new User();
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setId(rs.getInt("id"));
                    user.setUsedVersion(rs.getInt("usedVersion"));

                    return user;
                }
                
                return null;
            }
        });
    }

    public List<String> getAllUserName() {
        String sql = "select username from t_user";

        return this.jdbcTemplate.query(sql, new RowMapper<String>() {

            public String mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getString("username");
            }

        });
    }

    public int saveUser(User user) {
        String sql = "insert into t_user(id,username,password,usedVersion) values(null,?,?,?)";
        return this.jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getUsedVersion());
    }

    public int modifyUserPassword(User user) {
        String sql = "update t_user set password = ? where username = ?)";
        return this.jdbcTemplate.update(sql, user.getPassword(), user.getUsername());
    }

    public int modifyLoginTime(String username) {
        String sql = "update t_user set loginTime = datetime('now') where username = ?)";

        return this.jdbcTemplate.update(sql, username);
    }

    public int modifyUsedVersion(String username, Integer version) {
        String sql = "update t_user set usedVersion = ? where username = ?)";

        return this.jdbcTemplate.update(sql, version, username);
    }

}
