<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<jsp:include page="../core/meta.jsp"></jsp:include>
		<title>Home - Page</title>
	</head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";	
%>
	<jsp:include page="../core/core.jsp"></jsp:include>

	<script type="text/javascript">
	var tabNum = 0;
	
	Ext.onReady(function() {
		Ext.QuickTips.init();

		var loader = new Ext.tree.TreeLoader( {
			url : sys.basePath + "/resource/generateTree.xhtml"
		});
		loader.on("beforeload", function(loader, node) {
			loader.baseParams.parentId = node.id;
		});
		
		var sysMenuTree = new Ext.tree.TreePanel( {
		    autoScroll:true,
		    border: false,
		    iconCls: 'nav',
		    useArrows: true,
			rootVisible: false,
		 	loader: loader,
			root : new Ext.tree.AsyncTreeNode({
				text : "系统管理",
				id: 'SYS_RES',
				leaf: false
			})
		});
		
		var navMenuTree = new Ext.tree.TreePanel( {
		    autoScroll:true,
		    border: false,
		    iconCls: 'nav',
		    useArrows: true,
			rootVisible: false,
			loader: loader,
			root : new Ext.tree.AsyncTreeNode({
				text : "导航菜单",
				id: 'NAV_RES',
				leaf: false
			})
		});
		
		var skinItemArray = [{
			text: '传统',
			handler : function(){
				setActiveStyleSheet("blue");
			}
		},{
			text: '银灰',
			handler : function(){
				setActiveStyleSheet("gray");
			}
		},{
			text: 'xtheme-black',
			handler : function(){
				setActiveStyleSheet("xtheme-black");
			}
		},{
			text: 'xtheme-blue03',
			handler : function(){
				setActiveStyleSheet("xtheme-blue03");
			}
		},{
			text: 'xtheme-brown',
			handler : function(){
				setActiveStyleSheet("xtheme-brown");
			}
		},{
			text: 'xtheme-brown02',
			handler : function(){
				setActiveStyleSheet("xtheme-brown02");
			}
		},{
			text: 'xtheme-gray',
			handler : function(){
				setActiveStyleSheet("xtheme-gray");
			}
		},{
			text: 'xtheme-green',
			handler : function(){
				setActiveStyleSheet("xtheme-green");
			}
		},{
			text: 'xtheme-pink',
			handler : function(){
				setActiveStyleSheet("xtheme-pink");
			}
		},{
			text: 'xtheme-purple',
			handler : function(){
				setActiveStyleSheet("xtheme-purple");
			}
		},{
			text: 'xtheme-red03',
			handler : function(){
				setActiveStyleSheet("xtheme-red03");
			}
		},{
			text: '黑色',
			handler : function(){
				setActiveStyleSheet("access");
			}
		}];

		
		var menuPanel = new Ext.Panel( {
			region : 'west',
			title : '当前用户：' + user.username,
			split : true,
			width : 200,
			minSize : 175,
			maxSize : 400,
			collapsible : true,
			margins : '2 0 2 0',
			layout : {
				type : 'accordion',
				animate : true
			},
			items : [ {
				title : '导航菜单',
				border : false,
				iconCls : 'silk-nav',
				items : [navMenuTree]
			}, {
				title : '系统管理',
				html : '',
				border : false,
				iconCls : 'silk-settings',
				items : [sysMenuTree]
			} ],
			tbar : [ {
				text : '选项',
				iconCls : 'silk-application-view-list',
				menu : new Ext.menu.Menu( {
					items : [ {
						text : '更换皮肤',
					 	menu: {
               				items: skinItemArray
               			}
					}, {
						text : '注销',
						iconCls : 'silk-logout',
						handler : logout
					} ]
				})
				}, "-", {
					text : "刷新",
					iconCls : 'silk-table-refresh',
					handler: function(){
						sysMenuTree.getRootNode().reload();
						navMenuTree.getRootNode().reload();
	    			}
				}]
		});

		var mainTab = new Ext.TabPanel( {
			region : 'center',
			activeTab : 0,
			margins : '2 0 2 0',
			resizeTabs : true,
			border : false,
			minTabWidth : 200,
			items : [ {
				title : "首页",
				autoScroll : true
			}]
		});

		var treeClick = function(node, ev){
			var isMoudle = node.attributes.attributes.isModule;
			var openUrl = sys.basePath + node.attributes.attributes.url;

			if(isMoudle == "YES") {
				return ;
			}

			if(!Ext.isEmpty(openUrl)){
    			var prefix = '?';
    			if (openUrl.indexOf('?') > -1) {
    				prefix = '&'
        		}
    			openUrl = openUrl + prefix + "random=" + Math.random();
           	}
			
			
			var activateId = mainTab.getActiveTab().getItemId();
			
			if(tabNum < 2) {
				tabNum++;
			} else if(activateId != node.id) {
				mainTab.remove(1);
			}
			
			mainTab.add( {
				title : node.text,
				html : "<iframe src='"+ openUrl +"' width='100%' height='100%' frameborder='0'></iframe>",
				id : node.id,
				closable : true,
				listeners : {beforeclose:function(){
					tabNum--;
				}}	
			});
			mainTab.activate(node.id);
		}
		
		navMenuTree.on('click',function(node, ev){
			treeClick(node,ev);
		});

		sysMenuTree.on('click',function(node, ev){
			treeClick(node,ev);
       	});
		
		var viewport = new Ext.Viewport( {
			layout : "border",
			items : [ {
				region : "north",
				height : 67,
				contentEl: 'header'
			}, menuPanel, mainTab/*, {
				region : "south",
				height : 50,
				html : "this is the title"
			} */]
		});
	});

	function logout() {
		var rt = Ext.Msg.show( {
			buttons : Ext.Msg.YESNO,
			maxWidth : 200,
			minWidth : 300,
			msg : "<div style='margin: 5 5 8 15px;'>您确定退出本系统?</div>",
			title : "注销提示",
			icon : Ext.Msg.WARNING,
			fn : function(btn) {
				if ('yes' == btn) {
					window.location.href = sys.path
							+ "/j_spring_security_logout";
				}
			}
		});
	}
</script>

	<body>
		<div id="header">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
			   		<td width="664"><img src="<%=basePath %>/plugins/images/title-1.jpg" width="664" height="67" /></td>
			    	<td background="<%=basePath %>/plugins/images/title-2.jpg">&nbsp;</td>
			    	<td width="372"><img src="<%=basePath %>/plugins/images/title-3.jpg" width="372" height="67" /></td>
			  	</tr>
			</table>
		</div>
	
	</body>
</html>
