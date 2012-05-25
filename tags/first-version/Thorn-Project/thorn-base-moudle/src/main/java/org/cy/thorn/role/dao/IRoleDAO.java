package org.cy.thorn.role.dao;

import java.util.List;

import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.role.entity.Authority;
import org.cy.thorn.role.entity.UserRole;

/**
 * <p>文件名称: IRoleDAO.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-20</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public interface IRoleDAO {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-21
	 * @Description：根据UID找到对应的roleID集合（查找用户所拥有的角色）
	 * @param uid
	 * @return
	 * @throws DBAccessException
	 */
	public List<UserRole> searchRoleByUid(String uid) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-21
	 * @Description：找到能够访问该资源的角色
	 * @param rid
	 * @return
	 * @throws DBAccessException
	 */
	public List<Authority> searchRoleByResorce(String rid) throws DBAccessException;
}

