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
    	<form id="user_search_form">
	    	<ul class="search-param-list">
	    		<li><span>员工姓名：</span><input class="easyui-textbox" name="nickName"/></li>
	    		<li style="margin-left:10px;">
	    			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="search_load('user_list', 'user_search_form', 'datagrid')">查询</a>
	    		</li>
	    	</ul>
    	</form>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="user_list"></div>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$('#user_list').datagrid({
		url: '${basePath}user/query',
		fit: true,
		fitColumns: true,
		nowrap: true,
		idField: 'username',
		striped: true, // 奇偶行是否区分
		//singleSelect: true,// 单选模式
		rownumbers: true,// 行号
		pagination: true,
		pageSize: 20, // 每一页多少条数据
		pageList: [ 10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
		sortName: 'username',
	    columns:[[
			{field: 'ck', checkbox: true },
            {field: 'username', title: '登录账号', width: 100},
            {field: 'usercode', title: '编码', width: 100},
            {field: 'realname', title: '姓名', width: 200 },
            {field: 'sex', title: '性别', width: 100, formatter: function (value, row) {
            	if (value == 0) return '<span>男</span>';
                if (value == 1) return '<span>女</span>';
            }},
            {field: 'phone', title: '手机号码', width: 200 },
            /* {field: 'age', title: '年龄', width: 100}, */
            {field: 'deptName', title: '所在部门', width: 200 },
            {field: 'roleName', title: '角色', width: 150},
            /* {field: 'areaName', title: '区域', width: 50 }, */
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
			url: 'user/edit',
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				openUserAddDialog();
			}
		},{
			url: 'user/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRows = $('#user_list').datagrid('getSelections');
				if (selectedRows.length == 0) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				if (selectedRows.length > 1) {
					$.messager.alert("温馨提示", "请选择一行！");
					return;
				}
				openUserEditDialog(selectedRows[0].username);
			}
		},{
			url: 'user/tongbu',
			text : '同步',
			iconCls : 'icon-sync',
			handler : function() {
				$.post('${basePath}weixin/tongbu', {}, function(data) {
            		if (data.errMsg) {
            			$.messager.alert("温馨提示", "同步失败！"+data.errMsg);
    					return;
            		} else {
            			$.messager.alert("温馨提示", "同步成功！");
    					return;
            		}
        		},'json');
			}
		}, {
			text : '打印条码',
			iconCls : 'icon-printer',
			handler : function() {
				var selectedRows = $('#user_list').datagrid('getSelections');
				if (selectedRows.length == 0) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				var barcodes = '';
				for (var i = 0; i < selectedRows.length; i++) {
					if (barcodes == '') {
						barcodes += selectedRows[i].usercode;
					} else {
						barcodes = barcodes + ',' + selectedRows[i].usercode;
					}
				}
				showBarcodePrintDialog(barcodes);
			}
		}]
	});
	//actionButtonCtr('score_list');
});

function openUserAddDialog() {
	var $dialog = $("<div id='user_add_dialog'></div>");
	$dialog.dialog({
        href: '${basePath}user/insert',
        title: '新增用户',
        width: 500,
        height: 600,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('user_add_form', 'user_add_dialog', 'user_list', 'user_search_form', this);
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

function openUserEditDialog(username) {
	var $dialog = $("<div id='user_edit_dialog'></div>");
	$dialog.dialog({
        href: '${basePath}user/update?username=' + username,
        title: '编辑用户',
        width: 500,
        height: 600,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	submitForm('user_edit_form', 'user_edit_dialog', 'user_list', 'user_search_form', this);
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
