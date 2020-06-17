<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#fishinfo_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#fishinfo_search_form .conditionSpan input,select {
	width:100px;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<div data-options="region:'north',border:false">
		<form id="fishinfo_search_form" style="margin:0 5px;">
		<div>
			<span class="conditionSpan">
				<span>鱼苗名称：</span>
				<input class="easyui-textbox" name="fishname" />
			</span>
			<span class="conditionSpan">
				<span>鱼苗别名：</span>
				<input class="easyui-textbox" name="fishanother" />
			</span>
			<span class="conditionSpan">
				<span>是否可用：</span>
				<select class="easyui-combobox" name="delete_flag" data-options="panelHeight:'auto'">
					<option value="">=请选择=</option>
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</span>
			<span class="conditionSpan">
				<a class="easyui-linkbutton" onclick="fishinfo_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
			</span>
		</div>
		</form>	
	</div>
	<div data-options="region:'center',border:false" style="width:100%;">
		<table id="fishinfo_list"></table>
	</div>
</div>
<script>
$(function(){
	$('#fishinfo_list').datagrid({
	   	url: webContext + 'fishinfo/getPagerDataIsOk',
	    fit: true,
	    fitColumns: true,
	    nowrap: true,
	    collapsible: true,
	    pagination: true,
	    autoRowHeight: false,
	    idField: 'id',
	    striped: true, //奇偶行是否区分
	    singleSelect: true,//单选模式
	    rownumbers: true,//行号
	    remoteSort: true,
	    pageSize: 20, //每一页多少条数据
	    pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
	    columns: [[
			{ field: 'ck', checkbox: true },
			{ field: 'id', title: 'ID', width: 60},
			{ field: 'fishname', title: '鱼苗名称 ', width: 100},
			{ field: 'fishanother', title: '鱼苗别名', width: 100},
			{ field: 'environment', title: '养殖环境', width: 200},
			{ field: 'memo', title: '备注', width: 200 }
	    ]]
	});
	actionButtonCtr('fishinfo_list');   
	$('#fishinfo_list').datagrid("doCellTip");
});

//搜索
function fishinfo_search(){
	$('#fishinfo_list').datagrid("load", getFormJson("fishinfo_search_form"));
}


</script>


</body>
</html>