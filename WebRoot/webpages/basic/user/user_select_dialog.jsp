<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Map<Object,Object> user = (Map<Object,Object>)session.getAttribute("user");	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>绩效考核系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body >
	<input type="hidden" id="user_select_params" value='${params}'>
	<form id="userMainCode_search_form" style="margin:5px 5px;">
			<table id="flow_search" style="word-break: keep-all;font-size:14px">
				<tr>
					<td>用户姓名：</td>
					<td><input class="easyui-textbox" type="text"
						name="nickName" style="width: 150px" /></td>
						<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a href="#" class="easyui-linkbutton"
						iconcls="icon-search"
						onclick="search_load('userMainCode_list', 'userMainCode_search_form')">查询</a></td>
				</tr>
			</table>
		</form>
		<div id="userMainCode_list"></div>
	
	
	<script type="text/javascript">
		$(function() {
			var params=$('#user_select_params').val();
			console.log(params);
			var obj = jQuery.parseJSON(params);
			console.log(obj);
			$('#userMainCode_list').datagrid(
			{
			//url : '${basePath}'+ 'summary/querySelf',
			url : '${basePath}' + 'user/query',
			queryParams:obj,
			height:480,
			nowrap : true,
			idField : 'id',
			striped : true, // 奇偶行是否区分
			singleSelect : true,// 单选模式
			rownumbers : true,// 行号
			sortName: 'username',
			pagination : true,
			pageSize : 10, // 每一页多少条数据
			pageList : [10, 20, 30, 40, 50 ], // 可以选择的每页的大小的combobox
			pagePosition : 'bottom',
			
			columns : [ [
			{field : 'id',title : '',checkbox : true},
			{field : 'username', title : '登录名', width : 100,sortable: true}, 
			{field : 'realname', title : '姓名', width : 100,sortable: true}, 
			{field : 'phone', title : '手机号', width : 100}, 
			{field: 'sex',title: '性别',sortable: true,width: 60,
				formatter: function (value, row) {
					if (value == 0) return '男';
					if (value == 1) return '女';
				}    
	        },
	        {field : 'roleName', title : '角色', width : 100,sortable: true}, 
	        {field : 'deptName', title : '部门名称', width : 100,sortable: true},
			{field : 'createTime', title : '创建时间', width : 140,sortable: true,formatter:function(value, row) {return dateFormatter(value);}},
	        {field: 'delete_flag',title: '是否可用',sortable: true,width: 60,
				formatter: function (value, row) {
					if (value == false) return '<span style=color:green; >是</span>';
					if (value == true) return '<span style=color:red; >否</span>';
				}    
	        } ] ],
			});	
				} );

		
		/**
		 * 日期格式化
		 */
		function dateFormatter1(e) {

			if (typeof (e) == "string") {// 如果是string或number(毫秒数)类型
				// 表示通过.Net MVC提供的 return Json(result,
				// JsonRequestBehavior.AllowGet);方式返回的/Date(1332919782070)/日期格式
				if (e.indexOf("Date") > 0) {
					/* json格式时间转js时间格式 */
					var value = e.substr(1, e.length - 2);
					var obj = eval('(' + "{Date: new " + value + "}" + ')');
					var date = obj["Date"];
					if (date.getFullYear() < 1900) {
						return "";
					}			
					return date.format("yyyy-MM-dd hh:mm:ss");
				}	 
				// 表示其他字符串或数字格式日期
				var date = new Date(e);
				return date.format("yyyy-MM-dd hh:mm:ss");
			} else if (typeof (e) == "number") {
				var date = new Date(e);
				return date.format("yyyy-MM-dd hh:mm:ss");
			} else if (e) {// 如果是Date类型
				return e.format("yyyy-MM-dd hh:mm:ss");
			} else {
				return "";
			}

		}
	</script>
</body>
</html>
