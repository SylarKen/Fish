<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
</head>
<body>
<style>
#reply_search_form {
	margin:0;
	padding:0;
}
#reply_search_form span.condition {
	margin:5px;
	display: inline-block;
}
</style>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false">
		<form id="reply_search_form" action="" method="post">
			<span class="condition"> 
				<label>标题：</label> 
				<input class="easyui-textbox" name="title" style="width:120px" /> 
			</span>
			<span class="condition"> 
				<label>类型：</label> 
				<select class="easyui-combobox" name="type" style="width:120px;" data-options="panelHeight:'auto',editable:false">
				<option value="">=请选择=</option>
				<option value="0">其他</option>
				<option value="1">鱼苗</option>
				<option value="2">喂养</option>
				<option value="3">用药</option>
				<option value="4">捕捞</option>
			</select>
			</span> 
			<span class="condition"> 
				<label>状态：</label> 
				<select class="easyui-combobox" name="status" style="width:120px;" data-options="panelHeight:'auto',editable:false">
					<option value="">=请选择=</option>
					<option value="1">待回复</option>
					<option value="2">已回复</option>
				</select> 
			</span> 
			<span class="condition"> 
				<a href="#" style="height:22px;" class="easyui-linkbutton" iconcls="icon-search" onclick="reply_search()">查询</a> 
			</span>
		</form>
	</div>
	<div data-options="region:'center'">
		<table style="width:100%" id="reply_datagrid"></table>
	</div>
</div>
<script>
$(function() {
	$('#reply_datagrid').datagrid({
		url : webContext + 'reply/getPagerData',
		columns : [ [ 
			{field:'id',title:'ID',width: 40},
			{field:'title',title:'标题',width: 200},
			{field:'type',title:'类型',width: 70, 
				formatter:function(value, row){ 
					//0其他，1鱼苗，2喂养，3用药，4捕捞
					var text = "未知";
					switch(value){
						case 0 : text = "其他"; break;
						case 1 : text = "鱼苗"; break;
						case 2 : text = "喂养"; break;
						case 3 : text = "用药"; break;
						case 4 : text = "捕捞"; break;
					}
					return text;
				}},
			{field:'status',title:'状态',width: 80, 
				formatter:function(value, row){ 
					var text = "未知";
					switch(value){
						case 0 : text = "已保存"; break;
						case 1 : text = "<font color=red>待回复</font>"; break;
						case 2 : text = "<font color=blue>已回复</font>"; break;
					}
					return text;
				}
			},
			{field:'creator',title:'上报者',width: 70},
			{field:'reportTime',title:'上报时间',width: 100,formatter:timeFormatter}
		] ],
		fit : true,
		fitColumns : true,//自动调整列的尺寸以适应网格的宽度并且防止水平滚动
		idField : 'id',
		nowrap : true,//把数据显示在一行里
		pageList : [ 10, 20, 30, 40, 50 ], //可以选择的每页的大小的combobox
		pageSize : 10, //每一页多少条数据
		pagination : true,
		rownumbers : true,//行号
		striped : true, //奇偶行是否区分
		singleSelect : true,
		sortName : 'prodCode',
		toolbar : [
		{
			url : "reply/detail",
			text : '查看',
			iconCls : 'icon-search',
			handler : function() {
				var row = $('#reply_datagrid').datagrid('getSelected');
				if (!row) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				tabManager('问题回复查看', webContext + "reply/detail?id=" + row.id);
			}	
		}],
		onSelect: function(rowIndex, rowData){
			
		},
		onLoadSuccess: function(data){
			if(data.total > 0){
				$(this).datagrid("selectRow", 0);
			}
		}
	});
	actionButtonCtr('reply_datagrid');
	$("#reply_datagrid").datagrid('doCellTip');
});


function reply_search(){
	search_load('reply_datagrid', 'reply_search_form');
}
</script>
</body>
</html>