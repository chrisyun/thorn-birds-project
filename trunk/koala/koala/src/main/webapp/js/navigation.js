$(function() {

	if ($.utils.isEmpty(user.userId)) {
		return;
	}

	menuTree = eval("(" + $("#userJsonTree").html() + ")");

	var firstNodes = menuTree.children;
	var navArray = formatTree(firstNodes);
	
	var paths = thisUrl.split("/");

	for ( var i = 0; i < navArray.length; i++) {

		// 完成导航条
		var nav = navArray[i];
		$("#_navigationBar").append('<li class="divider-vertical"></li>');
		$("#_navigationBar").append(
				'<li><a href="' + sys.path + nav.targetUrl + '" id="_nav_'
						+ nav.id + '">' + nav.text + '</a></li>');
		
		if (paths[1] == nav.id) {
			// 生成菜单树
			createMenu(nav);
		}
	}

	// 高亮导航条选项
	if (paths[1] == "common" && paths[2] == "mySetting") {

		var mySettingTree = new Object();
		mySettingTree.id = "mySetting";
		mySettingTree.text = "个人设置";

		var mySettingLeaf = new Array();
		var leaf = new Object();
		leaf.id = "userInfo";
		leaf.text = "个人资料修改";
		leaf.targetUrl = "/common/mySetting/userInfo.jhtml";
		leaf.sort = 0;
		mySettingLeaf.push(leaf);

		leaf = new Object();
		leaf.id = "modifyPassword";
		leaf.text = "密码修改";
		leaf.sort = 1;
		leaf.targetUrl = "/common/mySetting/changeMyPassword.jhtml";
		mySettingLeaf.push(leaf);

		leaf = new Object();
		leaf.id = "themeSetting";
		leaf.text = "更换主题";
		leaf.targetUrl = "/common/mySetting/theme.jhtml";
		leaf.sort = 2;
		mySettingLeaf.push(leaf);

		mySettingTree.children = mySettingLeaf;

		createMenu(mySettingTree);

		$("#_nav_mySetting").addClass("active");
	} else if (paths[1] == "CMS" || paths[1] == "System"
			|| paths[1] == "System") {
		$("#_nav_" + paths[1]).parent("li").addClass("active");
	}
	
	var urlFinder = false;
	$("#_menuTree > ul > li").each(function() {
		var href = $(this).find("a").attr("href");

		if (href.indexOf(thisUrl) >= 0 && href != undefined) {
			$(this).addClass("active");
			urlFinder = true;
		}
	});
	
	if(!urlFinder) {
		var lastli = $("ul[class=breadcrumb] li[class=active]").prev("li");
		var url = lastli.find("a").attr("href");
		
		$("#_menuTree > ul > li").each(function() {
			var href = $(this).find("a").attr("href");
			
			if(href.indexOf(url) >= 0 && href != undefined) {
				$(this).addClass("active");
			}
		});
	}

	function createMenu(pNode) {

		var children = formatTree(pNode.children);

		var _menu = $('<ul class="nav nav-tabs nav-stacked"></ul>');
		_menu.append('<li><a href="' + sys.path + pNode.targetUrl + '"><i class="icon-plus"></i><b>'
						+ pNode.text + '</b></a></li>');

		for ( var i = 0; i < children.length; i++) {

			var _node = children[i];
			
			_menu.append('<li><a href="' + sys.path + _node.targetUrl
							+ '"><i class="icon-minus"></i>' + _node.text
							+ '</a></li>');
		}

		$("#_menuTree").append(_menu);
	}

	function formatTree(nodes) {

		var navArray = new Array();

		for ( var i = 0; i < nodes.length; i++) {
			var node = nodes[i];

			var sort = parseInt(node.sort, 10);
			if ($.utils.isEmpty(sort)) {
				sort = 0;
			}
			while (!$.utils.isEmpty(navArray[sort])) {
				sort++;
			}

			navArray[sort] = node;
		}

		var newArray = new Array();
		for ( var i = 0; i < navArray.length; i++) {
			if (!$.utils.isEmpty(navArray[i])) {
				newArray.push(navArray[i]);
			}
		}

		return newArray;
	}

});