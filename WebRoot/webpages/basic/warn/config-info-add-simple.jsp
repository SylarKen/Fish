<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>配置信息</title>
</head>
<body>

<form class="form" id="warn_conf_add_form" method="post" action='${basePath}warnConf/add'>
	<div class="form-item form-item-float">
		<label class="form-label">采集器</label>
		<div class="form-input-inline">
			<input id="warn_conf_add_collector" name="collectorCode">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">传感器</label>
		<div class="form-input-inline">
			<input id="warn_conf_add_device" name="deviceCode">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">时&nbsp;限</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" name="timeLimit">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">正常</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="min">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="max">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">蓝色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="blueMin">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="blueMax">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">橙色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="orangeMin">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="orangeMax">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">黄色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="yellowMin">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="yellowMax">
		</div>
	</div>
	<div class="form-item form-item-float">
		<label class="form-label">红色</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px" name="redMin">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px" name="redMax">
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
	$('#warn_conf_add_collector').combobox({
		url: '${basePath}warnConf/collectors',
		valueField: 'collectorCode',
		textField: 'collectorName',
		onSelect: function(record) {
			$.getJSON('${basePath}warnConf/devices', {collectorCode: record.collectorCode}, function(data, status) {
				$('#warn_conf_add_device').combobox('loadData', data);
			});
		}
	});
	$('#warn_conf_add_device').combobox({
		valueField: 'deviceCode',
		textField: 'deviceName'
	});
});
</script>
</body>
</html>