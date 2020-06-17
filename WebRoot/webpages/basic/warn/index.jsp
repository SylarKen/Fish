<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
</head>
<body>
<div class="easyui-layout" style="width:100%;height:100%;">
     <div data-options="region:'north'" style="height:50px;">
    	<form id="warn_search_form">
	    	<ul class="search-param-list">
	    		<li>
	    			<span>员工姓名：</span>
					<select class="easyui-combobox" name="noticeMethod" style="width:200px;">   
					    <option value="">-选择通知方式-</option>   
					    <option value="1">短信</option>   
					    <option value="2">邮件</option>     
					</select> 
				</li>
				<li style="margin-left:20px">
	    			<span>是否开启：</span>
					<select class="easyui-combobox" name="isOpen" style="width:200px;">   
					    <option value="">-是否开启-</option>   
					    <option value="0">开启</option>   
					    <option value="1">关闭</option>     
					</select> 
				</li>
	    		<li style="margin-left:10px;">
	    			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="search_load('warn_list', 'warn_search_form', 'datagrid')">查询</a>
	    		</li>
	    	</ul>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="warn_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#warn_list').datagrid({
		url: '<%=basePath%>warn/query',
		fit: true,
		fitColumns: true,
		nowrap: true,
		idField: 'id',
		striped: true, // 奇偶行是否区分
		//singleSelect: true,// 单选模式
		rownumbers: true,// 行号
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		sortName: 'id',
	    columns:[[
			{field: 'ck', checkbox: true },
            {field: 'noticeMethod', title: '通知方式', width: 100, formatter: function (value, row) {
            	if (value == 1) return '短信';
                if (value == 2) return '邮件';
            }},
            {field: 'noticeTime', title: '通知时间', width: 100},
            {field: 'isOpen', title: '是否开启', width: 100, formatter: function (value, row) {
            	if (value == 0) return '开启';
                if (value == 1) return '关闭';
            }},
            {field: 'creator', title: '创建人', width: 100},
            {
                field: 'delete_flag',
                title: '是否可用',
                sortable: true,
                width: 100,
                formatter: function (value, row) {
                    if (value == 0) return '<span style=color:green; >是</span>';
                    if (value == 1) return '<span style=color:red; >否</span>';
                }    
            }
	    ]],
	    toolbar: [{
			url: 'warn/add',
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				openUserAddDialog();
			}
		},{
			url: 'warn/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRows = $('#warn_list').datagrid('getSelections');
				if (selectedRows.length == 0) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				if (selectedRows.length > 1) {
					$.messager.alert("温馨提示", "请选择一行！");
					return;
				}
				openUserEditDialog(selectedRows[0].id);
			}
		}]
	});
	actionButtonCtr('warn_list');
});

function openUserAddDialog() {
	var $dialog = $("<div id='warn_add_dialog'></div>");
	$dialog.dialog({
        href: '${basePath}warn/insert',
        title: '新增告警配置',
        width: 500,
        height: 300,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('warn_add_form', 'warn_add_dialog', 'warn_list', 'warn_search_form', this);
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

function openUserEditDialog(id) {
	var $dialog = $("<div id='warn_edit_dialog'></div>");
	$dialog.dialog({
        href: '${basePath}warn/update?id=' + id,
        title: '编辑告警配置',
        width: 500,
        height: 350,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('warn_edit_form', 'warn_edit_dialog', 'warn_list', 'warn_search_form', this);
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
</script>
</body>
</html>
