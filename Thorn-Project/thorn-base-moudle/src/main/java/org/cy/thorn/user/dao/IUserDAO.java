package org.cy.thorn.user.dao;

import java.util.List;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.user.entity.User;

/**
 * <p>文件名称: IUserDAO.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-19</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public interface IUserDAO {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：用户新增
	 * @param org
	 * @throws DBAccessException
	 */
	public void insertUser(User user) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：用户修改
	 * @param org
	 * @throws DBAccessException
	 */
	public void updateUser(User user) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：用户批量删除
	 * @param oids
	 * @throws DBAccessException
	 */
	public void deleteUser(List<String> uids) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：根据主键查找用户
	 * @param oid
	 * @return
	 * @throws DBAccessException
	 */
	public User searchByPK(String uid) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-21
	 * @Description：根据用户账户查找，login时用
	 * @param account
	 * @return
	 * @throws DBAccessException
	 */
	public User searchByAccount(String account) throws DBAccessException; 
	
}

