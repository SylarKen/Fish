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
	   	url: webContext + 'fishinfo/getPagerData',
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
			{ field: 'memo', title: '备注', width: 200 },
			{ field: 'delete_flag', title: '是否可用', width: 80,formatter:delete_flag_formatter },
			{ field: 'creator', title: '创建者', width: 100 },
			{ field: 'createTime', title: '创建时间', width: 150,formatter:function(value, row){return timeFormatter(value);} },
			{ field: 'editor', title: '编辑者', width: 100 },
			{ field: 'editTime', title: '编辑时间', width: 150,formatter:function(value, row){return timeFormatter(value);} }
	    ]],
	    toolbar:[
	    {
	        url: "fishinfo/add",  
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				fishinfo_showAddDailog();
	        }
		},{
			url: "fishinfo/edit",
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){
				var selectRows = $('#fishinfo_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				fishinfo_showEditDailog(selectRows[0].id);
		  	}
		},{
			url: "fishinfo/detail",
			text:'查看',
			iconCls:'icon-search',
			handler:function(){
				var selectRows = $('#fishinfo_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				fishinfo_showDetailDailog(selectRows[0].id);
		  	}
		} ]
	});
	actionButtonCtr('fishinfo_list');   
	$('#fishinfo_list').datagrid("doCellTip");
});

//搜索
function fishinfo_search(){
	$('#fishinfo_list').datagrid("load", getFormJson("fishinfo_search_form"));
}

//新增窗口
function fishinfo_showAddDailog(){
	var $fishinfo_add_dialog = $("<div><div>");
	$fishinfo_add_dialog.dialog({
		title : '新增鱼苗信息',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "fishinfo/add",
		modal : true,
		buttons : [ {
			id : 'fishinfo_add_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#fishinfo_add_form").form('validate')) {
					var data = getFormJson("fishinfo_add_form");
					$("#fishinfo_add_save").linkbutton('disable');
					$.post( webContext + "fishinfo/addSave", data, 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#fishinfo_add_save").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$fishinfo_add_dialog.dialog('destroy');
								fishinfo_search();//刷新
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
				$fishinfo_add_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$fishinfo_add_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$fishinfo_add_dialog.dialog('open');
}
	
	
//编辑窗口
function fishinfo_showEditDailog(id){
	var $fishinfo_edit_dialog = $("<div><div>");
	$fishinfo_edit_dialog.dialog({
		title : '编辑鱼苗信息',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "fishinfo/edit",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			id : 'fishinfo_edit_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#fishinfo_edit_form").form('validate')) {
					var data = getFormJson("fishinfo_edit_form");
					$("#fishinfo_edit_save").linkbutton('disable');
					$.post( webContext + "fishinfo/editSave", data, 
						function(map) {
							$("#fishinfo_edit_save").linkbutton('enable');
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$fishinfo_edit_dialog.dialog('destroy');
								fishinfo_search();//刷新
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
				$fishinfo_edit_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$fishinfo_edit_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$fishinfo_edit_dialog.dialog('open');
}

//查看窗口
function fishinfo_showDetailDailog(id){
	var $fishinfo_detail_dialog = $("<div><div>");
	$fishinfo_detail_dialog.dialog({
		title : '查看鱼苗信息',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "fishinfo/detail",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$fishinfo_detail_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$fishinfo_detail_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$fishinfo_detail_dialog.dialog('open');
}
</script>


</body>
</html>