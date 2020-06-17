<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#medicine_select_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#medicine_select_search_form .conditionSpan input,select {
	width:100px;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<div data-options="region:'north',border:false">
		<form id="medicine_select_search_form" style="margin:0 5px;">
		<div>
			<span class="conditionSpan">
				<span>药品名称：</span>
				<input class="easyui-textbox" name="name" />
			</span>
			<span class="conditionSpan">
				<span>适用症状：</span>
				<input class="easyui-textbox" name="symptoms" />
			</span>
			<span class="conditionSpan">
				<a class="easyui-linkbutton" onclick="medicine_select_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
			</span>
		</div>
		</form>	
	</div>
	<div data-options="region:'center',border:false" style="width:100%;">
		<table id="medicine_select_list"></table>
	</div>
</div>
<script>
$(function(){
	var selId = $.trim('${selId}');
	$('#medicine_select_list').datagrid({
	   	url: webContext + 'medicine/getPagerData?delete_flag=0',
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
	    pageSize: 10, //每一页多少条数据
	    pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
	    columns: [[
			{ field: 'ck', checkbox: true },
			{ field: 'id', title: 'ID', width: 60},
			{ field: 'name', title: '药品名称 ', width: 100},
			{ field: 'breedName', title: '适宜鱼种', width: 200},
			{ field: 'symptoms', title: '适用症状', width: 200},
			{ field: 'effect', title: '功效 ', width: 200},
			{ field: 'memo', title: '备注'  }
	    ]],
	    onLoadSuccess : function(data) {
	    	if(!selId || !data || data.length == 0){
	    		return;
	    	}
	    	$('#medicine_select_list').datagrid("selectRecord", selId);
	    	
		}
	});
	$('#medicine_select_list').datagrid("doCellTip");
});

//搜索
function medicine_select_search(){
	$('#medicine_select_list').datagrid("load", getFormJson("medicine_select_search_form"));
}

	
</script>


</body>
</html>