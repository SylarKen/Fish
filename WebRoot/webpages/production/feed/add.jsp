<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#feed_add_table{
	margin-top:10px;
	margin-left:10px;
}
#feed_add_table tr{
	height:20px;
}
#feed_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}
#feed_add_table td:nth-child(even) input,select{
	width:150px;
}
</style>
	<form id="feed_add_form">
		<table id="feed_add_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input class="easyui-textbox" id="feed_add_pondName" name="pondName" value="${ bean.name }"/>
					<input type="hidden" id="feed_add_pondCode" name="pondCode" value="${ bean.code }"/>
				</td>
				<td>饵料：</td>
				<td>
					<input class="easyui-textbox" id="feed_add_foodName" name="foodName" />
					<input type="hidden" id="feed_add_foodId" name="foodId" />
				</td>
			</tr>
			<tr>
				<td>生产厂家：</td>
				<td>
					<input class="easyui-textbox" name="foodFactory" />
				</td>
				<td>批号/生产日期：</td>
				<td>
					<input class="easyui-textbox" name="foodPihao" />
				</td>
			</tr>
			<tr>
				<td>投饲量：</td>
				<td>
					<input class="easyui-textbox" name="feedAmount" />
				</td>
				<td>投饲时间：</td>
				<td>
					<input class="easyui-datetimebox" name="feedTime" data-options="editable:false" />
				</td>
			</tr>
			<tr>
				<td>摄食情况：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="sheShiQingKuang" data-options="multiline:true" style="width:100%;height:60px" />
				</td>
			</tr>
			<tr>
				<td>养殖密度：</td>
				<td>
					<input class="easyui-textbox" name="yangZhiMiDu" />
				</td>
				<td>光照情况：</td>
				<td>
					<input class="easyui-textbox" name="guangZhaoQiangDu" />
				</td>
			</tr>
			<tr>
				<td>水质：</td>
				<td>
					<input class="easyui-textbox" name="shuiZhi" />
				</td>
				<td>水温：</td>
				<td>
					<input class="easyui-textbox" name="shuiWen" />
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
	$("#feed_add_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#feed_add_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#feed_add_pondCode").val(row.code);
				$("#feed_add_pondName").textbox("setValue", row.name);
			});			
		}
	});
	$("#feed_add_foodName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			feed_add_showFoodDailog();
		}
	});
	
	//选择
	function feed_add_showFoodDailog(){
		var $feed_add_food_dialog = $("<div><div>");
		$feed_add_food_dialog.dialog({
			title : '选择',
			width : 600,
			height : 400,
			closed : true,
			cache : false,
			href : webContext + "food/select",
			modal : true,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					var selectRow = $("#food_select_list").datagrid("getSelected");
					if(!selectRow){
						$.messager.alert("温馨提示", "请选中一行记录");
						return;
					}
					$("#feed_add_foodId").val(selectRow.id);
					$("#feed_add_foodName").textbox("setValue", selectRow.name);
					$feed_add_food_dialog.dialog('destroy');
				}
			}, {
				text : '取消',
				iconCls : 'icon-cross',
				handler : function() {
					$feed_add_food_dialog.dialog('destroy');
				}
			} ],
			onClose:function(){
				$feed_add_food_dialog.dialog('destroy');
			}  
		});
		//初始化后打开对话框
		$feed_add_food_dialog.dialog('open');
	}
});


</script>
</body>
</html>
