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
<form id="dept_search_search_form" action="" method="post">
<table  style="table-layout: fixed;margin-top:10px;margin-left:30px;font-size:14px;">
    <tr>
        <td>部门名称：</td>
        <td>
            <input class="easyui-textbox" type="text"  id="SysDept_name" name="key11"/>
        </td>
        <td>
            <a href="#" class="easyui-linkbutton" iconcls="icon-search" onclick="search_load('dept_search_list', 'dept_search_search_form','treegrid')">查询</a>
        </td>
    </tr>
</table>
</form>
<div id="dept_search_list"></div>
<script>
$(function () {
$('#dept_search_list').treegrid({
    url: '${basePath}dept/query',
    fitColumns: true,
    nowrap: true,
    treeField:"name",
    height: $(window).height()-128,
    collapsible: true,
    pagination: true,
    autoRowHeight: false,
    idField: 'deptId',
    striped: true, //奇偶行是否区分
    singleSelect: true,//单选模式
    rownumbers: true,//行号
    remoteSort: false,
    sortName: 'grade',
    pageSize: 10, //每一页多少条数据
    pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
    columns: [[
	    { field: 'ck', checkbox: true },
	    { field: 'id', title: '部门编码', width: 100 },
	    { field: 'name', title: '部门名称', width: 100 },
	    { field: 'deptLevel', title: '级别', width: 100,hidden:true},
	    {
	        field: 'delete_flag',
	        title: '是否可用',
	        sortable: true,
	        width: 100,
	        formatter: function (value, row) {
	            if (value == false) return '<span style=color:green; >是</span>';
	            if (value == true) return '<span style=color:red; >否</span>';
	        }    
	    }
    ]],
    onLoadSuccess:function(row,data){           	
        var selectedId = $("#dept_edit_parentId").val();
        if(selectedId)
          $('#dept_search_list').treegrid('select',selectedId);
    }
});
});
</script>
</body>
</html>
