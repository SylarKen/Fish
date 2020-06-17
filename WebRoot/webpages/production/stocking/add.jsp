<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#stocking_add_table{
	margin-top:10px;
	margin-left:10px;
}
#stocking_add_table tr{
	height:20px;
	padding-top: 20px;
	padding-bottom: 20px;
}
#stocking_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
	
}
#stocking_add_table td{
	padding-top:10px;
	
}
#stocking_add_table td:nth-child(even) input,select{
	width:160px;
}
</style>
	<form id="stocking_add_form">
		<table id="stocking_add_table">
			<tr >
				<td  >放养池塘：</td>
				<td  >
					<input class="easyui-textbox" id="stocking_add_pondName" name="pondName" value="${ bean.name }"/>
					<input type="hidden" id="stocking_add_pondCode" name="pondCode" value="${ bean.code }"/>
				</td>
				<td> </td>
				<td>
					<!-- <input type="hidden"  class="easyui-textbox" id="stocking_add_foodName" name="foodName" />
					<input type="hidden" id="stocking_add_foodId" name="foodId" /> -->
				</td>
			</tr>
			<tr >
				<td >放养品种：</td>
				<td >
					<input class="easyui-textbox" id="stocking_add_foodName" name="fishname" />
					<input type="hidden" id="stocking_add_foodId" name="fishid" />
				</td>
				<td >放养日期：</td>
				<td >
					<input class="easyui-datetimebox" name="throwdate" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>苗种来源：</td>
				<td>
					<input class="easyui-textbox" name="fishfrom" />
				</td>
				<td>苗种规格：</td>
				<td>
					<input class="easyui-textbox" name="standard" />
				</td>
			</tr>
			<tr>
				<td>放养重量(kg)：</td>
				<td>
					<input class="easyui-textbox" name="weight" />
				</td>
				<td>放养密度(只,尾/亩)：</td>
				<td>
					<input class="easyui-textbox" name="density" />
				</td>
			</tr>
			<tr>
				<td>检疫情况：</td>
				<td>
					<input class="easyui-textbox" name="quarantine" />
				</td>
				<td>消毒情况：</td>
				<td>
					<input class="easyui-textbox" name="degassing" />
				</td>
			</tr>
			<tr>
				<td>水质参数：</td>
				<td>
					<input class="easyui-textbox" name="waterQuality" />
				</td>
				<td>批次号：</td>
				<td>
					<input class="easyui-textbox" name="batchNumber" />
				</td>
			</tr>
			<tr>
				<td>放养备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			
		</table>
	</form>
<script>

$(function(){
	$("#stocking_add_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#stocking_add_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#stocking_add_pondCode").val(row.code);
				$("#stocking_add_pondName").textbox("setValue", row.name);
			});			
		}
	});
	$("#stocking_add_foodName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			stocking_add_showFoodDailog();
		}
	});
	
	//选择
	function stocking_add_showFoodDailog(){
		var $stocking_add_food_dialog = $("<div><div>");
		$stocking_add_food_dialog.dialog({
			title : '选择',
			width : 800,
			height : 450,
			closed : true,
			cache : false,
			href : webContext + "fishinfo/select",
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
					$("#stocking_add_foodId").val(selectRow.id);
					$("#stocking_add_foodName").textbox("setValue", selectRow.fishname);
					$stocking_add_food_dialog.dialog('destroy');
				}
			}, {
				text : '取消',
				iconCls : 'icon-cross',
				handler : function() {
					$stocking_add_food_dialog.dialog('destroy');
				}
			} ],
			onClose:function(){
				$stocking_add_food_dialog.dialog('destroy');
			}  
		});
		//初始化后打开对话框
		$stocking_add_food_dialog.dialog('open');
	}
});


</script>
</body>
</html>
