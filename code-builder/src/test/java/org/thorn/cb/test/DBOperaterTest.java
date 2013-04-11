package org.thorn.cb.test;

import java.sql.SQLException;
import java.util.Set;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.thorn.cb.dao.DBOperater;
import org.thorn.cb.data.Field;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class DBOperaterTest {
	
	@Autowired
	DBOperater dbOper;
	
	@Test
	public void isTableExistTest() {
		System.out.println(dbOper.isTableExist("te"));
	}
	
	@Test
	public void queryDBFieldTest() {
		try {
			Set<Field> set = dbOper.queryDBField("te");
			
			for(Field fe : set) {
				
				System.out.println(
					fe.getComment() + " | " + fe.getTabName() + " | " + 
					fe.getTabLength() + " | " + fe.getTabType() + " | " + 
					fe.getJdbcType() + " | "
				);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void executeSQLTest() {
		String sql = "drop table te;drop table te_copy;";
		try {
			dbOper.executeSql(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
