<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>德州恒丰纺织后台管理系统</title>
<jsp:include page="/common.jsp"></jsp:include>
   
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
<div class="easyui-layout" style="width:100%;height:100%;">
    <div data-options="region:'north'" style="height:50px;">
    	<form id="dept_search_form">
	    	<ul class="search-param-list">
	    		<li><span>名称：</span><input class="easyui-textbox" name="name"/></li>
	    		<li style="margin-left:10px;">
	    			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="search_load('dept_list', 'dept_search_form', 'treegrid')">查询</a>
	    		</li>
	    	</ul>
    	</form>
    </div>
    <div data-options="region:'center'">
    	<div id="dept_list"></div>
    </div>
</div>

 
<script type="text/javascript">
$(function() {
	$('#dept_list').treegrid({
	    url: '<%=basePath%>dept/query',
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
			{field: 'ck', checkbox: true},
			{title:'编码', field:'code', width:100},
			{title:'编码', field:'pcode', width:100,hidden:true},
			{title:'名称', field:'name', width:180},
			{title:'层级', field:'grade', width:80},
			{title:'区划编码', field:'areaId', width:100},
			{title:'区划名称', field:'areaName', width:120},
			{title:'地址', field:'address', width:180},
			{title:'经度', field:'lng', width:70},
			{title:'维度', field:'lat', width:70},
			{title:'联系人', field:'linkman', width:100},
			{title:'联系电话', field:'linkphone', width:100},
			{title:'创建人', field:'creator', width:100},
			{
				title: '是否可用',
				field: 'delete_flag',
				width: 150,
				formatter: function(value, row) {
					if (value == 0) return '可用';
					if (value == 1) return '<span style=color:red;>不可用</span>';
				}
			}
	    ]],
	    toolbar : [{
	    	url: 'dept/insert',
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				var selectedRow = $('#dept_list').datagrid('getSelected');
				var pname = selectedRow == null ? '运营公司' : selectedRow.name;
				var pcode = selectedRow == null ? 0 : selectedRow.code;
				var pgrade = selectedRow == null ? 0 : selectedRow.grade;
				if(pgrade == 2) {
					$.messager.alert("温馨提示", "选中为养殖点，不允许添加子节点！");
					return;
				} else {
					openDeptAddDialog(pname,pcode,pgrade);
				}
				//openDeptAddDialog();
			}
		},{
			url: 'dept/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRow = $('#dept_list').datagrid('getSelected');
				
				if (selectedRow == null) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}

				if(selectedRow.grade>Number('${myDept.grade}')+1){
					$.messager.alert("温馨提示", "您不能维护养殖点信息！");
					return;
				} 
				var pcode = selectedRow.pcode;
				openDeptEditDialog(selectedRow.code,pcode);
			}
		}]
	});
	
	 actionButtonCtr('dept_list');
});
function openDeptAddDialog(pname,pcode,pgrade) {
	var $dialog = $("<div></div>");
	$dialog.dialog({
		// href: webContext  + 'menu/insert?parentId=' + parentId,
        href: '${basePath}dept/insert?pname='+ pname+'&pcode='+ pcode+'&pgrade='+ pgrade,//pname,pcode,pgrade
        title: '新增部门',
        width: 700,
        height:  pageSize().height-350,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	ajaxSubmitForm('dept_add_form', $dialog, 'dept_list', '', 'treegrid');
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

function openDeptEditDialog(deptId,pcode) {
	var $dialog = $("<div></div>");
	$dialog.dialog({
        href: '${basePath}dept/update?code=' + deptId+'&pcode='+pcode,
        title: '编辑部门',
        width: 700,
        height:  pageSize().height-320,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	ajaxSubmitForm('dept_edit_form', $dialog, 'dept_list', '', 'treegrid');
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
function deleteDept(){
	var selectedRow = $('#dept_list').datagrid('getSelected');
	if (selectedRow == null) {
		$.messager.alert("温馨提示", "请先选择一行！");
		return;
	}
	$.messager.confirm('温馨提示', '删除部门后，其部门下的所有子部门都将不可用。您确定要删除该部门吗？', function(r) {
		if (r) {
			$.get("${basePath}dept/delete?deptId=" + selectedRow.id, {}, function(data) {
				if (data > 0) {
					$.messager.alert("温馨提示", "删除成功！");
					search_load('dept_list', 'dept_search_form', 'treegrid');
				} else
					$.messager.alert("温馨提示", "删除失败！");
			});
		}
	});
}
</script>
 
</body>
</html>
