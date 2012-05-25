package org.cy.thorn.dao.incrementer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cy.thorn.dao.entity.Sequence;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.jdbc.support.JdbcUtils;

/**
 * <p>文件名称: TableIncrementer.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-9-29</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class TableIncrementer extends AbstractIncrementer {
	
	static Log log = LogFactory.getLog(TableIncrementer.class);
	
	@Override
	public long getNextLongKey(String tableName, String columnName)
			throws Exception {
		
		Sequence seqCache = null;
		boolean isCacheOK = true;
		
		try {
			seqCache = (Sequence) 
				getCache().getCacheElement(columnName.concat(AbstractIncrementer.CACHE_END_STR));
			
			//缓存已满
			if(seqCache.getCur_seq() >= seqCache.getMax_seq()) {
				isCacheOK = false;
			}
			
		} catch (Exception e) {
			log.error("get sequence from cache error", e);
			isCacheOK = false;
		}
		
		//从表中中查找值,并更新
		if(seqCache == null || !isCacheOK) {
			seqCache = new Sequence();
			
			Connection conn = DataSourceUtils.getConnection(getDataSource());
			Statement stmt = null;
			
			StringBuffer selectSql = new StringBuffer("select ").append(columnName)
				.append(" from ").append(tableName);
			StringBuffer updateSql = new StringBuffer("update ").append(tableName)
				.append(" set ").append(tableName).append(" = ").append(getCacheSize())
				.append("+").append(tableName);
			
			
			try {
				conn.setAutoCommit(false);
				
				stmt = conn.createStatement();
				DataSourceUtils.applyTransactionTimeout(stmt, getDataSource());
				
				ResultSet rs = stmt.executeQuery(selectSql.toString());
				try {
					if (!rs.next()) {
						throw new DBAccessException("select max_id error, no result");
					}
					seqCache.setCur_seq(rs.getLong(1)+1);
					seqCache.setMax_seq(seqCache.getCur_seq() + getCacheSize());
				}
				finally {
					JdbcUtils.closeResultSet(rs);
				}
				
				stmt.executeUpdate(updateSql.toString());
				conn.commit();
				
			} catch (Exception ex) {
				conn.rollback();
				log.error("select max_id from db error", ex);
				throw new DBAccessException("Could not obtain last_insert_id()", ex);
			} finally {
				JdbcUtils.closeStatement(stmt);
				conn.setAutoCommit(true);
				DataSourceUtils.releaseConnection(conn, getDataSource());
			}
		}
		
		//对缓存进行操作
		seqCache.setCur_seq(seqCache.getCur_seq() + 1);
		getCache().putCacheElement(tableName.concat(ViewIncrementer.CACHE_END_STR), seqCache);
		
		return seqCache.getCur_seq();
	}

}

