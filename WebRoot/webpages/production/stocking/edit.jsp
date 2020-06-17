<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#stocking_edit_table{
	margin-top:10px;
	margin-left:10px;
}
#stocking_edit_table tr{
	height:20px;
}
#stocking_edit_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#stocking_edit_table td{
	padding-top:10px;
	
}
#stocking_edit_table td:nth-child(even) input,select{
	width:160px;
}
</style>
	<form id="stocking_edit_form">
		<input type="hidden" name="id" value="${ bean.id }"/>
		<table id="stocking_edit_table">
			<tr >
				<td  >放养池塘：</td>
				<td  >
					<input class="easyui-textbox" id="stocking_edit_pondName" name="pondName" value="${ bean.pondName }"/>
					<input type="hidden" id="stocking_edit_pondCode" name="pondCode" value="${ bean.pondCode }"/>
				</td>
				<td> </td>
				<td>
					<!-- <input type="hidden"  class="easyui-textbox" id="stocking_edit_foodName" name="foodName" />
					<input type="hidden" id="stocking_edit_foodId" name="foodId" /> -->
				</td>
			</tr>
			<tr >
				<td >放养品种：</td>
				<td >
					<input class="easyui-textbox" id="stocking_edit_foodName" name="fishname" value='${ bean.fishname}' />
					<input type="hidden" id="stocking_edit_foodId" name="fishid" value='${ bean.fishid}' />
				</td>
				<td >放养日期：</td>
				<td >
					<input class="easyui-datetimebox" name="throwdate" data-options="editable:false" value='${ bean.throwdate}' />
				</td>
			</tr>
			<tr>
				<td>苗种来源：</td>
				<td>
					<input class="easyui-textbox" name="fishfrom" value='${ bean.fishfrom}' />
				</td>
				<td>苗种规格：</td>
				<td>
					<input class="easyui-textbox" name="standard" value='${ bean.standard}' />
				</td>
			</tr>
			<tr>
				<td>放养重量(kg)：</td>
				<td>
					<input class="easyui-textbox" name="weight" value='${ bean.weight}' />
				</td>
				<td>放养密度(只,尾/亩)：</td>
				<td>
					<input class="easyui-textbox" name="density" value='${ bean.density}' />
				</td>
			</tr>
			<tr>
				<td>检疫情况：</td>
				<td>
					<input class="easyui-textbox" name="quarantine" value='${ bean.quarantine}' />
				</td>
				<td>消毒情况：</td>
				<td>
					<input class="easyui-textbox" name="degassing" value='${ bean.degassing}' />
				</td>
			</tr>
			<tr>
				<td>水质参数：</td>
				<td>
					<input class="easyui-textbox" name="waterQuality"  value='${ bean.waterQuality}' />
				</td>
				<td>批次号：</td>
				<td>
					<input class="easyui-textbox" name="batchNumber" value='${ bean.batchNumber}' />
				</td>
			</tr>
			<tr>
				<td>放养备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" value='${ bean.memo}' data-options="multiline:true" style="width:100%;height:60px" />
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
	$("#stocking_edit_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#stocking_edit_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#stocking_edit_pondCode").val(row.code);
				$("#stocking_edit_pondName").textbox("setValue", row.name);
			});			
		}
	});
	$("#stocking_edit_foodName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			stocking_edit_showFoodDailog();
		}
	});
	//所有select下拉的初始化
	$("#stocking_edit_form select").each(function(i){
		$(this).children("option[value='"+ $(this).attr("select_value") +"']").attr("selected","selected");
	});
	//选择
	function stocking_edit_showFoodDailog(){
		var $stocking_edit_food_dialog = $("<div><div>");
		$stocking_edit_food_dialog.dialog({
			title : '选择',
			width : 600,
			height : 400,
			closed : true,
			cache : false,
			href : webContext + "fishinfo/select",
			queryParams : {selId : $("#stocking_edit_foodId").val()},
			modal : true,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					var selectRow = $("#fishinfo_list").datagrid("getSelected");
					if(!selectRow){
						$.messager.alert("温馨提示", "请选中一行记录");
						return;
					}
					$("#stocking_edit_foodId").val(selectRow.id);
					$("#stocking_edit_foodName").textbox("setValue", selectRow.name);
					$stocking_edit_food_dialog.dialog('destroy');
				}
			}, {
				text : '取消',
				iconCls : 'icon-cross',
				handler : function() {
					$stocking_edit_food_dialog.dialog('destroy');
				}
			} ],
			onClose:function(){
				$stocking_edit_food_dialog.dialog('destroy');
			}  
		});
		//初始化后打开对话框
		$stocking_edit_food_dialog.dialog('open');
	}
	
});


</script>
</body>
</html>
