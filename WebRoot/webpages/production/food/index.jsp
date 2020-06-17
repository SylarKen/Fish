<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#food_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#food_search_form .conditionSpan input,select {
	width:100px;
}
</style>
<div class="easyui-layout" data-options="border:false" style="width:100%;height:100%">
	<div data-options="region:'north',border:false">
		<form id="food_search_form" style="margin:0 5px;">
		<div>
			<span class="conditionSpan">
				<span>饵料名称：</span>
				<input class="easyui-textbox" name="name" />
			</span>
			<span class="conditionSpan">
				<span>适宜鱼种：</span>
				<input class="easyui-textbox" name="breedName" />
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
				<a class="easyui-linkbutton" onclick="food_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
			</span>
		</div>
		</form>	
	</div>
	<div data-options="region:'center',border:false" style="width:100%;">
		<table id="food_list"></table>
	</div>
</div>
<script>
$(function(){
	$('#food_list').datagrid({
	   	url: webContext + 'food/getPagerData',
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
			{ field: 'id', title: 'ID', width: 60},
			{ field: 'name', title: '饵料名称 ', width: 100},
			{ field: 'breedName', title: '适宜鱼种', width: 200},
			{ field: 'effect', title: '效果 ', width: 200},
			{ field: 'memo', title: '备注', width: 200 },
			{ field: 'delete_flag', title: '是否可用', width: 80,formatter:delete_flag_formatter },
			{ field: 'creator', title: '创建者', width: 100 },
			{ field: 'createTime', title: '创建时间', width: 100,formatter:function(value, row){return timeFormatter(value);} },
			{ field: 'editor', title: '编辑者', width: 100 },
			{ field: 'editTime', title: '编辑时间', width: 100,formatter:function(value, row){return timeFormatter(value);} }
	    ]],
	    toolbar:[
	    {
	        url: "food/add",  
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				food_showAddDailog();
	        }
		},{
			url: "food/edit",
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){
				var selectRows = $('#food_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				food_showEditDailog(selectRows[0].id);
		  	}
		},{
			url: "food/detail",
			text:'查看',
			iconCls:'icon-search',
			handler:function(){
				var selectRows = $('#food_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				food_showDetailDailog(selectRows[0].id);
		  	}
		} ]
	});
	actionButtonCtr('food_list');   
	$('#food_list').datagrid("doCellTip");
});

//搜索
function food_search(){
	$('#food_list').datagrid("load", getFormJson("food_search_form"));
}

//新增窗口
function food_showAddDailog(){
	var $food_add_dialog = $("<div><div>");
	$food_add_dialog.dialog({
		title : '新增',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "food/add",
		modal : true,
		buttons : [ {
			id : 'food_add_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#food_add_form").form('validate')) {
					var data = getFormJson("food_add_form");
					$("#food_add_save").linkbutton('disable');
					$.post( webContext + "food/addSave", data, 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#food_add_save").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$food_add_dialog.dialog('destroy');
								food_search();//刷新
							}
						}
					,"json");
				} else {
					$.messager.alert("温馨提示", "请重新输入红色背景高亮字段！");
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$food_add_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$food_add_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$food_add_dialog.dialog('open');
}
	
	
//编辑窗口
function food_showEditDailog(id){
	var $food_edit_dialog = $("<div><div>");
	$food_edit_dialog.dialog({
		title : '编辑',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "food/edit",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			id : 'food_edit_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#food_edit_form").form('validate')) {
					var data = getFormJson("food_edit_form");
					$("#food_edit_save").linkbutton('disable');
					$.post( webContext + "food/editSave", data, 
						function(map) {
							$("#food_edit_save").linkbutton('enable');
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$food_edit_dialog.dialog('destroy');
								food_search();//刷新
							}
						}
					,"json");
				} else {
					$.messager.alert("温馨提示", "请重新输入红色背景高亮字段！");
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$food_edit_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$food_edit_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$food_edit_dialog.dialog('open');
}

//查看窗口
function food_showDetailDailog(id){
	var $food_detail_dialog = $("<div><div>");
	$food_detail_dialog.dialog({
		title : '查看',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "food/detail",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$food_detail_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$food_detail_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$food_detail_dialog.dialog('open');
}
</script>


</body>
</html>