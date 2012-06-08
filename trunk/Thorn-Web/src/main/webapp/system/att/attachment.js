var attPageUrl = sys.path + "/att/getAttsPage";

var pageSize = 20;

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 70,
		labelWidth : 70
	};

	var query_form = new FormUtil(query_attr);

	query_form.addComp(getDateText("query_startTime", "开始日期", 120, new Date()
							.add(Date.MONTH, -1)), 0.2, true);
	query_form.addComp(getDateText("query_endTime", "结束日期", 120), 0.2, true);
	query_form.addComp(getText("query_user", "上传用户", 120), 0.25, true);
	query_form.addComp(getText("query_type", "文件类型", 120), 0.25, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.2, true);
	/** ****************query panel end*************** */

	/** ****************log Grid panel start************ */
	var store = new Ext.data.Store({
		url : attPageUrl,
		remoteSort : true,
		reader : new Ext.data.JsonReader({
					totalProperty : "total",
					root : "reslutSet"
				}, Ext.data.Record.create( [ {
					name : 'id',
					type : 'string',
					mapping : 'id'
				}, {
					name : 'fileName',
					type : 'string',
					mapping : 'fileName'
				},  {
					name : 'fileType',
					type : 'string',
					mapping : 'fileType'
				},  {
					name : 'uploadTime',
					type : 'string',
					mapping : 'uploadTime'
				},  {
					name : 'uploader',
					type : 'string',
					mapping : 'uploader'
				} ]))
	});
	
    var dataview = new Ext.DataView({
        store: store,
        tpl  : new Ext.XTemplate(
            '<ul>',
                '<tpl for=".">',
                    '<li class="att">',
                        '<img width="64" height="64" src="'+ sys.path + '"/resources/images/fileType/{fileType}.ico" />',
                        '<strong>{fileName}</strong>',
                        '<span>{uploader} - {uploadTime}</span>',
                    '</li>',
                '</tpl>',
            '</ul>'
        ),
        
        plugins : [
            new Ext.ux.DataViewTransition({
                duration  : 550,
                idProperty: 'id'
            })
        ],
        id: 'attManager',
        itemSelector: 'li.att',
        overClass   : 'phone-hover',
        singleSelect: true,
        multiSelect : true,
        autoScroll  : true
    });	
	
    var pageBar = new Ext.PagingToolbar({
		store : store,
		pageSize : pageSize,
		displayInfo : true,
		displayMsg : "当前显示{0}-{1}条,共{2}条",
		emptyMsg : "没有找到相关记录",
		emptyMsg : "没有找到相关记录",
		firstText : "第一页",
		prevText : "上一页",
		nextText : "下一页",
		lastText : "最后页",
		refreshText : "刷新",
		afterPageText : "页,共{0}页",
		beforePageText : "当前第"
	});
    
    
	var attPanel = new Ext.Panel({
        title: 'Animated DataView',
        layout: 'fit',
        region : "center",
        collapsible : true,
        iconCls : "silk-grid",
        items : dataview,
        loadMask : true,
		split : true,
        bbar : pageBar
    });
	


	function onSubmitQueryHandler() {
		var thisForm = query_form.getForm();

		var startTime = Ext.getCmp("query_startTime").getValue()
				.format("Y-m-d");
		var endTime = Ext.getCmp("query_endTime").getValue().format("Y-m-d");
		var uploader = Ext.getCmp("query_user").getValue();
		var fileType = Ext.getCmp("query_type").getValue();

		store.baseParams.fileType = fileType;
		store.baseParams.uploader = handleResult;
		store.baseParams.startTime = startTime;
		store.baseParams.endTime = endTime;

		store.load({
					params : {
						start : 0,
						limit : pageSize
					}
				});
	}

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), attPanel]
			});

	onSubmitQueryHandler();
	completePage();
});
