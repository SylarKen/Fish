<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>渔业综合服务平台</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="运营人员管理">
</head>
<body>
<div class="easyui-layout" style="width:100%;" fit="true">
    <div data-options="region:'north'" style="height:50px;">
    	<form id="collector_search_form" style="padding:11 0 0 10;font-size:13px;">
			<span>设备编号：</span><input class="easyui-textbox" name="collectorCode"/>&nbsp;
			<span>养殖点编号：</span><input class="easyui-textbox" name="pointCode"/>&nbsp;
			<a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
			onclick="search_load('collector_list', 'collector_search_form')">查询</a>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="collector_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#collector_list').datagrid({
		url : '<%=basePath%>collector/query',
		fit: true,
		fitColumns: true,
		nowrap: true,
		idField: 'collectorCode',
		striped: true, // 奇偶行是否区分
		singleSelect: true,// 单选模式
		rownumbers: true,// 行号
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		sortName: 'collectorCode',
		columns : [[
			{field : 'ck', checkbox : true}, 
			{field : 'collectorCode', title : '编号', width : 100}, 
			{field : 'collectorId', title : '序列号', width : 100}, 	 
	        {field : 'collectorName', title : '名称', width : 100}, 
	        {field : 'pointCode', title : '养殖点编号', width : 100},
			{field : 'pointName', title : '养殖点名称', width : 100},
	        {field : 'buyDate', title : '购买时间', width : 100,formatter:dateFormatter}, 
	        {field : 'expiringDate', title : '服务到期时间', width : 100,formatter:dateFormatter},
	        {field : 'effectiveDate', title : '生效时间', width : 100,formatter:dateFormatter},
	        {field : 'delete_flag', title: '是否可用', sortable: true, width: 80,
				formatter: function (value, row) {
					if (value == false) return '<span>是</span>';
					if (value == true) return '<span>否</span>';
				}    
	        }
		]],
		toolbar : [{
			text : '新增',
			url: 'collector/add',
			iconCls : 'icon-add',
			handler : opencollectorAddDialog
		},{
			text : '编辑',
			url: 'collector/edit',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRow = $('#collector_list').datagrid('getSelected');
				if (selectedRow == null) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				opencollectorEditDialog(selectedRow.collectorCode);
			}
		}]
	});
	actionButtonCtr('collector_list');
});

function opencollectorAddDialog() {
	var $dialog = $("<div id='collector_add_dialog'></div>");
	$dialog.dialog({
        href:  '<%=basePath%>collector/collector_add',
        title: '新增采集器',
        width: 470,
        height: 430,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('collector_add_form','collector_add_dialog','collector_list', 'collector_search_form',this);
            }
        },{
            text: '取消',
            iconCls:'icon-cancel',
            handler: function() {
                $dialog.dialog('close');
            }
        }],
        onClose: function() {
            $dialog.dialog('destroy');
        }
    });
    $dialog.dialog('open');
}

function opencollectorEditDialog(code) {
	var $dialog = $("<div id='collector_edit_dialog'></div>");
	$dialog.dialog({
        href: '<%=basePath%>collector/collector_edit?code=' + code,
        title: '编辑采集器',
        width: 470,
        height: 510,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('collector_edit_form','collector_edit_dialog','collector_list','collector_search_form',this);
            }
        },{
            text: '取消',
            iconCls:'icon-cancel',
            handler: function() {
                $dialog.dialog('close');
            }
        }],
        onClose: function() {
            $dialog.dialog('destroy');
        }
    });
    $dialog.dialog('open');
}

</script>
</body>
</html>
