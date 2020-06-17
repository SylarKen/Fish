<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>渔业后台管理系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
</head>
<body>
<!-- 传过来的数据 -->
<%-- <input type="hidden" id="qualityParam_select_origin_data" value='${data}'> --%>
<!-- 如今选中的数据 -->
<input type="hidden" id="collectorId_from" value='${data}'>
<div class="easyui-layout" style="width:100%;height:100%;">
    <div data-options="region:'north'" style="height:50px;">
    	<form id="deviceOxygen_search_form" style="padding:11 0 0 10;font-size:13px;">
			<span>设备编号：</span><input class="easyui-textbox" name="deviceCode"/>&nbsp;
			<a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
				onclick="search_load('deviceOxygen_list', 'deviceOxygen_search_form')">查询</a>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="deviceOxygen_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	var collectorId = $('#collectorId_from').val();
	$('#deviceOxygen_list').datagrid({
		url : '<%=basePath%>sensorNet/queryOxygen?collectorId='+collectorId+'&typeCode='+LXBH_KZQ_ZY,
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
			{field : 'deviceId', title : '设备序列号', width : 100}, 	 
	        {field : 'deviceName', title : '设备名称', width : 100}, 
	        {field : 'typeCode', title : '设备类型编号', width : 100}, 
	        {field : 'typeName', title : '设备类型', width : 100}
	      
		]]
	});
	actionButtonCtr('deviceOxygen_list');
});
</script>
</body>
</html>
