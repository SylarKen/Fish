<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#inspection_edit_table{
	margin-top:10px;
	margin-left:10px;
}
#inspection_edit_table tr{
	height:20px;
}
#inspection_edit_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#inspection_edit_table td{
	padding-top:10px;
	
}
#inspection_edit_table td:nth-child(even) input,select{
	width:160px;
}
</style>
	<form id="inspection_edit_form">
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="inspection_edit_table">
			<tr >
				<td  >巡查池塘：</td>
				<td  >
					<input class="easyui-textbox" id="inspection_edit_pondName" name="pondName" value="${ bean.pondName }"/>
					<input type="hidden" id="inspection_edit_pondCode" name="pondCode" value="${ bean.pondCode }"/>
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
					<input class="easyui-datetimebox" name="inspect_time" value="${ bean.inspect_time }"  />
				</td>
				<td >天气：</td>
				<td >
					<input class="easyui-textbox" id="inspection_add_foodName" name="weather" value="${ bean.weather }" />
				</td>
			</tr>
			<tr>
				<td>水质情况：</td>
				<td>
					<input class="easyui-textbox" name="water_quality" value="${ bean.water_quality }" />
				</td>
				<td>采饵量：</td>
				<td>
					<input class="easyui-textbox" name="pick_amount" value="${ bean.pick_amount }"  />
				</td>
			</tr>
			
			
			
			<tr>
				<td>鱼苗情况：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="fish_status" value="${ bean.fish_status }"  data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
			<tr>
				<td>巡塘结果：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="result" value="${ bean.result }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
			<tr>
				<td>巡塘备注：</td>
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
	$("#inspection_edit_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#inspection_edit_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#inspection_edit_pondCode").val(row.code);
				$("#inspection_edit_pondName").textbox("setValue", row.name);
			});			
		}
	});
	$("#inspection_edit_foodName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			inspection_edit_showFoodDailog();
		}
	});
	//所有select下拉的初始化
	$("#inspection_edit_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
});


</script>
</body>
</html>
