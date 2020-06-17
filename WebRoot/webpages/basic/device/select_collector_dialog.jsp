<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
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
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="collector_dialog_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#collector_dialog_list').datagrid({
		url : '<%=basePath%>collector/query?pointCode=${pointCode}',
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
	        {field : 'collectorName', title : '名称', width : 150}, 
	        {field : 'pointCode', title : '养殖点编号', width : 100},
			{field : 'pointName', title : '养殖点名称', width : 180},
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
		onCheck: function(rowIndex,rowData){
	    	if(rowData.delete_flag == 1){
	    		$('#collector_dialog_list').datagrid('clearChecked');
	    	}
	    }
	});
});
 
</script>
</body>
</html>
