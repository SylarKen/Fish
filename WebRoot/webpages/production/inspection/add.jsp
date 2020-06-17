<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#inspection_add_table{
	margin-top:10px;
	margin-left:10px;
}
#inspection_add_table tr{
	height:20px;
	padding-top: 20px;
	padding-bottom: 20px;
}
#inspection_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
	
}
#inspection_add_table td{
	padding-top:10px;
	
}
#inspection_add_table td:nth-child(even) input,select{
	width:160px;
}
</style>
	<form id="inspection_add_form">
		<table id="inspection_add_table">
			<tr >
				<td  >巡查池塘：</td>
				<td  >
					<input class="easyui-textbox" id="inspection_add_pondName" name="pondName" value="${ bean.name }"/>
					<input type="hidden" id="inspection_add_pondCode" name="pondCode" value="${ bean.code }"/>
				</td>
				<td> </td>
				<td>
					<!-- <input type="hidden"  class="easyui-textbox" id="inspection_add_foodName" name="foodName" />
					<input type="hidden" id="inspection_add_foodId" name="foodId" /> -->
				</td>
			</tr>
			<tr >
				<td >巡塘日期：</td>
				<td >
					<input class="easyui-datetimebox" name="inspect_time"  />
				</td>
				<td >天气：</td>
				<td >
					<input class="easyui-textbox" id="inspection_add_foodName" name="weather" />
				</td>
			</tr>
			<tr>
				<td>水质情况：</td>
				<td>
					<input class="easyui-textbox" name="water_quality" />
				</td>
				<td>采饵量：</td>
				<td>
					<input class="easyui-textbox" name="pick_amount" />
				</td>
			</tr>
			
			
			
			<tr>
				<td>鱼苗情况：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="fish_status" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
			<tr>
				<td>巡塘结果：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="result" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
			<tr>
				<td>巡塘备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
		</table>
	</form>
<script>

$(function(){
	$("#inspection_add_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#inspection_add_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#inspection_add_pondCode").val(row.code);
				$("#inspection_add_pondName").textbox("setValue", row.name);
			});			
		}
	});
});


</script>
</body>
</html>
