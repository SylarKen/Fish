<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#stocking_detail_table{
	margin-top:10px;
	margin-left:10px;
}
#stocking_detail_table tr{
	height:20px;
}
#stocking_detail_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#stocking_detail_table td{
	padding-top:10px;
	
}

#stocking_detail_table td:nth-child(even) input,select{
	width:160px;
}
</style>
	<form id="stocking_detail_form">
		<table id="stocking_detail_table">
		<tr >
				<td  >巡查池塘：</td>
				<td  >
					<input disabled class="easyui-textbox" id="inspection_edit_pondName" name="pondName" value="${ bean.pondName }"/>
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
					<input disabled class="easyui-datetimebox" name="inspect_time" value="${ bean.inspect_time }"  />
				</td>
				<td >天气：</td>
				<td >
					<input disabled class="easyui-textbox" id="inspection_add_foodName" name="weather" value="${ bean.weather }" />
				</td>
			</tr>
			<tr>
				<td>水质情况：</td>
				<td>
					<input disabled class="easyui-textbox" name="water_quality" value="${ bean.water_quality }" />
				</td>
				<td>采饵量：</td>
				<td>
					<input disabled class="easyui-textbox" name="pick_amount" value="${ bean.pick_amount }"  />
				</td>
			</tr>
			
			
			
			<tr>
				<td>鱼苗情况：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="fish_status" value="${ bean.fish_status }"  data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
			<tr>
				<td>巡塘结果：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="result" value="${ bean.result }" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
			<tr>
				<td>巡塘备注：</td>
				<td colspan="3">
					<input disabled  class="easyui-textbox" name="memo" value="${ bean.memo }" data-options="multiline:true" style="width:100%;height:60px" />
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
	$("#stocking_detail_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
});
</script>
</body>
</html>
