<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>池塘管理</title>
<jsp:include page="/common.jsp"></jsp:include>
</head>
<body>
<style >
#pond_search_form .conditionSpan {
	margin:5px;
	display: inline-block;
}
#pond_search_form .conditionSpan input,select {
	width:100px;
}
</style>
	<div class="easyui-layout" style="width:98%;height:100%;" data-options="fit:true">
		<div region="west" split="true" title="养殖点列表" style="width:25%;">
			<table id="pond_left_category_tree"></table>
		</div>
	<div region="center"  >
			<div class="easyui-layout" data-options="border:false,fit:true">
				<div data-options="region:'north',border:false">
					<form id="pond_search_form" style="margin:0 5px;">
					
					<input id="pond_deptCode" type="hidden" name="deptCode" />
					<div>
					<span class="conditionSpan">
						<span>池塘名称：</span>
						<input class="easyui-textbox" name="name" />
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
						<a class="easyui-linkbutton" onclick="pond_search()" data-options="iconCls:'icon-search'" style="height:22px;">查询</a>
					</span>
				</div>	
					</form>
				</div>
				<div data-options="region:'center',border:false" style="width:100%;">
					<div id="pond_right_list"></div>
				</div>
			</div>
		</div>
	</div>

<script>
var products_url;
$(function(){
	
	//遍历左边的树--养殖点
	$('#pond_left_category_tree').treegrid({
	    url: '<%=basePath%>pond/query',
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
			{title:'养殖点编码', field:'code', width:100},
			{title:'养殖点名称', field:'name', width:180},
			{title:'层级', field:'grade', hidden:true},
			{
				title: '是否可用',
				field: 'delete_flag',
				width: 150,
				formatter: function(value, row) {
					if (value == 0) return '可用';
					if (value == 1) return '<span style=color:red;>不可用</span>';
				}, hidden:true
			}
	    ]],
		onSelect : function(node) {	
			$("#pond_deptCode").val(node.code);
			pond_search();
		},
		onLoadSuccess : function(row, data) {
			console.log(data)
			if (data && data.rows && data.rows.length > 0) {
				var firstCode = data.rows[0].code;
				$('#pond_left_category_tree').treegrid("select", firstCode) ;
			}
		}  
    });
	var treeSel;
	var treeCode;
	$('#pond_right_list').datagrid({
		onBeforeLoad:function(){
			//只有在左侧有行被选中，才会加载数据
			treeSel = $('#pond_left_category_tree').treegrid("getSelected");
			if(!treeSel){
				return false;
			}
		},
	    url: webContext + 'pond/getPonds',
	    fit: true,
	    fitColumns: false,
	    nowrap: true,
	   // collapsible: true,
	    pagination: true,
	    autoRowHeight: false,
	    idField: 'code',
	    striped: true, //奇偶行是否区分
	    singleSelect: true,//单选模式
	    rownumbers: true,//行号
	    remoteSort: true,
	    sortName: 'code',
	    pageSize: 20, //每一页多少条数据
	    pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
	    //queryParams: { deptCode: treeCode}, //传递到后台的参数
	    columns: [[
            { field: 'ck', checkbox: true },
            { field: 'code', title: '池塘编码 ', width: 80},
            { field: 'name', title: '池塘名称', width: 130 },
            { field: 'area', title: '池塘面积(亩)', width: 80 },
            { field: 'fishinfo', title: '主要养殖品种', width: 230 },
            { field: 'location', title: '位置', width: 200 },
            { field: 'linkman', title: '联系人', width: 110 },
            { field: 'contactway', title: '联系方式', width: 110 },
            {
                field: 'delete_flag',
                title: '是否可用',
                sortable: true,
                width: 80,
                formatter: function (value, row) {
                    if (value == 0) return '<span style=color:green; >是</span>';
                    if (value == 1) return '<span style=color:red; >否</span>';
                }    
            }
	    ]],
	    toolbar:[
	    {
	        url: "pond/add",  
			text:'新增',
			iconCls:'icon-add',
			handler:function(){
				showPondAddDailog();
	        }
		},{
			url: 'pond/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRows = $('#pond_right_list').datagrid('getSelections');
				if (selectedRows.length == 0) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				if (selectedRows.length > 1) {
					$.messager.alert("温馨提示", "请选择一行！");
					return;
				}
				openPondEditDialog(selectedRows[0].code);
			}
		},{
			url: "pond/detail",
			text:'查看',
			iconCls:'icon-search',
			handler:function(){
				var selectRows = $('#pond_right_list').datagrid('getSelections');
				if (!selectRows || selectRows.length <= 0) {
				      $.messager.alert("温馨提示", "请先选择一行！");
				      return;
				}
				showPondDetailDailog(selectRows[0]);
		    }
		}]
	});
	
	actionButtonCtr('pond_right_list');   
        
});


