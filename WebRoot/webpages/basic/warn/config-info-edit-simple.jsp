<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>配置信息</title>
</head>
<body>

<form class="form" id="warn_conf_edit_form" method="post" action='${basePath}warnConf/edit'>
	<input type="hidden" name="id" value="${warnConf.id}">
	<div class="form-item form-item-float">
		<label class="form-label">采集器</label>
		<div class="form-input-inline">
			<input id="warn_conf_edit_collector" name="collectorCode" value="${warnConf.collectorCode}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">传感器</label>
		<div class="form-input-inline">
			<input id="warn_conf_edit_device" name="deviceCode" value="${warnConf.deviceCode}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">时&nbsp;限</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" name="timeLimit" value="${warnConf.timeLimit}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">正常</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="min" value="${warnConf.min}">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="max" value="${warnConf.max}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">蓝色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="blueMin" value="${warnConf.blueMin}">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="blueMax" value="${warnConf.blueMax}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">橙色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="orangeMin" value="${warnConf.orangeMin}">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="orangeMax" value="${warnConf.orangeMax}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">黄色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="yellowMin" value="${warnConf.yellowMin}">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="yellowMax" value="${warnConf.yellowMax}">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">红色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="redMin" value="${warnConf.redMin}">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="redMax" value="${warnConf.redMax}">
		</div>
	</div>
	<div class="clear"></div>
	<div class="form-item form-item-float">
		<label class="form-label">是否可用</label>
		<div class="form-input-inline">
			<input id="warn_conf_edit_delete_flag" name="delete_flag" value="${warnConf.delete_flag}">
		</div>
	</div>
	
</form>
<link rel="stylesheet" type="text/css" href="${basePath}css/form.css">
<style>
.table thead tr {background-color: #e2e2e2;}
.table thead tr th {width: 150px;height: 30px;line-height: 30px;}
.table tbody tr td {height: 30px;line-height: 30px;text-align: center;}
</style>
<script type="text/javascript">
$(function() {
	var collectorCode = $('#warn_conf_edit_collector').val();
	$('#warn_conf_edit_collector').combobox({
		url: '${basePath}warnConf/collectors',
		valueField: 'collectorCode',
		textField: 'collectorName',
		onSelect: function(record) {
			$.getJSON('${basePath}warnConf/devices', {collectorCode: record.collectorCode}, function(data, status) {
				$('#warn_conf_edit_device').combobox('loadData', data);
			});
		}
	});
	$('#warn_conf_edit_collector').combobox('select', collectorCode);
	var deviceCode = $('#warn_conf_edit_device').val();
	$('#warn_conf_edit_device').combobox({
		url: '${basePath}warnConf/devices',
		queryParams: {collectorCode: collectorCode},
		valueField: 'deviceCode',
		textField: 'deviceName'
	});
	$('#warn_conf_edit_device').combobox('select', deviceCode);
	var delete_flag = $('#warn_conf_edit_delete_flag').val();
	$('#warn_conf_edit_delete_flag').combobox({
		valueField: 'value',
		textField: 'label',
		data: [{
			value: 0,
			label: '可用'
		}, {
			value: 1,
			label: '不可用'
		}]
	});
	$('#warn_conf_edit_delete_flag').combobox('select', delete_flag);
});
</script>
</body>
</html>