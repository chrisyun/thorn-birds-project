package org.cy.thorn.jbpm;

import org.jbpm.api.Configuration;
import org.jbpm.api.ProcessEngine;

/** 
 * @ClassName: Deploy 
 * @Description: TODO
 * @author chenyun
 * @date 2012-4-25 上午11:36:10 
 */
public class Deploy {

	/**
	 * @Description：TODO
	 * @author：chenyun 	        
	 * @date：2012-4-25 上午11:36:10
	 * @param args
	 */

	public static void main(String[] args) {
		
		ProcessEngine engine = new Configuration().setResource("jbpm.cfg.xml").buildProcessEngine();
		 
		 //从流程引擎中获得跟数据库操作有关的服务
		engine.getRepositoryService()
			.createDeployment() //现在要部署流程定义
			.addResourceFromClasspath("SimpleProcess.jpdl.xml") //添加流程定义文件
			.deploy(); //部署，将流程定义的相关信息插入数据库\

	}

}

