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
#report_search_form {
	margin:0;
	padding:0;
}
#report_search_form span.condition {
	margin:5px;
	display: inline-block;
}
</style>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false">
		<form id="report_search_form" action="" method="post">
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
					<option value="0">已保存，待发布</option>
					<option value="1">已发布，待回复</option>
					<option value="2">已回复</option>
				</select> 
			</span> 
			<span class="condition"> 
				<a href="#" style="height:22px;" class="easyui-linkbutton" iconcls="icon-search" onclick="report_search()">查询</a> 
			</span>
		</form>
	</div>
	<div data-options="region:'center'">
		<table style="width:100%" id="report_datagrid"></table>
	</div>
</div>
<script>
$(function() {
	$('#report_datagrid').datagrid({
		url : webContext + 'report/getPagerData',
		columns : [ [ 
			{field:'id',title:'ID',width: 60},
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
						case 0 : text = "已保存，待上报"; break;
						case 1 : text = "<font color=red>已上报，待回复</font>"; break;
						case 2 : text = "<font color=blue>已回复</font>"; break;
					}
					return text;
				}
			},
			{field:'creator',title:'创建者',width: 70},
			{field:'createTime',title:'创建时间',width: 100,formatter:timeFormatter},
			{field:'editTime',title:'编辑时间',width: 100,formatter:timeFormatter},
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
			url : "report/add",
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				tabManager('问题新增', webContext + "report/add");
			}
		},{
			id : "report_datagird_editButton",
			url : "report/edit",
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var row = $('#report_datagrid').datagrid('getSelected');
				if (!row) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				tabManager('问题编辑', webContext + "report/edit?id=" + row.id);
			}
		},{
			url : "report/detail",
			text : '查看',
			iconCls : 'icon-search',
			handler : function() {
				var row = $('#report_datagrid').datagrid('getSelected');
				if (!row) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				tabManager('问题查看', webContext + "report/detail?id=" + row.id);
			}	
		},{
			id : "report_datagird_reportButton",
			url : "report/report",
			text : '上报',
			iconCls : 'icon-feed',
			handler : function() {
				var row = $('#report_datagrid').datagrid('getSelected');
				if (!row) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				$.messager.confirm("温馨提示","确定要上报该记录？",function(r){
					if(r){
						$.post( webContext + "report/report", {id:row.id}, 
							function(map) {
								if(!map.ok){
									$.messager.alert({title:"温馨提示", msg:map.errorMsg, width:"350px"});
								}else{
									$.messager.alert("温馨提示", "上报成功！");
									report_search();//刷新
								}
							}
						,"json");
					}
				});
			}
		}],
		onSelect: function(rowIndex, rowData){
			//数据表格数据选择后，对按钮进行权限控制:如果已经上报，不能编辑
			var btns = "#report_datagird_editButton,#report_datagird_reportButton";
			if(rowData.status > 0){
				$(btns).linkbutton('disable');
			}else{
				$(btns).linkbutton('enable');
			}
		},
		onLoadSuccess: function(data){
			if(data.total > 0){
				$(this).datagrid("selectRow", 0);
			}
		}
	});
	actionButtonCtr('report_datagrid');
	$("#report_datagrid").datagrid('doCellTip');
});


function report_search(){
	search_load('report_datagrid', 'report_search_form');
}
</script>
</body>
</html>