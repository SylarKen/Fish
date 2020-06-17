<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>告警信息详情页面</title>
</head>
<body>
<div id="warn_info_list"></div>
<script type="text/javascript">
$(function() {
	$('#warn_info_list').datagrid({
		url: '${basePath}map/warn/query',
		queryParams: {
			pointCode: '${param.pointCode}'
		},
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
            {field: 'collectorName', title: '采集器', width: 100},
            {field: 'deviceName', title: '设备', width: 100},
            {field: 'num', title: '开户次数', width: 100},
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
            }}
	    ]]
	});
});
</script>
</body>
</html>