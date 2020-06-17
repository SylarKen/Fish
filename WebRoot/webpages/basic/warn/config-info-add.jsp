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
	<!-- <div class="form-item form-item-float">
		<label class="form-label">范&nbsp;围</label>
		<div class="form-input-inline">
			<input class="easyui-textbox" style="width:70px">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px">
		</div>
	</div> -->
	<div class="clear"></div>
	<div class="form-item">
		<table class="table">
			<thead>
				<tr>
					<th>告警</th>
					<th>最小值</th>
					<th>最大值</th>
					<th>启停次数</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background-color:blue;">蓝色预警<input type="hidden" name="detail[0].type" value="blue"></td>
					<td><input class="easyui-validatebox" name="detail[0].min" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[0].max" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[0].num" style="height:40px;"></td>
				</tr>
				<tr>
					<td style="background-color:yellow;">黄色预警<input type="hidden" name="detail[1].type" value="yellow"></td>
					<td><input class="easyui-validatebox" name="detail[1].min" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[1].max" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[1].num" style="height:40px;"></td>
				</tr>
				<tr>
					<td style="background-color:orange;">橙色预警<input type="hidden" name="detail[2].type" value="orange"></td>
					<td><input class="easyui-validatebox" name="detail[2].min" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[2].max" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[2].num" style="height:40px;"></td>
				</tr>
				<tr>
					<td style="background-color:red;">红色预警<input type="hidden" name="detail[3].type" value="red"></td>
					<td><input class="easyui-validatebox" name="detail[3].min" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[3].max" style="height:40px;"></td>
					<td><input class="easyui-validatebox" name="detail[3].num" style="height:40px;"></td>
				</tr>
			</tbody>
		</table>
	</div>







	<!-- <table>
		<tr class="my-form-item">
			<td class="info-wrapper">采集器：</td>
			<td class="content-wrapper">
				<input id="warn_conf_add_collector">
			</td>
		</tr>
		<tr class="row">
			<td style="width:120px;text-align:right;">传感器：</td>
			<td>
				<input id="warn_conf_add_device">
			</td>
		</tr>
		<tr class="row">
			<td style="width:120px;text-align:right;">范&nbsp;围：</td>
			<td>
				<input class="easyui-textbox" style="width:70px">&nbsp;-&nbsp;<input class="easyui-textbox" style="width:70px">
			</td>
		</tr>
		<tr class="row">
			<td style="width:120px;text-align:right;">时&nbsp;限：</td>
			<td>
				<input class="easyui-textbox">
			</td>
		</tr>
	</table> -->
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