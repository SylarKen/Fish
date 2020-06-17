<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#fishinfo_add_table{
	margin-top:10px;
	margin-left:10px;
}
#fishinfo_add_table tr{
	height:20px;
}
#fishinfo_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#fishinfo_add_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="fishinfo_add_form">
		<table id="fishinfo_add_table">
			<tr>
				<td>鱼苗名称：</td>
				<td>
					<input class="easyui-textbox" id="fishinfo_add_name" name="fishname" />
				</td>
				<td>鱼苗别名：</td>
				<td>
					<input class="easyui-textbox" id="fishinfo_add_breed_name" name="fishanother" />
				</td>
			</tr>
			<tr>
				<td>养殖环境：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="environment" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
