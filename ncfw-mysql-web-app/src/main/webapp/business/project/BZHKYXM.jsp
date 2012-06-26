<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.talkweb.security.SecurityHelper"%>
<%@page import="com.talkweb.ncfw.entity.Org"%>
<%@page import="com.talkweb.ncfw.action.OrgAction"%>
<%@ include file="/foundation/ext/jsp/taglib.jsp"%>
<%@ include file="/foundation/ext/jsp/workspace.jsp"%>
<%
	Org org = SecurityHelper.getCurrentUser().getOrg();
	User user = SecurityHelper.getCurrentUser().getUser();
	String roleId = user.getRoleid();
	String pid = request.getParameter("pid")==null?"":request.getParameter("pid");
	String openType = request.getParameter("openType")==null?"":request.getParameter("openType");
	
	String sbDept = "";
	if("ZB".equals(org.getProvinceNumber()) && "DW".equals(org.getOrgtype())) {
		sbDept = user.getUserid();
	} else {
		sbDept = org.getOrgsbname()==null?"":org.getOrgsbname();
	}
%>
<html>
<head>
	<title>标准化科研项目</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>foundation/ext/ext-plugins/lovcombo-1.0/css/Ext.ux.form.LovCombo.css"/>
	<script type="text/javascript" src="<%=basePath%>foundation/ext/ext-plugins/lovcombo-1.0/js/Ext.ux.form.LovCombo.js"></script>
	<script type="text/javascript" src="<%=basePath%>foundation/ext/ext-plugins/TreeField.js"></script>
	<script type="text/javascript" src="<%=basePath%>foundation/ext/ext-plugins/SearchField.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>foundation/ext/ext-plugins/file-upload.css" />
	<script type="text/javascript" src="<%=basePath%>foundation/ext/ext-plugins/FileUploadField.js"></script>
	<script type="text/javascript" src="<%=basePath%>business/file/fileManager.js"></script>
	<script type="text/javascript" src="./Project.js"></script>
	<script type="text/javascript" src="./Minds.js"></script>
	
	
	<script type="text/javascript">

	var orgType = '<%=org.getOrgtype() %>';
	var pid = '<%=pid %>';
	var openType = '<%=openType%>';
	var user = '<%=user.getUserid()%>';
	var roleId	= '<%=roleId%>';
	var proprovincecode = '<%=user.getProvincenumber()%>';
	var sbDeptName = '<%=sbDept%>';
	
	var fileMan = new FileManager("fileListPanel",pid,"t_project","view","common");
    //数据字典
    var DataDict = {
    	flowStatusArray				: <ncframework:dictWrite dicttypeId="FLOW_STATUS" type="array"/>,
    	projectStatusArray			: <ncframework:dictWrite dicttypeId="PROJECT_STATUS" type="array"/>,
    	projectTypeArray			: <ncframework:dictWrite dicttypeId="PROJECT_TYPE" type="array"/>,
    	activityNameArray			: <ncframework:dictWrite dicttypeId="FLOW_ACTIVITYNAME" type="array"/>,
    	pwProjectTypeArray			: <ncframework:dictWrite dicttypeId="PW_PROJECT_TYPE" type="array"/>,
    	projectZTypeArray			: <ncframework:dictWrite dicttypeId="PROJECT_ZTYPE" type="array"/>,
    	projectSBTypeArray			: <ncframework:dictWrite dicttypeId="PROJECT_SB_TYPE" type="array"/>,
   		provinceCodeArray			: <ncframework:dictWrite dicttypeId="COMMON_PROVINCE" type="array"/>
   	};

   	//本地转化
   	var LocalRenderer = {
   		flowStatus				: function (flowStatus) {
			return Common.renderer.dictRender (DataDict.flowStatusArray, flowStatus);
   		},
   		projectStatus			: function (projectStatus) {
			return Common.renderer.dictRender (DataDict.projectStatusArray, projectStatus);
   		},
   		projectType				: function (projectType) {
			return Common.renderer.dictRender (DataDict.projectTypeArray, projectType);
   		},
   		activityName			: function (activityName) {
			return Common.renderer.dictRender (DataDict.activityNameArray, activityName);
   		},
   		projectZType			: function (projectZType) {
			return Common.renderer.dictRender (DataDict.projectZTypeArray, projectZType);
   		},
   		projectSBType			: function (projectSBType) {
			return Common.renderer.dictRender (DataDict.projectSBTypeArray, projectSBType);
   		},
   		provincenumber			: function (value) {
			return Common.renderer.dictRender (DataDict.provinceCodeArray, value);
   		}
   	};

	//初始化页面信息
	function initPage () {
		if(openType == 'pending') {
			fileMan.editMode = 'edit';
		} else if(openType == 'pendingZQ' || openType == 'pendingJX') {
			Ext.getCmp('fileUploadButton').hide();
		} else if(openType == 'searchList') {
			Ext.getCmp('fileUploadButton').hide();
			Project.gotoUrl = sys.basePath + 'business/project/projectList.jsp';
		} else if(openType == 'searchStore') {
			Ext.getCmp('fileUploadButton').hide();
			Project.gotoUrl = sys.basePath + 'business/project/projectStore.jsp';
		} else {
			//新建页面
			fileMan.editMode = 'edit';
		}
		
		
		flowBaseInfo.hide();
		
		if(!Ext.isEmpty(pid)) {
			Project.queryProject(pid);

			//增加中期检查
			Project.queryMedProjectId(pid);
			//增加结项检查
			Project.queryFinProjectId(pid);

			//显示意见
			searchMinds(pid,"t_project","minds-div");
		} else {
			//新建
			Project.generateProjectNum("BZHKYXM");
			Ext.getCmp('sborg').setValue(sbDeptName);
		}

		if(roleId != 'projectsp' || 'ZB' != proprovincecode) {
			Ext.getCmp('pw_panel').hide();
		}
	}

	function initPageShow() {
		//待办打开
		if(openType == 'pending') {
			//非起草环节
			if(Ext.getCmp('curActivityName').getValue() != 'DRAFT') {
				flowBaseInfo.show();
				Ext.getCmp('sb_Btn').hide();
				Ext.getCmp('sp_ok_Btn').show();
				Ext.getCmp('sp_not_Btn').show();
				Ext.getCmp('return_Btn').show();
			} else {
				Ext.getCmp('return_Btn').show();
			}
		} else if(openType == 'pendingZQ' || openType == 'pendingJX') {
			Ext.getCmp('sb_Btn').hide();
		} else if(openType == 'searchList') {
			//申报项目查询打开
			flowBaseInfo.show();
			Ext.getCmp('return_Btn').show();
			Ext.getCmp('sb_Btn').hide();
		} else if(openType == 'searchStore') {
			//项目成果库查询打开
			flowBaseInfo.show();
			Ext.getCmp('return_Btn').show();
			Ext.getCmp('sb_Btn').hide();

			//如果是起草人，则显示中间检查按钮和结项按钮
			if(Ext.getCmp('creater').getValue() == user 
					&& Ext.getCmp('curActivityName').getValue() == "FINISH"
					&& Ext.getCmp('pstatus').getValue() != "XMJX") {
				Ext.getCmp('zq_pro_Btn').show();
				Ext.getCmp('jx_pro_Btn').show();
			}

			//如果是文化部用户，并且为审批人
			if(roleId == 'projectsp' && 'ZB' == proprovincecode) {
				Ext.getCmp('up_pro_Btn').show();
			}
			
		} 
	}
    </script>
