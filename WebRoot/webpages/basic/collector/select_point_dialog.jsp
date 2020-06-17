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
    <div data-options="region:'north'" style="height:50px;border-bottom: 1px #60aae8 solid;">
    	<form id="point_dialog_search_form" style="padding:11 0 0 10;font-size:13px;">
			<span>养殖点编号：</span><input class="easyui-textbox" name="pointCode"/>&nbsp;
			<a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
				onclick="search_load('point_dialog_list', 'point_dialog_search_form')">查询</a>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="point_dialog_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#point_dialog_list').treegrid({
	    url: '<%=basePath%>dept/query?areaId=${areaCode}',
	    idField: 'code',
	    treeField: 'name',
	    fit: true,
	    fitColumns: true,
	    singleSelect: true,
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		sortName: 'code',
	    columns:[[
			{field: 'ck', checkbox: true},
			{title:'编码', field:'code', width:100},
			{title:'名称', field:'name', width:180},
			{title:'层级', field:'grade', width:80},
			{title:'地址', field:'address', width:180},
			{title:'联系人', field:'linkman', width:150},
			{title:'联系电话', field:'linkphone', width:150},
			{title:'创建人', field:'creator', width:150},
			{title: '是否可用',field: 'delete_flag',width: 150,
				formatter: function(value, row) {
					if (value == 0) return '可用';
					if (value == 1) return '<span style=color:red;>不可用</span>';
				}
			}
	    ]],
	    onCheck: function(node, checked){
	    	if(node.grade!=2){
	    		$('#point_dialog_list').treegrid('clearChecked');
	    	}
	    } 
	});

});
 
</script>
</body>
</html>
