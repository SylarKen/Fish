<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<style>
#video_add_table{
	margin-top:10px;
	margin-left:10px;
}
#video_add_table tr{
	height:20px;
}
#video_add_table td:nth-child(odd){
	padding-left:20px;
	text-align:right;
}

</style>
	<form id="video_add_form">
		<table id="video_add_table">
			<tr>
				<td>池塘：</td>
				<td>
					<input class="easyui-textbox" id="video_add_pondName" name="pondName" value="${ bean.name }" style="width:150px;"/>
					<input type="hidden" id="video_add_pondCode" name="pondCode" value="${ bean.code }"/>
				</td>
			</tr>
			<tr>
				<td>视频地址：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="videosrc" style="width:400px;" />
				</td>
			</tr>
			<tr>
				<td>缩略图地址：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="snapimg" style="width:400px;" />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<input class="easyui-textbox" name="memo" data-options="multiline:true" style="width:400px;height:60px" />
				</td>
			</tr>
		</table>
	</form>
<script>

$(function(){
	$("#video_add_pondName").textbox({
		buttonText: '查询',
		required: true,
		editable: false,
		onClickButton: function() {
			var checkedPondCode = $("#video_add_pondCode").val();
			showPondTreeDialog(1, checkedPondCode, function(rows){
				var row = rows[0];
				if(row.code.length < 7){
					$.messager.alert("温馨提示", "请选择池塘！");
					return true;//保持选择对话框
				}
				$("#video_add_pondCode").val(row.code);
				$("#video_add_pondName").textbox("setValue", row.name);
			});			
		}
	});
	
});


</script>
</body>
</html>
