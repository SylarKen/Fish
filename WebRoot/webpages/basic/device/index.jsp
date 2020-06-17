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
<meta http-equiv="description" content="">
</head>
<body>
<div class="easyui-layout" style="width:100%;" fit="true">
    <div data-options="region:'north'" style="height:50px;">
    	<form id="device_search_form" style="padding:11 0 0 10;font-size:13px;">
			<span>池塘编号：</span><input class="easyui-textbox" name="pointCode"/>&nbsp;
			<span>设备编号：</span><input class="easyui-textbox" name="collectorCode"/>&nbsp;
			<span>设备编号：</span><input class="easyui-textbox" name="deviceCode"/>&nbsp;
			<a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
				onclick="search_load('device_list', 'device_search_form')">查询</a>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="device_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#device_list').datagrid({
		url : '<%=basePath%>device/query',
		fit: true,
		fitColumns: true,
		nowrap: true,
		idField: 'deviceCode',
		striped: true, // 奇偶行是否区分
		singleSelect: true,// 单选模式
		rownumbers: true,// 行号
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		sortName: 'deviceCode',
		columns : [[
			{field : 'ck', checkbox : true}, 
			{field : 'deviceCode', title : '设备编号', width : 100}, 
			{field : 'deviceId', title : '设备序列号', width : 110}, 	 
	        {field : 'deviceName', title : '设备名称', width : 100}, 
	        {field : 'typeCode', title : '设备类型编号', width : 100}, 
	        {field : 'typeName', title : '设备类型', width : 100}, 
			{field : 'collectorCode', title : '设备编号', width : 100}, 
	        {field : 'collectorName', title : '设备名称', width : 100}, 
	        {field : 'pondCode', title : '池塘编号', width : 100},
			{field : 'pondName', title : '池塘名称', width : 100},
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
			url: 'device/add',
			iconCls : 'icon-add',
			handler : opendeviceAddDialog
		},{
			text : '编辑',
			url: 'device/edit',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRow = $('#device_list').datagrid('getSelected');
				if (selectedRow == null) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				opendeviceEditDialog(selectedRow.deviceCode);
			}
		}]
	});
	actionButtonCtr('device_list');
});

function opendeviceAddDialog() {
	var $dialog = $("<div id='device_add_dialog'></div>");
	$dialog.dialog({
        href:  '<%=basePath%>device/device_add',
        title: '新增设备',
        width: 470,
        height: 560,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('device_add_form','device_add_dialog','device_list', 'device_search_form',this);
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

function opendeviceEditDialog(code) {
	var $dialog = $("<div id='device_edit_dialog'></div>");
	$dialog.dialog({
        href: '<%=basePath%>device/device_edit?code=' + code,
        title: '编辑设备',
        width: 470,
        height: 620,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('device_edit_form','device_edit_dialog','device_list','device_search_form',this);
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