</head>
  <body>
    <ext:ext onReady="initPage();">
	  	<ext:viewport layout="border" otherProperties="split: true">
	  		<ext:items>
	  		<ext:tabPanel region="center" border="false" frame="false" otherProperties="activeTab: 0" var="tabPanel">
	  			<ext:items>
  				<ext:panel title="标准化科研项目" layout="border" border="false" iconCls="icon_plugin">
  					<ext:items>
	   					<%-- 列表面板 --%>
	   					<ext:panel var="mainPanel" layout="border" border="false" otherProperties="split: true" region="center"
	   						margins="3 0 0 0" otherProperties="buttonAlign: 'center'">
	   						<ext:items>
								<ext:formPanel var="submitPrjFormPanel" id="submitPrjFormPanel" collapsible="false"
									labelAlign="right" frame="true" region="center" border="false" autoScroll="true" autoWidth="true"
									labelWidth="200" otherProperties="split: true">
									<ext:items>
										<ext:fieldSet layout="column" defaults="{columnWidth: 1, layout: 'form'}" lazyInit="true" 
											xtype="fieldset" autoHeight="true" title="基本信息" collapsible="true" var="projectBaseInfo" 
											frame="true">
											<ext:items>
												<ext:hidden name="project.pid" id="pid"></ext:hidden>
												<ext:hidden name="project.creater" id="creater"></ext:hidden>
												<ext:hidden name="project.proprovincecode" id="proprovincecode"></ext:hidden>
												<ext:hidden name="project.pmtype" id="pmtype" value="BZHKY"></ext:hidden>
												
												<ext:panel lazyInit="true">
													<ext:items>
														<ext:textField id="pname" name="project.pname" fieldLabel="项目名称<span class='red'>(必填)</span>" allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
														</ext:textField>
													</ext:items>
												</ext:panel>
												<ext:panel lazyInit="true">
													<ext:items>
														<ext:textField id="pslnumber" name="project.pslnumber" readOnly="true" fieldLabel="项目编号" allowBlank="true" otherProperties="anchor: Project.fieldAnchor">
														</ext:textField>
													</ext:items>
												</ext:panel>
												<ext:panel lazyInit="true">
													<ext:items>
														<ext:textField id="hyorg" name="project.hyorg" fieldLabel="行业主管部门<span class='red'>(必填)</span>" allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
														</ext:textField>
													</ext:items>
												</ext:panel>
												<ext:panel lazyInit="true">
													<ext:items>
														<ext:textField id="jsorg" name="project.jsorg" fieldLabel="所属标准化技术委员会<span class='red'>(必填)</span>" allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
														</ext:textField>
													</ext:items>
												</ext:panel>
												<ext:panel lazyInit="true">
													<ext:items>
														<ext:textField id="cdorg" name="project.cdorg" fieldLabel="项目承担单位<span class='red'>(必填)</span>"  allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
														</ext:textField>
													</ext:items>
												</ext:panel>
												
												<ext:container layout="column" defaults="{width: 480, layout: 'form'}" lazyInit="true">
													<ext:items>
														<ext:panel lazyInit="true">
															<ext:items>
																<ext:textField id="pmanager" name="project.pmanager"  width="250" fieldLabel="项目负责人<span class='red'>(必填)</span>"  allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
																</ext:textField>
															</ext:items>
														</ext:panel>
														<ext:panel lazyInit="true">
															<ext:items>
																<ext:textField id="tel" name="project.tel" width="280" fieldLabel="联系电话<span class='red'>(必填)</span>"  allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
																</ext:textField>
															</ext:items>
														</ext:panel>
													</ext:items>
												</ext:container>
												
												<ext:panel lazyInit="true">
													<ext:items>
														<ext:textField id="email" name="project.email" fieldLabel="E-mial<span class='red'>(必填)</span>"  allowBlank="false" otherProperties="anchor: Project.fieldAnchor">
														</ext:textField>
													</ext:items>
												</ext:panel>
												
												<ext:container lazyInit="true" id="pw_panel" otherProperties="hidden:false">
													<ext:items>
														<ext:comboBox id="pwtype" hiddenName="project.pwtype"
															fieldLabel="评委分类"
															displayField="text" mode="local" triggerAction="all"
															selectOnFocus="true" forceSelection="true" width="500"
															valueField="value" value="" editable="false"
															store="new Ext.data.SimpleStore({
																fields : ['value', 'text'],
																data : Common.config.nullArray.concat(DataDict.pwProjectTypeArray)
															})">
														</ext:comboBox>
													</ext:items>
												</ext:container>
												
											</ext:items>
										</ext:fieldSet>
										
										
										<ext:fieldSet layout="column" defaults="{columnWidth: 1, layout: 'form'}" lazyInit="true" 
											xtype="fieldset" autoHeight="true" title="附件信息" collapsible="true" var="fileBaseInfo" 
											frame="true" otherProperties="buttonAlign: 'left'">
											<ext:items>
												<ext:panel xtype="panel" lazyInit="true" id="fileListPanel" layout="column"  html="<div id='fileListPanel_text'></div>"
													defaults="{columnWidth: .5, layout: 'form'}">
												</ext:panel>
											</ext:items>
											<ext:buttons>
												<ext:button text="文件上传" iconCls="icon_add" style="margin-right:20px;" id="fileUploadButton"
													handler="FileConstant.showUploadWindow" otherProperties="minWidth: Common.config.buttonWidth.defaultButton">
												</ext:button>
											</ext:buttons>
										</ext:fieldSet>
										
										<ext:fieldSet layout="column" defaults="{columnWidth: 1, layout: 'form'}" lazyInit="true" 
											xtype="fieldset" autoHeight="true" title="流程意见" collapsible="true" frame="true">
											<ext:items>
												<ext:container layout="column" defaults="{layout: 'form'}" lazyInit="true">
													<ext:items>
														<ext:panel lazyInit="true" html="<div id='minds-div'><div>"></ext:panel>
														<ext:container lazyInit="true">
															<ext:items>
																<ext:textArea  fieldLabel='填写意见' id='minds' name="minds" width="640" height="70"></ext:textArea>
															</ext:items>
														</ext:container>
													</ext:items>
												</ext:container>
											</ext:items>
										</ext:fieldSet>
										
										<ext:fieldSet layout="column" defaults="{columnWidth: 1, layout: 'form'}" lazyInit="true" 
											xtype="fieldset" autoHeight="true" title="审批信息" collapsible="true" var="flowBaseInfo" 
											frame="true">
											<ext:items>
												<ext:container layout="column" defaults="{width: 450, layout: 'form'}" lazyInit="true">
													<ext:items>
														<ext:container lazyInit="true">
															<ext:items>
																<ext:textField  fieldLabel='当前环节' id='curActivityNameShow' width="200" readOnly="true"></ext:textField>
																<ext:hidden id="curActivityName" name="project.curActivityName"></ext:hidden>
															</ext:items>
														</ext:container>
														<ext:container lazyInit="true">
															<ext:items>
																<ext:textField  fieldLabel='项目状态' id='pstatusShow' width="200" readOnly="true"></ext:textField>
																<ext:hidden id="pstatus" name="project.pstatus"></ext:hidden>
															</ext:items>
														</ext:container>
														<ext:container lazyInit="true">
															<ext:items>
																<ext:textField  fieldLabel='审批状态' id='spstatusShow' width="200" readOnly="true"></ext:textField>
																<ext:hidden id="spstatus" name="project.spstatus"></ext:hidden>
															</ext:items>
														</ext:container>
													</ext:items>
												</ext:container>
											</ext:items>
										</ext:fieldSet>
									</ext:items>
								</ext:formPanel>
	   						</ext:items>
	   						
	   						<ext:buttons>
								<ext:button id="sb_Btn" text="项目申报" handler="function() {Project.submintProject(pid,'NONSP');}" iconCls="icon_sure" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
								<ext:button id="sp_ok_Btn" text="审批通过" hidden="true" handler="function() {Project.submintProject(pid,'SUCCESS');}" iconCls="icon_sure" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
								<ext:button id="zq_pro_Btn" text="项目中期检查申报" hidden="true" handler="function() {Project.projectMed(pid);}" iconCls="icon_sure" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
								<ext:button id="sp_not_Btn" text="审批不通过" hidden="true" handler="function() {Project.submintProject(pid,'FAILURE');}" iconCls="icon_unUse" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
								<ext:button id="jx_pro_Btn" text="项目结项申报" hidden="true" handler="function() {Project.projectFin(pid);}" iconCls="icon_sure" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
								<ext:button id="up_pro_Btn" text="修改" hidden="true" handler="function() {Project.updateProject();}" iconCls="icon_sure" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
								<ext:button id="return_Btn" text="返回" hidden="true" handler="function() { Project.gotoPending();}" iconCls="icon_close" otherProperties="minWidth: Common.config.buttonWidth.defaultButton"></ext:button>
							</ext:buttons>
	   					</ext:panel>
   					</ext:items>
   				</ext:panel>
	  			</ext:items>
	  		</ext:tabPanel>
	  		</ext:items>
	  	</ext:viewport>
    </ext:ext>
  </body>
  
</html>
