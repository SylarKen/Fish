<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#catch_detail_table{
	margin-top:10px;
	margin-left:10px;
}
#catch_detail_table tr{
	height:20px;
}
#catch_detail_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#catch_detail_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="catch_detail_form">
		<table id="catch_detail_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input disabled class="easyui-textbox" id="catch_detail_pondName" name="pondName" value="${ bean.pondName }"/>
					<input disabled type="hidden" id="catch_detail_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td>捕捞时间：</td>
				<td>
					<input disabled class="easyui-datetimebox" name="catchTime" value="${ bean.catchTime }" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>捕捞品种：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="breedName" value="${ bean.breedName }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>捕捞方式：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="catchWay" value="${ bean.catchWay }" style="width:100%;" />
				</td>
			</tr>
			<tr>
				<td>捕捞数量：</td>
				<td>
					<input disabled class="easyui-textbox" name="amount" value="${ bean.amount }"/>
				</td>
				<td>捕捞重量：</td>
				<td>
					<input disabled class="easyui-textbox" name="weight" value="${ bean.weight }"/>
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
				<td>是否可用：</td>
    			<td>
    			    <select disabled class="easyui-combobox" name="delete_flag"  select_value='${ bean.delete_flag }'  data-options="panelHeight:'auto'">
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
	$("#catch_detail_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
});


</script>
</body>
</html>
