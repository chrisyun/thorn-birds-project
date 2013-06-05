package org.thorn.mypass.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class MyPassBaseDAO {

    @Autowired
    protected JdbcTemplate jdbcTemplate;


}
