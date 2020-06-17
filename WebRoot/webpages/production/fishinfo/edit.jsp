<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#fishinfo_edit_table{
	margin-top:10px;
	margin-left:10px;
}
#fishinfo_edit_table tr{
	height:20px;
}
#fishinfo_edit_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#fishinfo_edit_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="fishinfo_edit_form">
	<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="fishinfo_edit_table">
			<tr>
				<td>鱼苗名称：</td>
				<td>
					<input class="easyui-textbox" id="fishinfo_edit_name" name="fishname" value="${ bean.fishname }"/>
				</td>
				<td>鱼苗别名：</td>
				<td>
					<input class="easyui-textbox" id="fishinfo_edit_breed_name" name="fishanother" value="${ bean.fishanother }"/>
				</td>
			</tr>
			<tr>
				<td>养殖环境：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="environment" value="${ bean.environment }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
    			<td>是否可用：</td>
    			<td>
    			    <select class="easyui-combobox" name="delete_flag"  select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'">
	    				<option value="0">可用</option>
	    				<option value="1">不可用</option>
    				</select>
    			</td>
    		</tr>
		</table>
	</form>

</body>
</html>
