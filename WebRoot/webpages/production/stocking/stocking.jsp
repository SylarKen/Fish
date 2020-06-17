<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#stocking_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#stocking_search_form .conditionSpan input,select {
	width:100px;
}
</style>

<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true" title="池塘列表" style="width:250px;">
		<table id="stocking_pond_tree"></table>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-layout" data-options="border:false,fit:true" >
			<div data-options="region:'north',border:false">
				<form id="stocking_search_form" style="margin:0 5px;">
				<input type="hidden" id="stocking_pondCodes" name="pondCodes" />
				<input type="hidden" id="username" name="username" value = "${bean.username }" />
				<div>
					<span class="conditionSpan">
						<span>鱼苗名称：</span>
						<input class="easyui-textbox" name="fishname" />
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
						<a class="easyui-linkbutton" onclick="stocking_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
					</span>
				</div>
				</form>	
			</div>
			<div data-options="region:'center',border:false" style="width:100%;">
				<table id="stocking_list"></table>
			</div>
		</div>
	</div>
<script>

$(function(){
	//左侧树
	$('#stocking_pond_tree').treegrid({
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
			var children = $('#stocking_pond_tree').treegrid("getChildren", node.code);
			for(var i=0; i<children.length; i++){
				pondCodeArr.push(children[i].code);
			}
			$("#stocking_pondCodes").val(pondCodeArr.join(","));
			stocking_search();
		},
		onLoadSuccess : function(row, data) {
			if (data && data.length > 0) {
				var firstCode = data[0].firstPondCode;
				firstCode && ( $('#stocking_pond_tree').treegrid("select", firstCode) );
			}
		}
	});
	//右侧数据表格
	$('#stocking_list').datagrid({
		onBeforeLoad : function() {
			//只有在左侧树有行被选中，才会加载数据
			var treeSel = $('#stocking_pond_tree').treegrid("getSelected");
			if (!treeSel) {
				return false;
			}
		},
	   	url: webContext + 'stocking/getPagerData',
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
			{ field: 'pondName', title: '池塘名称 ', width: 100},
			{ field: 'pondArea', title: '池塘面积 (亩)', width: 120},
			{ field: 'fishname', title: '鱼苗名称', width: 100},
			{ field: 'throwdate', title: '放养日期', width: 180,formatter:function(value, row){return timeFormatter(value);}},
			{ field: 'fishfrom', title: '苗种来源', width: 180},
			{ field: 'standard', title: '苗种规格', width: 150 },
			{ field: 'density', title: '放养密度(只,尾/亩)', width: 170 },
			{ field: 'weight', title: '放养重量(kg)', width: 120 },
			{ field: 'quarantine', title: '检疫情况', width: 100 },
			{ field: 'degassing', title: '消毒', width: 100 },
			{ field: 'waterQuality', title: '水质参数', width: 100 ,hidden:true },
			{ field: 'batchNumber', title: '批次号', width: 100 ,hidden:true },
			{ field: 'memo', title: '备注', width: 200 },
			{ field: 'delete_flag', title: '是否可用', width: 100,formatter:delete_flag_formatter },
			{ field: 'creator', title: '创建者', width: 100 },
			{ field: 'createTime', title: '创建时间', width: 180,formatter:function(value, row){return timeFormatter(value);} },
			{ field: 'editor', title: '编辑者', width: 100 ,hidden:true},
			{ field: 'editTime', title: '编辑时间' ,hidden:true, width: 150,formatter:function(value, row){return timeFormatter(value);} }
	    ]],
	    toolbar:[
	    {
	        url: "stocking/add",  
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				var treeSel = $('#stocking_pond_tree').treegrid("getSelected");
				var pond = null;
				if(treeSel && treeSel.code && treeSel.code.length==7){
					pond = {code:treeSel.code, name:treeSel.name};
				}
				stocking_showAddDailog(pond);
	        }
		},{
			url: "stocking/edit",
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){
				var selectRows = $('#stocking_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				stocking_showEditDailog(selectRows[0].id);
		  	}
		},{
			url: "stocking/detail",
			text:'查看',
			iconCls:'icon-search',
			handler:function(){
				var selectRows = $('#stocking_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				stocking_showDetailDailog(selectRows[0].id);
		  	}
		} ]
	});
	actionButtonCtr('stocking_list');   
	$('#stocking_list').datagrid("doCellTip");
});

//搜索
function stocking_search(){
	$('#stocking_list').datagrid("load", getFormJson("stocking_search_form"));
}

//新增窗口
function stocking_showAddDailog(pond){
	var $stocking_add_dialog = $("<div><div>");
	$stocking_add_dialog.dialog({
		title : '新增放养管理',
		width : 700,
		height : 450,
		closed : true,
		cache : false,
		href : webContext + "stocking/add",
		modal : true,
		queryParams : pond,
		buttons : [ {
			id : 'stocking_add_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#stocking_add_form").form('validate')) {
					var data = getFormJson("stocking_add_form");
					$("#stocking_add_save").linkbutton('disable');
					$.post( webContext + "stocking/addSave", data, 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#stocking_add_save").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$stocking_add_dialog.dialog('destroy');
								stocking_search();//刷新
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
				$stocking_add_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$stocking_add_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$stocking_add_dialog.dialog('open');
}
	
	
//编辑窗口
function stocking_showEditDailog(id){
	if(creator != $("#username").val()){
		/* $.messager.alert("温馨提示", "您不能编辑本条信息！"); */
	}else{
		var $stocking_edit_dialog = $("<div><div>");
		$stocking_edit_dialog.dialog({
			title : '编辑放养信息',
			width : 700,
			height : 450,
			closed : true,
			cache : false,
			href : webContext + "stocking/edit",
			modal : true,
			queryParams: {id:id},
			buttons : [ {
				id : 'stocking_edit_save',
				text : '保存',
				iconCls : 'icon-ok',
				handler : function() {
					if ($("#stocking_edit_form").form('validate')) {
						var data = getFormJson("stocking_edit_form");
						$("#stocking_edit_save").linkbutton('disable');
						$.post( webContext + "stocking/editSave", data, 
							function(map) {
								$("#stocking_edit_save").linkbutton('enable');
								if(!map.ok){
									$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								}else{
									$.messager.alert("温馨提示", "保存成功！");
									$stocking_edit_dialog.dialog('destroy');
									stocking_search();//刷新
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
					$stocking_edit_dialog.dialog('destroy');
				}
			} ],
			onClose:function(){
				$stocking_edit_dialog.dialog('destroy');
			}  
		});
		//初始化后打开对话框
		$stocking_edit_dialog.dialog('open');
	}
}

//查看窗口
function stocking_showDetailDailog(id){
	var $stocking_detail_dialog = $("<div><div>");
	$stocking_detail_dialog.dialog({
		title : '查看',
		width : 700,
		height : 450,
		closed : true,
		cache : false,
		href : webContext + "stocking/detail",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$stocking_detail_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$stocking_detail_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$stocking_detail_dialog.dialog('open');
}
	
</script>


</body>
</html>