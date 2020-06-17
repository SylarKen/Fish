<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#inspection_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#inspection_search_form .conditionSpan input,select {
	width:110px;
}
</style>

<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true" title="池塘列表" style="width:250px;">
		<table id="inspection_pond_tree"></table>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-layout" data-options="border:false,fit:true" >
			<div data-options="region:'north',border:false">
				<form id="inspection_search_form" style="margin:0 5px;">
				<input type="hidden" id="inspection_pondCodes" name="pondCodes" />
				<input type="hidden" id="username" name="username" value = "${bean.username }" />
				<div>
					<span class="conditionSpan">
						<span>巡塘日期：</span>
						<input  class="easyui-datebox" label="Customized Format:" labelPosition="top" 
						data-options="formatter:myformatter,parser:myparser"  name = "inspec_time"       >
		
						<input hidden = "true" data-options="formatter:myformatter"  id="yield_day_date"  name = "inspec_time1" />
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
						<a class="easyui-linkbutton" onclick="inspection_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
					</span>
				</div>
				</form>	
			</div>
			<div data-options="region:'center',border:false" style="width:100%;">
				<table id="inspection_list"></table>
			</div>
		</div>
	</div>
<script>

function myformatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
function myparser(s){
	if (!s) return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var d = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){	
		$("#yield_day_date").val(myformatter(new Date(y,m-1,d+1)));
		return new Date(y,m-1,d);
	} else {
		return new Date();	
	}
}
$(function(){
	//左侧树
	$('#inspection_pond_tree').treegrid({
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
			var children = $('#inspection_pond_tree').treegrid("getChildren", node.code);
			for(var i=0; i<children.length; i++){
				pondCodeArr.push(children[i].code);
			}
			$("#inspection_pondCodes").val(pondCodeArr.join(","));
			inspection_search();
		},
		onLoadSuccess : function(row, data) {
			if (data && data.length > 0) {
				var firstCode = data[0].firstPondCode;
				firstCode && ( $('#inspection_pond_tree').treegrid("select", firstCode) );
			}
		}
	});
	//右侧数据表格
	$('#inspection_list').datagrid({
		onBeforeLoad : function() {
			//只有在左侧树有行被选中，才会加载数据
			var treeSel = $('#inspection_pond_tree').treegrid("getSelected");
			if (!treeSel) {
				return false;
			}
		},
	   	url: webContext + 'inspection/getPagerData',
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
			{ field: 'inspect_time', title: '巡塘日期', width: 180,formatter:function(value, row){return timeFormatter(value);}},
			{ field: 'weather', title: '天气', width: 120},
			{ field: 'water_quality', title: '水质情况', width: 130 },
			{ field: 'pick_amount', title: '采饵量', width: 120 },
			{ field: 'fish_status', title: '鱼苗情况', width: 200 },
			{ field: 'result', title: '巡塘结果', width: 200 },
			{ field: 'memo', title: '备注', width: 200 },
			{ field: 'delete_flag', title: '是否可用', width: 80,formatter:delete_flag_formatter },
			{ field: 'creator', title: '创建者', width: 100 },
			{ field: 'createTime', title: '创建时间', width: 180,formatter:function(value, row){return timeFormatter(value);} },
			{ field: 'editor', title: '编辑者', width: 100 ,hidden:true},
			{ field: 'editTime', title: '编辑时间' ,hidden:true, width: 150,formatter:function(value, row){return timeFormatter(value);} }
	    ]],
	    toolbar:[
	    {
	        url: "inspection/add",  
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				var treeSel = $('#inspection_pond_tree').treegrid("getSelected");
				var pond = null;
				if(treeSel && treeSel.code && treeSel.code.length==7){
					pond = {code:treeSel.code, name:treeSel.name};
				}
				inspection_showAddDailog(pond);
	        }
		},{
			url: "inspection/edit",
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){
				var selectRows = $('#inspection_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				inspection_showEditDailog(selectRows[0].id,selectRows[0].creator);
		  	}
		},{
			url: "inspection/detail",
			text:'查看',
			iconCls:'icon-search',
			handler:function(){
				var selectRows = $('#inspection_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				inspection_showDetailDailog(selectRows[0].id);
		  	}
		} ]
	});
	actionButtonCtr('inspection_list');   
	$('#inspection_list').datagrid("doCellTip");
});

//搜索
function inspection_search(){
	$('#inspection_list').datagrid("load", getFormJson("inspection_search_form"));
}
    
//新增窗口
function inspection_showAddDailog(pond){
	var $inspection_add_dialog = $("<div><div>");
	$inspection_add_dialog.dialog({
		title : '新增巡塘信息',
		width : 700,
		height : 450,
		closed : true,
		cache : false,
		href : webContext + "inspection/add",
		modal : true,
		queryParams : pond,
		buttons : [ {
			id : 'inspection_add_save',
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				if ($("#inspection_add_form").form('validate')) {
					var data = getFormJson("inspection_add_form");
					$("#inspection_add_save").linkbutton('disable');
					$.post( webContext + "inspection/addSave", data, 
						function(map) {
							if(!map.ok){
								$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								$("#inspection_add_save").linkbutton('enable');
							}else{
								$.messager.alert("温馨提示", "保存成功！");
								$inspection_add_dialog.dialog('destroy');
								inspection_search();//刷新
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
				$inspection_add_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$inspection_add_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$inspection_add_dialog.dialog('open');
}
	
	
//编辑窗口
function inspection_showEditDailog(id,creator){
	
	if(creator != $("#username").val()){
		/* $.messager.alert("温馨提示", "您不能编辑本条信息！"); */
	}else{
		var $inspection_edit_dialog = $("<div><div>");
		$inspection_edit_dialog.dialog({
			title : '编辑巡塘信息',
			width : 750,
			height : 500,
			closed : true,
			cache : false,
			href : webContext + "inspection/edit",
			modal : true,
			queryParams: {id:id},
			buttons : [ {
				id : 'inspection_edit_save',
				text : '保存',
				iconCls : 'icon-ok',
				handler : function() {
					if ($("#inspection_edit_form").form('validate')) {
						var data = getFormJson("inspection_edit_form");
						$("#inspection_edit_save").linkbutton('disable');
						$.post( webContext + "inspection/editSave", data, 
							function(map) {
								$("#inspection_edit_save").linkbutton('enable');
								if(!map.ok){
									$.messager.alert({title:"温馨提示",msg:map.errorMsg, width:"350px"});
								}else{
									$.messager.alert("温馨提示", "保存成功！");
									$inspection_edit_dialog.dialog('destroy');
									inspection_search();//刷新
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
					$inspection_edit_dialog.dialog('destroy');
				}
			} ],
			onClose:function(){
				$inspection_edit_dialog.dialog('destroy');
			}  
		});
		//初始化后打开对话框
		$inspection_edit_dialog.dialog('open');
	}
}

//查看窗口
function inspection_showDetailDailog(id){
	var $inspection_detail_dialog = $("<div><div>");
	$inspection_detail_dialog.dialog({
		title : '查看巡塘信息',
		width : 700,
		height : 500,
		closed : true,
		cache : false,
		href : webContext + "inspection/detail",
		modal : true,
		queryParams: {id:id},
		buttons : [ {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$inspection_detail_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$inspection_detail_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$inspection_detail_dialog.dialog('open');
}
	
</script>


</body>
</html>