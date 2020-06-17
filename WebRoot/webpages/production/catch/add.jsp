<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#catch_add_table{
	margin-top:10px;
	margin-left:10px;
}
#catch_add_table tr{
	height:20px;
}
#catch_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#catch_add_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="catch_add_form">
		<table id="catch_add_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input class="easyui-textbox" id="catch_add_pondName" name="pondName" value="${ bean.name }"/>
					<input type="hidden" id="catch_add_pondCode" name="pondCode" value="${ bean.code }"/>
				</td>
				<td>捕捞时间：</td>
				<td>
					<input class="easyui-datetimebox" name="catchTime" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>捕捞品种：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="breedName" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>捕捞方式：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="catchWay" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>捕捞数量：</td>
				<td>
					<input class="easyui-textbox" name="amount" />
				</td>
				<td>捕捞重量：</td>
				<td>
					<input class="easyui-textbox" name="weight" />
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
<script>

$(function(){
	$("#catch_add_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#catch_add_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#catch_add_pondCode").val(row.code);
				$("#catch_add_pondName").textbox("setValue", row.name);
			});			
		}
	});
});


</script>
</body>
</html>
