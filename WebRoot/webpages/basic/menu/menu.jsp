<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>绩效考核系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="菜单">
</head>
<body>
<div id="menu_list"></div>
<script type="text/javascript">
$(function() {
	$('#menu_list').treegrid({
	    url: webContext + 'menu/query',
	    idField: 'menuId',
	    treeField: 'menuName',
	    singleSelect: true,
	    fit: true,
	    fitColumns: true,
	    columns:[[
			{title:'ID', field:'menuId', width:50},
			{title:'名称', field:'menuName', width:240},
			{title:'URL', field:'menuUrl', width:180},
			{
				title: '图标', 
				field: 'iconUrl', 
				width: 60, 
				formatter: function(value, row) {
					return '<i class="fa '+ value +'"></i>';
				}
			},
			{title:'层级', field:'menuLevel', width:80},
			{
				title: '是否为叶子结点', 
				field: 'isLeaf', 
				width: 120, 
				formatter: function(value, row) {
					if (value == 0) return '否';
					if (value == 1) return '是';
				}
			},
			{
				title: '类型',
				field: 'menuType',
				width: 80,
				formatter: function(value, row) {
					if (value == 1) return '菜单';
					if (value == 2) return '按钮';
				}
			},
			{title:'排序',field:'menuOrder',width:80},
			{
				title: '是否可用',
				field: 'delete_flag',
				width: 80,
				formatter: function(value, row) {
					if (value == 0) return '可用';
					if (value == 1) return '<span style=color:red;>不可用</span>';
				}
			}
	    ]],
	    toolbar : [{
	    	url: 'menu/add',
			text : '新增',
			iconCls : 'icon-add',
			handler : function() {
				var selectedRow = $('#menu_list').datagrid('getSelected');
				var parentId = selectedRow == null ? 0 : selectedRow.menuId;
				var menuType = selectedRow == null ? 1 : selectedRow.menuType;
				if(menuType == 2) {
					$.messager.alert("温馨提示", "选中菜单的类型为“按钮”，不允许添加子节点！");
					return;
				} else {
					openMenuAddDialog(parentId);
				}
			}
		},{
			url: 'menu/edit',
			text : '编辑',
			iconCls : 'icon-edit',
			handler : function() {
				var selectedRow = $('#menu_list').datagrid('getSelected');
				if (selectedRow == null) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				openMenuEditDialog(selectedRow.menuId);
			}
		},{
			url: 'menu/del',
			text : '删除',
			iconCls : 'icon-delete',
			handler : function() {
				var selectedRow = $('#menu_list').datagrid('getSelected');
				if (selectedRow == null) {
					$.messager.alert("温馨提示", "请先选择一行！");
					return;
				}
				$.messager.confirm('温馨提示', '删除操作不可恢复，且删除后，菜单下的所有子节点都将被删除。您确定要删除该菜单吗？', function(r) {
					if (r) {
						$.get(webContext + "menu/delete?menuId=" + selectedRow.menuId, {}, function(data) {
							if (data > 0) {
								$.messager.alert("温馨提示", "删除成功！");
								search_load('menu_list', 'menu_search_form', 'treegrid');
							} else
								$.messager.alert("温馨提示", "删除失败！");
						});
					}
				});
			}
		}],
	    onLoadSuccess: function() {
	    }
	});
	
	actionButtonCtr('menu_list');
});


function openMenuAddDialog(parentId) {
	var $dialog = $("<div></div>");
	$dialog.dialog({
        href: webContext  + 'menu/insert?parentId=' + parentId,
        title: '新增菜单',
        width: 500,
        height: 500,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	ajaxSubmitForm('menu_add_form', $dialog, 'menu_list', '', 'treegrid');
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

function openMenuEditDialog(menuId) {
 
	var $dialog = $("<div></div>");
	$dialog.dialog({
        href: webContext + 'menu/update?menuId=' + menuId,
        title: '编辑菜单',
        width: 500,
        height: 500,
        closed: true,
        cache: false,
        modal: true,
        buttons: [{
            text: '确定',
            iconCls:'icon-ok',
            handler: function() {
            	ajaxSubmitForm('menu_edit_form', $dialog, 'menu_list', '', 'treegrid');
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

function searchByName() {
	search_load('menu_list', 'menu_search_form', 'treegrid');
	var menuName= $('#menuName').textbox('getText');
	if(menuName!=null&&menuName!=""){
		$.post('${basePath}menu/search',{"menuName" :menuName},function(data) {
		data = eval("("+ data+ ")");
		console.log(data);
		console.log(data.length);
		if (data.errorMsg) {
			$.messager.alert("温馨提示",data.errorMsg);
		} else {
			$.each(JSON.parse(data),function(index,item){
				$('#menu_list').treegrid('select',item.menuId);
				});
		}
	});
	}
}
</script>
</body>
</html>
