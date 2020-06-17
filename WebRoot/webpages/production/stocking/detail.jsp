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
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="stocking_detail_table">
		<tr >
				<td  >放养池塘：</td>
				<td  >
					<input disabled class="easyui-textbox" id="stocking_edit_pondName" name="pondName" value="${ bean.pondName }"/>
				</td>
				<td>池塘面积(亩): </td>
				<td>
						<input disabled class="easyui-textbox" id="stocking_edit_pondArea" name="pondArea" value="${ bean.pondArea }"/>
				</td>
			</tr>
			<tr >
				<td >放养品种：</td>
				<td >
					<input disabled class="easyui-textbox" id="stocking_edit_foodName" name="fishname" value='${ bean.fishname}' />
				</td>
				<td >放养日期：</td>
				<td >
					<input disabled class="easyui-datetimebox" name="throwdate" data-options="editable:false" value='${ bean.throwdate}' />
				</td>
			</tr>
			<tr>
				<td>苗种来源：</td>
				<td>
					<input disabled class="easyui-textbox" name="fishfrom" value='${ bean.fishfrom}' />
				</td>
				<td>苗种规格：</td>
				<td>
					<input disabled class="easyui-textbox" name="standard" value='${ bean.standard}' />
				</td>
			</tr>
			<tr>
				<td>放养重量(kg)：</td>
				<td>
					<input disabled class="easyui-textbox" name="weight" value='${ bean.weight}' />
				</td>
				<td>放养密度(只,尾/亩)：</td>
				<td>
					<input disabled class="easyui-textbox" name="density" value='${ bean.density}' />
				</td>
			</tr>
			<tr>
				<td>检疫情况：</td>
				<td>
					<input disabled  class="easyui-textbox" name="quarantine" value='${ bean.quarantine}' />
				</td>
				<td>消毒情况：</td>
				<td>
					<input disabled class="easyui-textbox" name="degassing" value='${ bean.degassing}' />
				</td>
			</tr>
			<tr>
				<td>水质参数：</td>
				<td>
					<input disabled class="easyui-textbox" name="waterQuality"  value='${ bean.waterQuality}' />
				</td>
				<td>批次号：</td>
				<td>
					<input disabled class="easyui-textbox" name="batchNumber" value='${ bean.batchNumber}' />
				</td>
			</tr>
			<tr>
				<td>放养备注：</td>
				<td colspan="3">
					<input disabled class="easyui-textbox" name="memo" value='${ bean.memo}' data-options="multiline:true" style="width:100%;height:60px" />
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
