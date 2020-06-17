<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#food_add_table{
	margin-top:10px;
	margin-left:10px;
}
#food_add_table tr{
	height:20px;
}
#food_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#food_add_table td:nth-child(even) input,select{
	width:400px;
}
</style>
	<form id="food_add_form">
		<table id="food_add_table">
			<tr>
				<td>饵料名称：</td>
				<td>
					<input class="easyui-textbox" id="food_add_name" name="name" />
				</td>
			</tr>
			<tr>
				<td>适宜鱼种：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="breedName" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
				<td>效果：</td>
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
