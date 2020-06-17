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
    	<form id="deviceType_search_form" style="padding:11 0 0 10;font-size:13px;">
			<span>类型名称：</span><input class="easyui-textbox" name="typeName"/>
			<a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
			onclick="search_load('deviceType_list', 'deviceType_search_form')">查询</a>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="deviceType_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#deviceType_list').datagrid({
		url : '<%=basePath%>deviceType/query',
		fit: true,
		fitColumns: true,
		nowrap: true,
		striped: true, // 奇偶行是否区分
		singleSelect: true,// 单选模式
		rownumbers: true,// 行号
		idField: 'id',
		sortName: 'id',
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		columns : [[
			{field : 'ck', checkbox : true}, 
			{field : 'id', hidden : true}, 
			{field : 'typeCode', title : '类型编号', width : 100}, 
			{field : 'typeName', title : '类型名称', width : 100}, 	 
	        {field : 'rule', title : '编号前缀', width : 150}, 
	        {field : 'delete_flag', title: '是否可用', sortable: true, width: 80,
				formatter: function (value, row) {
					if (value == false) return '<span>是</span>';
					if (value == true) return '<span>否</span>';
				}    
	        }
		]],
		toolbar : [{
			text : '新增',
			url: 'deviceType/add',
			iconCls : 'icon-add',
			handler : opendeviceTypeAddDialog
		},{
			text : '编辑',
			url: 'deviceType/edit',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRow = $('#deviceType_list').datagrid('getSelected');
				if (selectedRow == null) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				opendeviceTypeEditDialog(selectedRow.id);
			}
		}]
	});
	actionButtonCtr('deviceType_list');
});

function opendeviceTypeAddDialog() {
	var $dialog = $("<div id='deviceType_add_dialog'></div>");
	$dialog.dialog({
        href:  '<%=basePath%>deviceType/deviceType_add',
        title: '新增设备类型',
        width: 450,
        height: 280,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('deviceType_add_form','deviceType_add_dialog','deviceType_list', 'deviceType_search_form',this);
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

function opendeviceTypeEditDialog(id) {
	var $dialog = $("<div id='deviceType_edit_dialog'></div>");
	$dialog.dialog({
        href: '<%=basePath%>deviceType/deviceType_edit?id=' + id,
        title: '编辑设备类型',
        width: 450,
        height: 320,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('deviceType_edit_form','deviceType_edit_dialog','deviceType_list','deviceType_search_form',this);
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
