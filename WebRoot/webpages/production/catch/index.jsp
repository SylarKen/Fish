<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#catch_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#catch_search_form .conditionSpan input,select {
	width:100px;
}
</style>

<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true" title="池塘列表" style="width:250px;">
		<table id="catch_pond_tree"></table>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-layout" data-options="border:false,fit:true" >
			<div data-options="region:'north',border:false">
				<form id="catch_search_form" style="margin:0 5px;">
				<input type="hidden" id="catch_pondCodes" name="pondCodes" />
				<div>
					<span class="conditionSpan">
						<span>捕捞品种：</span>
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
						<a class="easyui-linkbutton" onclick="catch_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
					</span>
				</div>
				</form>	
			</div>
			<div data-options="region:'center',border:false" style="width:100%;">
				<table id="catch_list"></table>
			</div>
		</div>
	</div>
<script>

$(function(){
	//左侧树
	$('#catch_pond_tree').treegrid({
		url : webContext + 'production/getUserPondTree',
		checkbox : true,
		fit : true,
		nowrap : true,
		collapsible : true,
		pagination : false,
		autoRowHeight : false,
		idField : "code",
		treeField : "name",
		columns : [ [ 
			{field : 'code',title : '编码',width : 70},
			{field : 'name',title : '名称',width : 150
		} ] ],
		onSelect : function(node) {
			var pondCodeArr = [];
			pondCodeArr.push(node.code);
			var children = $('#catch_pond_tree').treegrid("getChildren", node.code);
			for(var i=0; i<children.length; i++){
				pondCodeArr.push(children[i].code);
			}
			$("#catch_pondCodes").val(pondCodeArr.join(","));
			catch_search();
		},
		onLoadSuccess : function(row, data) {
			if (data && data.length > 0) {
				var firstCode = data[0].firstPondCode;
				firstCode && ( $('#catch_pond_tree').treegrid("select", firstCode) );
			}
		}
	});
	//右侧数据表格
	$('#catch_list').datagrid({
		onBeforeLoad : function() {
			//只有在左侧树有行被选中，才会加载数据
			var treeSel = $('#catch_pond_tree').treegrid("getSelected");
			if (!treeSel) {
				return false;
			}
		},
	   	url: webContext + 'catch/getPagerData',
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
			{ field: 'pondName', title: '池塘名称', width: 100},
			{ field: 'breedName', title: '捕捞品种', width: 100},
			{ field: 'catchWay', title: '捕捞方式', width: 100},
			{ field: 'weight', title: '捕捞重量', width: 80},
			{ field: 'amount', title: '捕捞数量', width: 120},
			{ field: 'catchTime', title: '捕捞时间', width: 150,formatter:function(value, row){return timeFormatter(value);}},
			{ field: 'memo', title: '备注', width: 200 },
			{ field: 'delete_flag', title: '是否可用', width: 80,formatter:delete_flag_formatter },
			{ field: 'creator', title: '创建者', width: 100 },
			{ field: 'createTime', title: '创建时间', width: 150,formatter:function(value, row){return timeFormatter(value);} },
			{ field: 'editTime', title: '编辑时间', width: 150,formatter:function(value, row){return timeFormatter(value);} }
	    ]],
	    toolbar:[
	    {
	        url: "catch/add",  
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				var treeSel = $('#catch_pond_tree').treegrid("getSelected");
				var pond = null;
				if(treeSel && treeSel.code && treeSel.code.length==7){
					pond = {code:treeSel.code, name:treeSel.name};
				}
				catch_showAddDailog(pond);
	        }
		},{
			id: "catch_datagird_editButton",
			url: "catch/edit",
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){
				var selectRows = $('#catch_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				catch_showEditDailog(selectRows[0].id);
		  	}
		},{
			url: "catch/detail",
			text:'查看',
			iconCls:'icon-search',
			handler:function(){
				var selectRows = $('#catch_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				catch_showDetailDailog(selectRows[0].id);
		  	}
		} ],
		onSelect: function(rowIndex, rowData){
			//数据表格数据选择后，对编辑按钮进行权限控制:只能本人编辑本人的记录
			var username = "${user.username}";
			if(rowData.creator != username){
				$("#catch_datagird_editButton").linkbutton('disable');
			}else{
				$("#catch_datagird_editButton").linkbutton('enable');
			}
		}
	});
	actionButtonCtr('catch_list');   
	$('#catch_list').datagrid("doCellTip");
});

//搜索
function catch_search(){
	$('#catch_list').datagrid("load", getFormJson("catch_search_form"));
}

//新增窗口
function catch_showAddDailog(pond){
	var $catch_add_dialog = $("<div><div>");
	$catch_add_dialog.dialog({
		title : '新增',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "catch/add",
		modal : true,
		queryParams : pond,
		buttons : [ {
			id : 'catch_add_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#catch_add_form").form('validate')) {
					var data = getFormJson("catch_add_form");
					$("#catch_add_save").linkbutton('disable');
					$.post( webContext + "catch/addSave", data, 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#catch_add_save").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$catch_add_dialog.dialog('destroy');
								catch_search();//刷新
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
				$catch_add_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$catch_add_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$catch_add_dialog.dialog('open');
}
	
	
//编辑窗口
function catch_showEditDailog(id){
	var $catch_edit_dialog = $("<div><div>");
	$catch_edit_dialog.dialog({
		title : '编辑',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "catch/edit",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			id : 'catch_edit_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#catch_edit_form").form('validate')) {
					var data = getFormJson("catch_edit_form");
					$("#catch_edit_save").linkbutton('disable');
					$.post( webContext + "catch/editSave", data, 
						function(map) {
							$("#catch_edit_save").linkbutton('enable');
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$catch_edit_dialog.dialog('destroy');
								catch_search();//刷新
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
				$catch_edit_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$catch_edit_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$catch_edit_dialog.dialog('open');
}

//查看窗口
function catch_showDetailDailog(id){
	var $catch_detail_dialog = $("<div><div>");
	$catch_detail_dialog.dialog({
		title : '查看',
		width : 600,
		height : 300,
		closed : true,
		cache : false,
		href : webContext + "catch/detail",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$catch_detail_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$catch_detail_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$catch_detail_dialog.dialog('open');
}
	
</script>


</body>
</html>