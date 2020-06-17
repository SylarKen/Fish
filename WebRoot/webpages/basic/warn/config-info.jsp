<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>告警配置信息</title>
</head>
<body>
<div class="easyui-layout" style="width:100%;height:100%;">
     <div data-options="region:'north'" style="height:50px;">
    	<form id="warn_conf_search_form">
	    	<ul class="search-param-list">
	    		<li>
	    			<span>采集器：</span>
					<input id="warn_con_collector" name="collectorCode">
				</li>
				<!-- <li style="margin-left:20px">
	    			<span>传感器：</span>
					<input id="warn_con_device" name="deviceCode">
				</li> -->
	    		<li style="margin-left:10px;">
	    			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="search_load('warn_conf_list', 'warn_conf_search_form', 'datagrid')">查询</a>
	    		</li>
	    	</ul>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="warn_conf_list"></div>
    </div>
</div>

<script type="text/javascript">
$(function() {
	
	var dialogWidth = 650;
	var dialogHeight = 500;
	
	$('#warn_con_collector').combobox({
		url: '${basePath}warnConf/collectors',
		queryParams: {
			hasBlank: true
		},
		valueField: 'collectorCode',
		textField: 'collectorName',
		onSelect: function(record) {
			$.getJSON('${basePath}warnConf/devices', {collectorCode: record.collectorCode}, function(data, status) {
				$('#warn_conf_edit_device').combobox('loadData', data);
			});
		}
	});
	
	$('#warn_conf_list').datagrid({
		url: '${basePath}warnConf/query',
		fit: true,
		nowrap: true,
		idField: 'id',
		striped: true, // 奇偶行是否区分
		singleSelect: true,// 单选模式
		rownumbers: true,// 行号
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		//sortName: 'time',
	    columns:[[
			{field: 'ck', checkbox: true },
            {field: 'collectorName', title: '采集器', width: 100},
            {field: 'deviceName', title: '传感器', width: 100},
            {field: 'timeLimit', title: '告警时限（小时）', width: 140},
            {field: 'min', title: '正常范围', width: 100, formatter: function(value, row, index) {
            	return "<span>" + row.min + " - " + row.max + "</span>";
            }},
            {field: 'blueMin', title: '蓝色告警', width: 100, formatter: function(value, row, index) {
            	return "<span>" + row.blueMin + " - " + row.blueMax + "</span>";
            }},
            {field: 'orangeMin', title: '橙色告警', width: 100, formatter: function(value, row, index) {
            	return "<span>" + row.orangeMin + " - " + row.orangeMax + "</span>";
            }},
            {field: 'yellowMin', title: '黄色告警', width: 100, formatter: function(value, row, index) {
            	return "<span>" + row.yellowMin + " - " + row.yellowMax + "</span>";
            }},
            {field: 'redMin', title: '红色告警', width: 100, formatter: function(value, row, index) {
            	return "<span>" + row.redMin + " - " + row.redMax + "</span>";
            }},
            {field : 'delete_flag', title: '是否可用', sortable: true, width: 80,
            	formatter: function (value, row) {
    				if (value == false) return '<span style=color:green; >是</span>';
    				if (value == true) return '<span style=color:red; >否</span>';
    			}
	        },
            {field:'createTime', title:'采集时间',width: 140,formatter:timeFormatter}
	    ]],
	    toolbar: [{
			url: 'warnConf/add',
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				openWarnConfAddDialog();
			}
		},{
			url: 'warnConf/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRows = $('#warn_conf_list').datagrid('getSelections');
				if (selectedRows.length == 0) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				if (selectedRows.length > 1) {
					$.messager.alert("温馨提示", "请选择一行！");
					return;
				}
				openWarnConfEditDialog(selectedRows[0].id);
			}
		}]
	});
	
	function openWarnConfAddDialog() {
		var $dialog = $("<div id='warn_conf_add_dialog'></div>");
		$dialog.dialog({
	        href: '${basePath}warnConf/add',
	        title: '新增告警配置',
	        width: dialogWidth,
	        height: dialogHeight,
	        closed: true,
	        cache: false,
	        modal: true,
	        buttons: [{
	            text: '确定',
	            iconCls:'icon-ok',
	            handler: function() {
	            	submitForm('warn_conf_add_form', 'warn_conf_add_dialog', 'warn_conf_list', 'warn_conf_search_form', this);
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
	function openWarnConfEditDialog(id) {
		var $dialog = $("<div id='warn_conf_edit_dialog'></div>");
		$dialog.dialog({
	        href: '${basePath}warnConf/edit',
	        queryParams: {id: id},
	        title: '编辑告警配置',
	        width: dialogWidth,
	        height: dialogHeight,
	        closed: true,
	        cache: false,
	        modal: true,
	        buttons: [{
	            text: '确定',
	            iconCls:'icon-ok',
	            handler: function() {
	            	submitForm('warn_conf_edit_form', 'warn_conf_edit_dialog', 'warn_conf_list', 'warn_conf_search_form', this);
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
});
</script>
</body>
</html>