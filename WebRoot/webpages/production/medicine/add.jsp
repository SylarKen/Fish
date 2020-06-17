<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#medicine_add_table{
	margin-top:10px;
	margin-left:10px;
}
#medicine_add_table tr{
	height:20px;
}
#medicine_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#medicine_add_table td:nth-child(even) input,select{
	width:400px;
}
</style>
	<form id="medicine_add_form">
		<table id="medicine_add_table">
			<tr>
				<td>药品名称：</td>
				<td>
					<input class="easyui-textbox" id="medicine_add_name" name="name" />
				</td>
			</tr>
			<tr>
				<td>适宜鱼种：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="breedName" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
				<td>适用症状：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="symptoms" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
				<td>功效：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="effect" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
		</table>
	</form>
<script>

$(function(){
	
});


</script>
</body>
</html>
