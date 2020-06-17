<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#catch_edit_table{
	margin-top:10px;
	margin-left:10px;
}
#catch_edit_table tr{
	height:20px;
}
#catch_edit_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#catch_edit_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="catch_edit_form">
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="catch_edit_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input class="easyui-textbox" id="catch_edit_pondName" name="pondName" value="${ bean.pondName }"/>
					<input type="hidden" id="catch_edit_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td>捕捞时间：</td>
				<td>
					<input class="easyui-datetimebox" name="catchTime" value="${ bean.catchTime }" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>捕捞品种：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="breedName" value="${ bean.breedName }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>捕捞方式：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="catchWay" value="${ bean.catchWay }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>捕捞数量：</td>
				<td>
					<input class="easyui-textbox" name="amount" value="${ bean.amount }"/>
				</td>
				<td>捕捞重量：</td>
				<td>
					<input class="easyui-textbox" name="weight" value="${ bean.weight }"/>
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
<script>

$(function(){
	//所有select下拉的初始化
	$("#catch_edit_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
	$("#catch_edit_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#catch_edit_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#catch_edit_pondCode").val(row.code);
				$("#catch_edit_pondName").textbox("setValue", row.name);
			});			
		}
	});
});


</script>
</body>
</html>
