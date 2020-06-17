<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>

<%@ page import="java.text.SimpleDateFormat"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	Map<Object,Object> user = (Map<Object,Object>)session.getAttribute("user");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>渔业综合管理系统</title>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aYAevyCN9zbD9MouBBmXUNGaiAig1dWf"></script>
<jsp:include page="/common.jsp"></jsp:include>
<style>
#MainMenu_Accordion .tree-title {
	font-size: 15px;
}

#MainMenu_Accordion .tree-node {
	padding: 3px;
}

#MainMenu_Accordion .panel-title {
	padding-left:26px;
	font-size:16px;
}

#MainMenu_Accordion .accordion-header{
	padding: 8px 5px;
}

#MainMenu_Accordion .tree-icon {
	display: none;
}

#MainMenu_Accordion i.fa {
	padding-right: 3px;
	font-size: 16px;
	color: #1175B0;
}

#MainMenu_Accordion .accordion-header-selected i.fa {
	color: white;
}
</style>
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/font-awesome-4.7.0/css/font-awesome.min.css">
</head>

<body style=''>
	<input type="hidden" id="basePath" value="${basePath}" />
	<div class="easyui-layout" id="main_layout" data-options="fit:true">
		<div data-options="region:'north'" style="height:70px;background:url(<%=basePath%>image/bg.png);background-size:3pxm 150%" id="main_header">
			<div style="float:left;font-weight:bold;font-size:25px;line-height:66px;padding:0 20px;color:white;">渔业综合管理平台</div>
			<div style="float:right;margin-right:10px;color:white">
				<div style="padding-top:18px;text-align:center;">
					<i style="font-size:15px;" class="fa fa-user-circle-o"></i>
					<%=user.get("realname").toString()%>
				</div>
				<div style="padding-top:5px;text-align:right; ">
					<a style="color:#D0E6DE;" href="<%=basePath%>system/exit">退出</a>
					<a style="color:#D0E6DE;" href="javascript:;" onclick="editPwd()">修改密码</a>
				</div>
			</div>
		</div>
		<div data-options="region:'west',split:true" style="width:180px;" id="main_menu">
			<div class="easyui-accordion" data-options="fit:true" id="MainMenu_Accordion">
				<%
					List<Map<Object, Object>> menus = (List<Map<Object, Object>>) request.getAttribute("menus");
					for (Map<Object, Object> menu : menus) {
						int menuId = Integer.parseInt(menu.get("menuId").toString());
						int menuLevel = Integer.parseInt(menu.get("menuLevel").toString());
						String menuName = menu.get("menuName").toString();
						String iconUrl = menu.get("iconUrl") == null ? "fa-cogs" : menu.get("iconUrl").toString();
						if (menuLevel == 1) {
				%>
				<div title='<i class="fa fa-fw <%=iconUrl%>"></i><%=menuName%>' style="overflow:auto;padding:10px;">

					<%
						for (Map<Object, Object> menu2 : menus) {
							int menuLevel2 = Integer.parseInt(menu2.get("menuLevel").toString());
							int menuId2 = Integer.parseInt(menu2.get("menuId").toString());
							String menuName2 = menu2.get("menuName").toString();
							int parentId2 = Integer.parseInt(menu2.get("parentId").toString());
							String menuUrl2 = menu2.get("menuUrl") == null ? "" : menu2.get("menuUrl").toString();
							String iconUrl2 = menu2.get("iconUrl") == null ? "fa-cog" : menu2.get("iconUrl").toString();
							if (menuLevel2 == 2 && parentId2 == menuId) {
					%>
					<ul class="easyui-tree" data-options="lines:false">
						<li>

							<%
								if (!menuUrl2.equals("")) {
							%>
							<div class="menutitle" onclick='tabManager("<%=menuName2%>","<%=basePath%><%=menuUrl2%>",this)'>
								<i class="fa fa-fw <%=iconUrl2%>"></i><%=menuName2%></div>
							<%
								} else {
							%>
							<span><i class="fa fa-fw <%=iconUrl2%>"></i><%=menuName2%></span>
							<%
								}
							%>
							<ul>
								<%
									for (Map<Object, Object> menu3 : menus) {
										int menuLevel3 = Integer.parseInt(menu3.get("menuLevel").toString());
										String menuName3 = menu3.get("menuName").toString();
										int parentId3 = Integer.parseInt(menu3.get("parentId").toString());
										String menuUrl3 = menu3.get("menuUrl") == null ? "" : menu3.get("menuUrl").toString();
										String iconUrl3 = menu3.get("iconUrl") == null ? "fa-cog" : menu3.get("iconUrl").toString();
										if (menuLevel3 == 3 && parentId3 == menuId2) {
								%>
								<li>
									<div class="menutitle" onclick='tabManager("<%=menuName3%>","<%=basePath%><%=menuUrl3%>",this)'>
										<i class="fa fa-fw <%=iconUrl3%>"></i><%=menuName3%></div>
								</li>
								<%
									}
								}
								%>
							</ul>
						</li>
					</ul>
					<%
						}
					}
					%>
				</div>
				<%
					}
				}
				%>

			</div>
		</div>
		
		<div data-options="region:'center',iconCls:'icon-ok'">
			<div id="main_center_tabs" class="easyui-tabs" data-options="fit:true"></div>
		</div>
	</div>

	<div id="tab_menu" class="easyui-menu" style="width: 150px;">
		<div id="tab_menu-tabrefresh" data-options="iconCls:'icon-reload'">刷新</div>
		<div id="tab_menu-openFrame">在新的窗体打开</div>
		<div id="tab_menu-tabcloseall">关闭所有</div>
		<div id="tab_menu-tabcloseother">关闭其他标签页</div>
		<div class="menu-sep"></div>
		<div id="tab_menu-tabcloseright">关闭右边</div>
		<div id="tab_menu-tabcloseleft">关闭左边</div>
		<div id="tab_menu-tabclose" data-options="iconCls:'icon-remove'">关闭</div>
		<div id="menu" class="easyui-menu" style="width: 150px;"></div>
	</div>


	<div id="editPwd" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#editPwd-buttons">
		<form id="editPwd_form" method="post" action='<%=basePath%>system/editPwd_save'>
			<table cellpadding="10">
				<tr>
					<td>原始密码:</td>
					<td>
						<input class="easyui-textbox" type="text" name="key2" id='oldPwd' value="" style='width:200px' data-options="required:true"></input>
					</td>
				</tr>
				<tr>
					<td>新密码:</td>
					<td>
						<input class="easyui-textbox" type="text" name="key3" id='newPwd' value="" style='width:200px' data-options="required:true"></input>
					</td>
				</tr>
				<tr>
					<td>密码确认:</td>
					<td>
						<input class="easyui-textbox" type="text" id='newPwdAgain' value="" style='width:200px' data-options="required:true" validType="equalTo['#newPwd']" invalidMessage="两次输入密码不匹配"></input>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="editPwd-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="editPwd_save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#editPwd').dialog('close')">取消</a>
	</div>
	<script type="text/javascript" src="<%=basePath%>js/ueditor-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/ueditor-utf8-jsp/ueditor.all.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/ueditor-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	<script>
		//初始化tab选项卡的右键菜单
		function InitTabMenu() {
			$tabArea.tabs({
				tabWidth : 100,
				onContextMenu : function(e, title) {
					e.preventDefault();
					$tabArea.tabs('select', title);
					$tabMenu.menu('show', {
						left : e.pageX,
						top : e.pageY
					}).data("tabTitle", title);
				}
			});

			tabRightKeyOper();
		}
		
		function tabManager(title, url, dom) {
			//如果是点击菜单，更改菜单样式
			if (dom) {
				$(".menutitle").parents(".tree-node").removeClass("tree-node-selected");
				$(dom).parents(".tree-node").addClass("tree-node-selected");
			}
			var closable = (title == indexTitle ? false:true);
			//如果存在标题为node.text的tab就先关闭后重新打开
			if ($tabArea.tabs('exists', title)) {
				$tabArea.tabs('close', title);//先关闭后重新打开
				$tabArea.tabs('add', {
					title : title,
					href : url,
					closable : closable
				});
			} else { //如果不存在标题为node.text的tab就增加，注意除首页外只能显示一个标签，因此首先关闭除首页之外的TAB
				var currTitle = $tabMenu.menu().data("tabTitle");
				var ts = $tabArea.tabs('tabs');
				var titles = [];
				for ( var i = 0; i < ts.length; i++) {
					var t = ts[i].panel('options').title;
					if (t != currTitle && t != indexTitle){
						titles.push(t);
					}
				}
				for ( var i = 0; i < titles.length; i++){
					$tabArea.tabs('close', titles[i]);
				}

				$tabArea.tabs('add', {
					title : title,
					href : url,
					closable : closable
				});
			}
		}

		function freshCurrTab(text) {
			//根据标题获取选项卡tab对象
			var currTab = $tabArea.tabs('getTab', text);
			//将当前tab设置为选中状态
			$tabArea.tabs('select', text);
			var url = currTab.panel('options').href;
			$tabArea.tabs('update', {
				tab : currTab,
				options : {
					href : url
				}
			});
			currTab.panel('refresh');
		}

		//tab选项卡上右键菜单中的操作方法
		function tabRightKeyOper() {
			$('#tab_menu-tabrefresh').click(function() {
				//获取当前右键操作的tab选项卡的标题title
				var currTitle = $tabMenu.menu().data("tabTitle");
				freshCurrTab(currTitle);
			});
			//在新窗口打开该标签
			$('#tab_menu-openFrame').click(function() {
				//获取当前右键操作的tab选项卡的标题title
				var currTitle = $tabMenu.menu().data("tabTitle");
				//先选中指定标题的选项卡
				$tabArea.tabs('select', currTitle);
				//获取当前右键操作的选项卡对象
				var currTab = $tabArea.tabs('getSelected');
				//获取当前右键操作的选项卡的url
				var url = currTab.panel('options').href;
				window.open(url);
			});
			//关闭当前
			$('#tab_menu-tabclose').click(function() {
				//获取当前右键操作的tab选项卡的标题title
				var currTitle = $tabMenu.menu().data("tabTitle");
				$tabArea.tabs('close', currTitle);
			});
			//全部关闭
			$('#tab_menu-tabcloseall').click(function() {
				var ts = $tabArea.tabs('tabs');
				var titles = [];
				for ( var i = 0; i < ts.length; i++) {
					var t = ts[i].panel('options').title;
					titles.push(t);
				}
				for ( var i = 0; i < titles.length; i++) {
					$tabArea.tabs('close', titles[i]);
				}
			});
			//关闭除当前之外的TAB
			$('#tab_menu-tabcloseother').click(function() {
				//获取当前右键操作的tab选项卡的标题title
				var currTitle = $tabMenu.menu().data("tabTitle");
				var ts = $tabArea.tabs('tabs');
				var titles = [];
				for ( var i = 0; i < ts.length; i++) {
					var t = ts[i].panel('options').title;
					if (t != currTitle)
						titles.push(t);
				}
				for ( var i = 0; i < titles.length; i++)
					$tabArea.tabs('close', titles[i]);
			});
			//关闭当前右侧的TAB
			$('#tab_menu-tabcloseright').click(function() {
				//获取当前右键操作的tab选项卡的标题title
				var currTitle = $tabMenu.menu().data("tabTitle");
				//根据标题获取选项卡tab对象
				var currTab = $tabArea.tabs('getTab', currTitle);
				//获取该tab对象的index索引
				var currIndex = $tabArea.tabs('getTabIndex', currTab);

				var ts = $tabArea.tabs('tabs');
				var titles = [];
				for ( var i = currIndex + 1; i < ts.length; i++) {
					var t = ts[i].panel('options').title;
					titles.push(t);
				}
				for ( var i = 0; i < titles.length; i++){
					$tabArea.tabs('close', titles[i]);
				}
				//选中标题为currTitle的tab选项卡
				$tabArea.tabs('select', currTitle);
			});
			//关闭当前左侧的tab
			$('#tab_menu-tabcloseleft').click(function() {
				//获取当前右键操作的tab选项卡的标题title
				var currTitle = $tabMenu.menu().data("tabTitle");
				//根据标题获取选项卡tab对象
				var currTab = $tabArea.tabs('getTab', currTitle);
				//获取该tab对象的index索引
				var currIndex = $tabArea.tabs('getTabIndex', currTab);
				var ts = $tabArea.tabs('tabs');
				var titles = [];
				for ( var i = 0; i < currIndex; i++) {
					var t = ts[i].panel('options').title;
					titles.push(t);
				}
				for ( var i = 0; i < titles.length; i++)
					$tabArea.tabs('close', titles[i]);
				//选中标题为currTitle的tab选项卡
				$tabArea.tabs('select', currTitle);
			});

		}

		var $tabArea = null;//tabAreaId  : 中间内容区tab选项卡控件的id
		var $tabMenu = null;//tabMenuId  : 右键弹出的菜单div的id  tab_menu
		var indexTitle = "首   页";//首页标题
		$(function() {
			$tabArea = $("#main_center_tabs");//tabAreaId  : 中间内容区tab选项卡控件的id
			$tabMenu = $("#tab_menu");//tabMenuId  : 右键弹出的菜单div的id  tab_menu
			InitTabMenu();//初始化TAB
			tabManager(indexTitle, webContext + 'index_index.jsp');//打开首页
			$(document).on('focus', '.textbox-text', function() {
				$(this).select();
			});
		});

		function RedictHistory() {
			$(".easyui-tabs").tabs('select', '统计分析');/*title 或  index(默认从0开始)  */
		}

		function editPwd() {
			$('#editPwd').dialog('open').dialog('setTitle', '密码修改');
			$("#editPwd_form").form('clear');
		}

		function editPwd_save() {
			var form = $("#editPwd_form");
			var action = form.attr("action");
			if (form.form("validate")) {
				$.post(webContext + 'system/editPwd_save', getFormJson("editPwd_form"), function(data) {
					if (data.ok) {
						$.messager.alert({
							title : "温馨提示",
							msg : "密码修改成功，请重新登陆！",
							icon : "info",
							fn : function() {
								window.location.href = webContext + "system/exit";
							}
						});
						$('#editPwd').dialog('close');
					} else {
						$.messager.alert("温馨提示", data.errorMsg);
					}
				}, "json");
			}
		}
	</script>

</body>
</html>