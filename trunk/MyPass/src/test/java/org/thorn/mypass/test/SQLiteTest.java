package org.thorn.mypass.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLiteTest {

    /**
     * @author：chenyun
     * @date：2013-5-17
     * @Description：
     * @param args
     * @throws ClassNotFoundException
     * @throws SQLException
     */

    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        String url = "jdbc:sqlite:target/classes/database/myPass.db3";
        String driver = "org.sqlite.JDBC";

        Class.forName(driver);
        Connection connection = DriverManager.getConnection(url);
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("select * from t_user");
        if (resultSet.next()) {
            System.out.println(">>>姓名： " + resultSet.getString("username"));
        }
        resultSet.close();
        statement.close();
        connection.close();
    }

}
