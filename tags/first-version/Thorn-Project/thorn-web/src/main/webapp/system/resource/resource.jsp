<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<jsp:include page="../../core/meta.jsp"></jsp:include>
		<title>Resource</title>
	</head>
	<jsp:include page="../../core/core.jsp"></jsp:include>
	<script type="text/javascript" src="resource.js"></script>
	<script type="text/javascript">
	var dtgrid;
	var ddgrid;

	Ext.onReady(function() {
		Ext.QuickTips.init();

		var searchPanel = new Ext.FormPanel( {
			title : "查询条件",
			iconCls : 'icon-grid',
			region : "north",
			bodyStyle : 'padding-top: 7px;',
			collapsible : true,
			height : 60,
			margins : "2 0 2 0",
			layout : 'column',
			//border : false,
			id : "queryFormPanel",
			split : true,
			defaults : {
				bodyStyle : 'padding-left: 30px;',
				xtype : "panel",
				border : false,
				layout : "form"
			},
			items : [ {
				columnWidth : 0.3,
				items : [ {
					id : "filter_ename",
					name : "filter_ename",
					fieldLabel : "资源编码",
					xtype : 'textfield',
					labelAlign : "right",
					width : 140
				} ]
			}, {
				columnWidth : 0.3,
				items : [ {
					id : "filter_cname",
					name : "filter_cname",
					fieldLabel : "资源名称",
					xtype : 'textfield',
					labelAlign : "right",
					width : 140
				} ]
			}, {
				layout : "column",
				columnWidth : 0.4,
				items : [ {
					text : "查询",
					iconCls : 'slik-search',
					style : "margin-right:20px;",
					xtype : 'button',
					minWidth : 70,
					handler : function() {
						onSubmitQueryHandler();
					}
				}]
			} ]
		});

		var dt = new DictType();
		var dd = new DictData();

		dtgrid = new Ext.grid.GridPanel( {
			region : "center",
			height : 200,
			title : '字典类型列表',
			collapsible : true,
			iconCls : 'silk-grid',
			margins : "0 0 2 0",
			loadMask : true,
			store : dt.dataStore,
			cm : dt.columnModel,
			bbar : dt.pagingBar,
			viewConfig : {
				forceFit : true
			},
			sm : dt.csModel,
			listeners : {
				celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
					dt.onUpdate();
				},
				cellclick : function(thisGrid, rowIndex, columnIndex, ev) {
					var record = thisGrid.getStore().getAt(rowIndex);
					var typeid = record.get("ename");
					dd.typeid = typeid;
					ddgrid.getStore().load( {
						params : {
							"typeid" : typeid
						}
					});
				}
			}
		});

		ddgrid = new Ext.grid.GridPanel( {
			region : "south",
			height : 200,
			title : '字典数据列表',
			collapsible : true,
			iconCls : 'silk-grid',
			margins : "0 0 2 0",
			loadMask : true,
			store : dd.dataStore,
			cm : dd.columnModel,
			bbar : dd.pagingBar,
			viewConfig : {
				forceFit : true
			},
			sm : dd.csModel,
			listeners : {
				celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
					dd.onUpdate();
				}
			}
		});

		/**
		 *查询按钮提交方法	
		 */
		var onSubmitQueryHandler = function() {
			var thisForm = searchPanel.getForm();
			var store = dtgrid.getStore();

			if (store.baseParams == null) {
				store.baseParams = {};
			}

			var cname = Ext.getCmp("filter_cname").getValue();
			var ename = Ext.getCmp("filter_ename").getValue();

			store.baseParams.filter_ename = ename;
			store.baseParams.filter_cname = cname;

			store.reload( {
				params : {
					start : 0,
					limit : dt.dtPagingSize
				}
			});
		}

		/**
		 *刷新缓存按钮
		 */
		var onRefreshCacheHandler = function() {
			var refUrl = sys.basePath + "dd/refreshCache.xhtml";

			var ajaxClass = new CommonAjax(refUrl);
			ajaxClass.request(null, true, null, function(obj) {
				dtgrid.getStore().reload( {
					params : {
						start : 0,
						limit : dt.dtPagingSize
					}
				});
				ddgrid.getStore().removeAll();
			});

		}

		var viewport = new Ext.Viewport( {
			border : false,
			layout : "border",
			items : [ searchPanel, dtgrid, ddgrid ]
		});

		dtgrid.getStore().load( {
			params : {
				"start" : 0,
				"limit" : dt.dtPagingSize
			}
		});

	});
</script>

	<body>

	</body>
</html>