//新增池塘信息
function showPondAddDailog() {
		//只有在左侧有行被选中，才会加载数据
		var treeSel = $('#pond_left_category_tree').treegrid("getSelected");
		//alert(treeSel);
		if(!treeSel){
			$.messager.alert("温馨提示", "请先选择养殖点！");
			return false;
		}else  if(treeSel.grade!=2)  {
			$.messager.alert("温馨提示", "请选择养殖点！");
			return false;
		}else{
			var name = treeSel.name;
			var code = treeSel.code;
			var $dialog = $("<div id='dlg'></div>");
			$dialog.dialog({
		        href: webContext+'pond/add?id='+code+'&name='+name,
		        title: '新增池塘信息',
		        width: 600,
		        height: document.body.clientHeight-350,
		        closed: true,
		        cache: false,
		        modal: true,
		        buttons: [{
		            text: '确定',
		            iconCls:'icon-ok',
		            handler: function() {
		            	submitForm_pond('add_form', 'dlg', 'grid', 'pond_search_form', this);
		            	 
		            }
		        },{
		            text: '取消',
		            iconCls:'icon-cancel',
		            handler: function() {
		                $dialog.dialog('close');
		            }
		        }],
		        onClose: function() {
		        	pond_search();
		            $dialog.dialog('destroy');
		        }
		    });
		    $dialog.dialog('open');
			
		}
}




function submitForm_pond(formId, dialogId, gridId, gridFormId,subBtn,gridType) {
	var form = $("#" + formId);
	var action = form.attr("action");
	//alert(action);
	if (form.form("validate")) {
		$(subBtn).linkbutton("disable");
		$.post(action, getFormJson(formId), function(data) {
			data = eval( "(" + data + ")" );
            if(data.errorMsg){
            	$.messager.alert("温馨提示", data.errorMsg);
            }else{
				$.messager.alert("温馨提示", "保存成功！");
				if (dialogId) {
					$('#' + dialogId).dialog('close');
				}
				search_load(gridId, gridFormId, gridType);
			}
		});
		$(subBtn).linkbutton("enable");
	}
}









//搜索
function pond_search(){
	$('#pond_right_list').datagrid("load", getFormJson("pond_search_form"));
}

//编辑窗口
function openPondEditDialog(code) {
	var $dialog = $("<div id='pond_edit_dialog'></div>");
	$dialog.dialog({
        href: '${basePath}pond/edit?code=' + code,
        title: '编辑池塘信息',
        width: 600,
        height: document.body.clientHeight-350,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('fond_edit_form', 'pond_edit_dialog', 'pond_right_list', 'pond_search_form', this);
            }
        },{
            text: '取消',
            iconCls:'icon-cancel',
            handler: function() {
                $dialog.dialog('close');
            }
        }],
        onClose: function() {
            $dialog.dialog('destroy');
        }
    });
    $dialog.dialog('open');
}

//查看窗口
function showPondDetailDailog(queryParams){
	var $pond_detail_dialog = $("<div><div>");
	$pond_detail_dialog.dialog({
		title : '池塘详情',
		width : 600,
		height : document.body.clientHeight-350,
		closed : true,
		cache : false,
		href : webContext + "pond/detail",
		modal : true,
		queryParams: queryParams,
		buttons : [ {
			text : '取消',
			iconCls : 'icon-cross',
			handler : function() {
				$pond_detail_dialog.dialog('destroy');
			}
		} ],
		onClose:function(){
			$pond_detail_dialog.dialog('destroy');
		}  
	});
	//初始化后打开对话框
	$pond_detail_dialog.dialog('open');
}
	
</script>


</body>
</html>