<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#food_edit_table{
	margin-top:10px;
	margin-left:10px;
}
#food_edit_table tr{
	height:20px;
}
#food_edit_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#food_edit_table td:nth-child(even) input,select{
	width:400px;
}
</style>
	<form id="food_edit_form">
	<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="food_edit_table">
			<tr>
				<td>饵料名称：</td>
				<td>
					<input class="easyui-textbox" id="food_edit_name" name="name" value="${ bean.name }"/>
				</td>
			</tr>
			<tr>
				<td>适宜鱼种：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="breedName" value="${ bean.breedName }" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
				<td>效果：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="effect" value="${ bean.effect }" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:100%;height:43px" />
				</td>
			</tr>
			<tr>
    			<td>是否可用：</td>
    			<td>
    			    <select class="easyui-combobox" name="delete_flag"  select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'" style="width:80px;">
	    				<option value="0">可用</option>
	    				<option value="1">不可用</option>
    				</select>
    			</td>
    		</tr>
		</table>
	</form>
<script>

$(function(){
	$("#food_edit_breed_name").textbox({
		buttonText: '查询',
		//required: true,
		editable: false,
		onClickButton: function() {
			alert("敬请期待(o^.^o)");
			$("#food_edit_breed_name").textbox("setValue", "黄花鱼");
			$("#food_edit_breed_code").val("2222");
			/* showSelectFoodDialog(null, function(selectRow){
				console.log(selectRow);
				$("#food_edit_breed_name").textbox("setValue", selectRow.prodName);
				$("#food_edit_breed_code").val(selectRow.standard);
			});
 */		}
	});
	
	//所有select下拉的初始化
	$("#food_edit_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
	
});


</script>
</body>
</html>
